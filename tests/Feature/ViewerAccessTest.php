<?php

namespace Tests\Feature;

use App\Http\Middleware\EnsureViewerIsReadOnly;
use App\Models\User;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Laravel\Sanctum\Sanctum;
use Spatie\Permission\Models\Role;
use Symfony\Component\HttpFoundation\Response;
use Tests\TestCase;

class ViewerAccessTest extends TestCase
{
    /** @param array<int, string> $roles */
    private function userWithRoles(array $roles): User
    {
        $user = User::factory()->make(['id' => 1]);
        $user->setRelation('roles', new Collection(array_map(
            fn (string $role): Role => new Role(['name' => $role, 'guard_name' => 'web']),
            $roles,
        )));

        return $user;
    }

    public function test_viewer_is_rejected_before_every_business_write_controller_runs(): void
    {
        Sanctum::actingAs($this->userWithRoles(['viewer']));
        $checked = 0;

        foreach (Route::getRoutes() as $route) {
            if (in_array($route->uri(), ['api/login', 'api/register', 'api/logout', 'api/user_role/change-password'], true)
                || ! str_starts_with($route->getActionName(), 'App\\Http\\Controllers\\')) {
                continue;
            }

            foreach (array_intersect($route->methods(), ['POST', 'PUT', 'PATCH', 'DELETE']) as $method) {
                $uri = '/'.preg_replace('/\{[^}]+\}/', '1', $route->uri());
                $this->json($method, $uri)->assertForbidden();
                $checked++;
            }
        }

        $this->assertGreaterThan(40, $checked);
    }

    public function test_viewer_can_read_identity_but_cannot_manage_users(): void
    {
        Sanctum::actingAs($this->userWithRoles(['viewer']));
        $this->getJson('/api/me')->assertOk()->assertJsonPath('roles.0', 'viewer');
        $this->getJson('/api/user_role/dashboard')->assertForbidden();
        $this->getJson('/api/user_role/users')->assertForbidden();
    }

    public function test_existing_writer_roles_pass_through_the_middleware(): void
    {
        foreach (['admin', 'approval', 'adminupload', 'superadmin'] as $role) {
            $request = Request::create('/business', 'POST');
            $request->setUserResolver(fn (): User => $this->userWithRoles([$role]));
            $response = (new EnsureViewerIsReadOnly)->handle($request, fn (): Response => response('allowed'));
            $this->assertSame(200, $response->getStatusCode());
        }
    }

    public function test_safe_requests_pass_through_for_viewer(): void
    {
        foreach (['GET', 'HEAD', 'OPTIONS'] as $method) {
            $request = Request::create('/business', $method);
            $request->setUserResolver(fn (): User => $this->userWithRoles(['viewer']));
            $response = (new EnsureViewerIsReadOnly)->handle($request, fn (): Response => response('readable'));
            $this->assertSame(200, $response->getStatusCode());
        }
    }

    public function test_viewer_with_legacy_additional_roles_still_cannot_write(): void
    {
        Sanctum::actingAs($this->userWithRoles(['viewer', 'superadmin']));
        $this->putJson('/api/grade/1')->assertForbidden();
    }

    public function test_guest_cannot_delete_files_or_submit_web_imports(): void
    {
        $this->deleteJson('/api/file_upload/1')->assertUnauthorized();
        foreach (['/cable/import', '/doc-cargo/import', '/doc-cargo/refresh', '/doc-cargo/create-klaim-awal', '/klaim/import'] as $uri) {
            $this->postJson($uri)->assertUnauthorized();
        }
    }
}
