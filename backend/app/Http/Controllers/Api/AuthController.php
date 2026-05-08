<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'credential' => 'required|string',
            'password' => 'required|string',
        ]);
        $field = filter_var($request->credential, FILTER_VALIDATE_EMAIL) ? 'email' : 'cpf';
        $credentials = [$field => $request->credential,
            'password' => $request->password,
            ];
            if (!$token = Auth::attempt($credentials)){
                return response()-> json(['message' => 'Credenciais inválidas'], 401);

            }
            return $this->respondWithToken($token);
    }

    public function me()
    {
        return response()->json(Auth::user());
    }
    public function logout()
    {
        Auth::logout();
        return response()->json(['message' => 'Logout realizado com sucesso']);
    }
    public function refresh()
    {
        return $this->respondWithToken(Auth::refresh());
    }
    private function respondWithToken($token)
    {
        $user = Auth::user();
        return response()->json([
            'token' => $token,
            'token_type'=>'bearer',
            'expires_in' => config('jwt.ttl') * 60,
            'user' => [
                'name' => $user->name,
                'cpf' => $user->cpf,
                'email' => $user->email,
                'phone' => $user->phone,
                'role' => $user->role,
                'administrative_unit' => $user->administrative_unit,
            ],
        ]);
    }
}
