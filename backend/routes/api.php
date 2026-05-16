<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\AccessProfileController;
use Illuminate\Support\Facades\Route;

Route::prefix('auth')->group(function () {
    Route::post('login',   [AuthController::class, 'login']);
    Route::post('logout',  [AuthController::class, 'logout'])->middleware('auth:api');
    Route::post('refresh', [AuthController::class, 'refresh'])->middleware('auth:api');
    Route::get('me',       [AuthController::class, 'me'])->middleware('auth:api');
});

Route::middleware('auth:api')->group(function () {

    // ── Módulos do sistema (todos os usuários autenticados) ──────────────────
    Route::get('access-profiles/modules', [AccessProfileController::class, 'modules']);

    // ── CRUD de Perfis de Acesso (somente Admin) ─────────────────────────────
    Route::middleware('admin')->group(function () {
        Route::get   ('access-profiles',                             [AccessProfileController::class, 'index']);
        Route::post  ('access-profiles',                             [AccessProfileController::class, 'store']);
        Route::get   ('access-profiles/{accessProfile}',            [AccessProfileController::class, 'show']);
        Route::put   ('access-profiles/{accessProfile}',            [AccessProfileController::class, 'update']);
        Route::delete('access-profiles/{accessProfile}',            [AccessProfileController::class, 'destroy']);
        Route::patch ('access-profiles/{accessProfile}/toggle-active', [AccessProfileController::class, 'toggleActive']);
    });
});
