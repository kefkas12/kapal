<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\M_kontrakController;
use App\Http\Controllers\M_vesselController;
use App\Http\Controllers\T_klaim_detailController;
use App\Http\Controllers\T_klaimController;
use App\Http\Controllers\T_master_cableController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::options('{any}', function () {
    return response()->json([], 200);
})->where('any', '.*');

Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

Route::middleware('auth:sanctum')->group(function () {

    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::controller(M_kontrakController::class)->prefix('m_kontrak')->group(function () {
        Route::get('/', 'index');
        Route::get('/details/{id}', 'details');
        Route::post('/', 'create');
        Route::put('/{id}', 'edit');
        Route::delete('/{id}', 'delete');
    });

    Route::controller(M_vesselController::class)->prefix('m_vessel')->group(function () {
        Route::get('/', 'index');
        Route::get('/details/{id}', 'details');
        Route::post('/', 'create');
        Route::put('/{id}', 'edit');
        Route::delete('/{id}', 'delete');
    });

    Route::controller(T_klaim_detailController::class)->prefix('t_klaim_detail')->group(function () {
        Route::get('/', 'index');
        Route::get('/details/{id}', 'details');
        Route::post('/', 'create');
        Route::put('/{id}', 'edit');
        Route::delete('/{id}', 'delete');
    });

    Route::controller(T_klaimController::class)->prefix('t_klaim')->group(function () {
        Route::get('/', 'index');
        Route::get('/details/{id}', 'details');
        Route::post('/', 'create');
        Route::put('/{id}', 'edit');
        Route::delete('/{id}', 'delete');
    });

    Route::controller(T_master_cableController::class)->prefix('t_master_cable')->group(function () {
        Route::get('/', 'index');
        Route::get('/details/{id}', 'details');
        Route::post('/', 'create');
        Route::put('/{id}', 'edit');
        Route::delete('/{id}', 'delete');
    });

    Route::post('/logout', [AuthController::class, 'logout']);

});

// Route::get('/ping', function () {
//     return 'ok';
// });