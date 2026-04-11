<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class AuthController extends Controller
{
    private const ALLOWED_ROLES = ['approval', 'admin', 'superadmin'];

    private function ensureBaseRoles(): void
    {
        foreach (self::ALLOWED_ROLES as $roleName) {
            Role::findOrCreate($roleName, 'web');
        }
    }

    public function register(Request $request)
    {
        $this->ensureBaseRoles();

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'password' => 'required|string|min:8|confirmed',
            'role' => 'nullable|in:approval,admin,superadmin',
        ]);

        $user = DB::transaction(function () use ($validated) {
            $user = User::create([
                'name' => $validated['name'],
                'email' => $validated['email'],
                'password' => Hash::make($validated['password']),
            ]);

            $role = $validated['role'] ?? (User::count() === 1 ? 'superadmin' : 'approval');
            $user->syncRoles([$role]);

            return $user;
        });

        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json([
            'status' => true,
            'message' => 'Register berhasil',
            'user' => $user,
            'token' => $token,
        ], 201);
    }

    public function login(Request $request)
    {
        // Validasi input
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        // Cek login
        if (!Auth::attempt($request->only('email', 'password'))) {
            return response()->json([
                'message' => 'Email atau password salah'
            ], 401);
        }

        // Ambil user
        $user = Auth::user();
        $this->ensureBaseRoles();

        $user->tokens()->delete();

        // Generate token
        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json([
            'status' => true,
            'message' => 'Login berhasil',
            'user' => array_merge($user->toArray(), [
                'roles' => $user->getRoleNames()->values()->all(),
            ]),
            'token' => $token
        ]);
    }

    public function logout(Request $request)
    {
        $user = $request->user();

        if ($user) {
            $user->currentAccessToken()?->delete();
        }

        return response()->json([
            'status' => true,
            'message' => 'Logout berhasil',
        ]);
    }
}
