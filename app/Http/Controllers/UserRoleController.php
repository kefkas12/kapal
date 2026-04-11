<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;
use Spatie\Permission\Models\Role;

class UserRoleController extends Controller
{
    private const ALLOWED_ROLES = ['approval', 'admin', 'superadmin'];

    private function ensureBaseRoles(): void
    {
        foreach (self::ALLOWED_ROLES as $roleName) {
            Role::findOrCreate($roleName, 'web');
        }
    }

    private function userData(User $user): array
    {
        return [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'roles' => $user->getRoleNames()->values()->all(),
            'created_at' => $user->created_at,
            'updated_at' => $user->updated_at,
        ];
    }

    private function canManageUsers(): bool
    {
        $user = Auth::user();
        if (!$user) {
            return false;
        }

        if ($user->hasRole('superadmin') || $user->hasRole('admin')) {
            return true;
        }

        // Bootstrap mode: jika belum ada assignment role sama sekali, izinkan user login pertama mengelola user-role.
        $hasAnyAssignedRole = DB::table('model_has_roles')->exists();
        return !$hasAnyAssignedRole;
    }

    public function dashboardData()
    {
        if (!$this->canManageUsers()) {
            return response()->json([
                'success' => false,
                'message' => 'Anda tidak punya akses untuk melihat dashboard role.'
            ], 403);
        }

        $this->ensureBaseRoles();

        $roles = Role::query()
            ->whereIn('name', self::ALLOWED_ROLES)
            ->orderByRaw("FIELD(name, 'approval', 'admin', 'superadmin')")
            ->get();

        $roleIds = $roles->pluck('id')->all();

        $roleHasPermissions = DB::table('role_has_permissions')
            ->whereIn('role_id', $roleIds)
            ->orderBy('role_id')
            ->orderBy('permission_id')
            ->get();

        $modelHasPermissions = DB::table('model_has_permissions')
            ->orderBy('permission_id')
            ->orderBy('model_id')
            ->get();

        $modelHasRoles = DB::table('model_has_roles')
            ->whereIn('role_id', $roleIds)
            ->orderBy('role_id')
            ->orderBy('model_id')
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Data role dan relasi berhasil diambil',
            'data' => [
                'allowed_roles' => self::ALLOWED_ROLES,
                'roles' => $roles,
                'role_has_permissions' => $roleHasPermissions,
                'model_has_permissions' => $modelHasPermissions,
                'model_has_roles' => $modelHasRoles,
            ],
        ]);
    }

    public function users()
    {
        if (!$this->canManageUsers()) {
            return response()->json([
                'success' => false,
                'message' => 'Anda tidak punya akses untuk melihat data user.'
            ], 403);
        }

        $this->ensureBaseRoles();

        $users = User::query()
            ->with('roles:id,name')
            ->orderBy('id', 'desc')
            ->get()
            ->map(fn (User $user) => $this->userData($user));

        return response()->json([
            'success' => true,
            'message' => 'Data user berhasil diambil',
            'data' => $users,
            'roles' => self::ALLOWED_ROLES,
        ]);
    }

    public function createUser(Request $request)
    {
        $this->ensureBaseRoles();

        if (!$this->canManageUsers()) {
            return response()->json([
                'success' => false,
                'message' => 'Anda tidak punya akses untuk menambah user.'
            ], 403);
        }

        $validated = $request->validate([
            'email' => ['required', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'string', 'min:8'],
            'role' => ['required', Rule::in(self::ALLOWED_ROLES)],
            'name' => ['nullable', 'string', 'max:255'],
        ]);

        $name = $validated['name'] ?? strtok($validated['email'], '@');
        if (!$name) {
            $name = $validated['email'];
        }

        $user = DB::transaction(function () use ($validated, $name) {
            $user = User::create([
                'name' => $name,
                'email' => $validated['email'],
                'password' => Hash::make($validated['password']),
            ]);

            // 1 user hanya boleh 1 role.
            $user->syncRoles([$validated['role']]);

            return $user;
        });

        return response()->json([
            'success' => true,
            'message' => 'User berhasil ditambah',
            'data' => $this->userData($user->fresh('roles')),
        ]);
    }

    public function assignRole(Request $request, int $id)
    {
        $this->ensureBaseRoles();

        if (!$this->canManageUsers()) {
            return response()->json([
                'success' => false,
                'message' => 'Anda tidak punya akses untuk assign role.'
            ], 403);
        }

        $validated = $request->validate([
            'role' => ['required', Rule::in(self::ALLOWED_ROLES)],
        ]);

        $user = User::query()->findOrFail($id);
        $user->syncRoles([$validated['role']]);

        return response()->json([
            'success' => true,
            'message' => 'Role user berhasil diubah',
            'data' => $this->userData($user->fresh('roles')),
        ]);
    }

    public function changeMyPassword(Request $request)
    {
        $validated = $request->validate([
            'current_password' => ['required', 'string'],
            'new_password' => ['required', 'string', 'min:8', 'different:current_password', 'confirmed'],
        ]);

        /** @var User|null $user */
        $user = Auth::user();
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User tidak ditemukan.'
            ], 401);
        }

        if (!Hash::check($validated['current_password'], $user->password)) {
            throw ValidationException::withMessages([
                'current_password' => 'Password saat ini tidak cocok.',
            ]);
        }

        $user->password = Hash::make($validated['new_password']);
        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Password berhasil diubah.',
        ]);
    }
}
