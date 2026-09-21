<?php

namespace Tests\Feature;

use App\Http\Middleware\EnsureViewerIsReadOnly;
use App\Models\User;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Schema;
use Laravel\Sanctum\Sanctum;
use PHPUnit\Framework\Attributes\DataProvider;
use Spatie\Permission\Models\Role;
use Symfony\Component\HttpFoundation\Response;
use Tests\TestCase;

class ViewerRoleTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        if (! in_array('sqlite', \PDO::getAvailableDrivers(), true)) {
            $this->markTestSkipped('Driver PDO SQLite tidak tersedia pada environment ini.');
        }

        foreach ([
            '0001_01_01_000000_create_users_table.php',
            '2026_03_22_104441_create_personal_access_tokens_table.php',
            '2026_04_03_202048_create_permission_tables.php',
        ] as $migration) {
            (require database_path('migrations/'.$migration))->up();
        }

        foreach (['viewer', 'admin', 'approval', 'adminupload', 'superadmin'] as $role) {
            Role::findOrCreate($role, 'web');
        }

        Schema::create('m_grade', function (Blueprint $table): void {
            $table->id();
            $table->string('grade');
            $table->string('price_bbl')->nullable();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->timestamps();
        });
        DB::table('m_grade')->insert(['id' => 1, 'grade' => 'TEST', 'price_bbl' => '100']);
    }

    private function userWithRole(string $role): User
    {
        $user = User::factory()->create();
        $user->assignRole($role);

        return $user;
    }

    public function test_viewer_cannot_call_any_business_write_endpoint(): void
    {
        Sanctum::actingAs($this->userWithRole('viewer'));
        $checked = 0;

        foreach (Route::getRoutes() as $route) {
            if (in_array($route->uri(), ['api/login', 'api/register', 'api/logout', 'api/user_role/change-password'], true)) {
                continue;
            }

            if (! str_starts_with($route->getActionName(), 'App\\Http\\Controllers\\')) {
                continue;
            }

            foreach (array_intersect($route->methods(), ['POST', 'PUT', 'PATCH', 'DELETE']) as $method) {
                $uri = '/'.preg_replace('/\{[^}]+\}/', '1', $route->uri());
                $this->json($method, $uri, ['grade' => 'CHANGED'])->assertForbidden();
                $checked++;
            }
        }

        $this->assertGreaterThan(40, $checked);
        $this->assertDatabaseHas('m_grade', ['id' => 1, 'grade' => 'TEST', 'price_bbl' => '100']);
    }

    public function test_viewer_can_read_search_and_fetch_data_for_export(): void
    {
        Sanctum::actingAs($this->userWithRole('viewer'));

        $this->getJson('/api/grade?per_page=100&sort_by=grade&sort_dir=asc')->assertOk()->assertJsonPath('data.0.grade', 'TEST');
        $this->getJson('/api/grade/search?search=TEST')->assertOk()->assertJsonPath('meta.total', 1);
        $this->getJson('/api/grade/details/1')->assertOk()->assertJsonPath('data.grade', 'TEST');
        $this->getJson('/api/me')->assertOk()->assertJsonPath('roles.0', 'viewer');
    }

    public function test_viewer_can_preview_and_download_files(): void
    {
        Sanctum::actingAs($this->userWithRole('viewer'));
        Schema::create('file_upload', function (Blueprint $table): void {
            $table->id();
            $table->string('nama_file');
        });
        $relativePath = 'viewer-test-'.bin2hex(random_bytes(8)).'.pdf';
        $path = public_path('storage/'.$relativePath);
        file_put_contents($path, '%PDF-1.4 viewer test');
        DB::table('file_upload')->insert(['id' => 1, 'nama_file' => $relativePath]);

        try {
            $this->get('/api/file_upload/view/1')->assertOk()->assertHeader('Content-Type', 'application/pdf');
            $this->get('/api/file_upload/download/1')->assertOk()->assertDownload($relativePath);
            $this->deleteJson('/api/file_upload/1')->assertForbidden();
            $this->assertFileExists($path);
            $this->assertDatabaseHas('file_upload', ['id' => 1]);
        } finally {
            unlink($path);
        }
    }

    public function test_viewer_can_change_own_password_and_logout(): void
    {
        $user = $this->userWithRole('viewer');
        Sanctum::actingAs($user);

        $this->postJson('/api/user_role/change-password', [
            'current_password' => 'password',
            'new_password' => 'new-password',
            'new_password_confirmation' => 'new-password',
        ])->assertOk();
        $this->assertTrue(Hash::check('new-password', $user->fresh()->password));
        $this->postJson('/api/logout')->assertOk();
    }

    public function test_viewer_cannot_access_user_management(): void
    {
        Sanctum::actingAs($this->userWithRole('viewer'));
        $this->getJson('/api/user_role/users')->assertForbidden();
        $this->getJson('/api/user_role/dashboard')->assertForbidden();
    }

    public function test_superadmin_can_create_and_assign_viewer_and_list_the_role(): void
    {
        Sanctum::actingAs($this->userWithRole('superadmin'));
        $this->getJson('/api/user_role/dashboard')->assertOk()->assertJsonFragment(['name' => 'viewer']);
        $this->getJson('/api/user_role/users')->assertOk()->assertJsonFragment(['roles' => ['approval', 'admin', 'adminupload', 'superadmin', 'viewer']]);
        $this->postJson('/api/user_role/users', [
            'email' => 'viewer@example.com', 'password' => 'password123', 'role' => 'viewer',
        ])->assertOk()->assertJsonPath('data.roles.0', 'viewer');

        $user = $this->userWithRole('admin');
        $this->putJson('/api/user_role/users/'.$user->id.'/role', ['role' => 'viewer'])->assertOk()->assertJsonPath('data.roles', ['viewer']);
        $this->assertTrue($user->fresh()->hasExactRoles(['viewer']));
    }

    #[DataProvider('writerRoles')]
    public function test_existing_roles_keep_their_crud_access(string $role): void
    {
        Sanctum::actingAs($this->userWithRole($role));
        $this->postJson('/api/grade', ['grade' => 'NEW', 'price_bbl' => '50'])->assertOk();
        $this->putJson('/api/grade/1', ['grade' => 'UPDATED', 'price_bbl' => '200'])->assertOk();
        $this->deleteJson('/api/grade/1')->assertOk();
    }

    /** @return array<string, array{string}> */
    public static function writerRoles(): array
    {
        return [
            'admin' => ['admin'], 'approval' => ['approval'],
            'adminupload' => ['adminupload'], 'superadmin' => ['superadmin'],
        ];
    }

    public function test_guest_cannot_delete_files_or_use_web_write_routes(): void
    {
        $this->deleteJson('/api/file_upload/1')->assertUnauthorized();
        foreach (['/cable/import', '/doc-cargo/import', '/doc-cargo/refresh', '/doc-cargo/create-klaim-awal', '/klaim/import'] as $uri) {
            $this->postJson($uri)->assertUnauthorized();
        }
    }

    public function test_registration_cannot_be_used_to_choose_a_privileged_role(): void
    {
        $this->userWithRole('superadmin');
        foreach (['superadmin', 'admin', 'approval', 'adminupload'] as $role) {
            $this->postJson('/api/register', [
                'name' => 'New User', 'email' => 'register@example.com',
                'password' => 'password123', 'password_confirmation' => 'password123', 'role' => $role,
            ])->assertUnprocessable()->assertJsonValidationErrors('role');
        }
        $this->postJson('/api/register', [
            'name' => 'New Viewer', 'email' => 'register@example.com',
            'password' => 'password123', 'password_confirmation' => 'password123',
        ])->assertCreated();
        $this->assertTrue(User::where('email', 'register@example.com')->firstOrFail()->hasExactRoles(['viewer']));
    }

    public function test_viewer_takes_precedence_over_an_additional_writer_role(): void
    {
        $user = $this->userWithRole('viewer');
        $user->assignRole('superadmin');
        Sanctum::actingAs($user);
        $this->putJson('/api/grade/1', ['grade' => 'CHANGED'])->assertForbidden();
    }

    public function test_read_only_middleware_allows_safe_methods_for_viewer(): void
    {
        $user = $this->userWithRole('viewer');
        foreach (['GET', 'HEAD', 'OPTIONS'] as $method) {
            $request = Request::create('/business', $method);
            $request->setUserResolver(fn (): User => $user);
            $response = (new EnsureViewerIsReadOnly)->handle($request, fn (): Response => response('readable'));
            $this->assertSame(200, $response->getStatusCode());
        }
    }
}
