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

Route::controller(\App\Http\Controllers\File_uploadController::class)->prefix('file_upload')->group(function () {
    Route::get('/view/{id}', 'view');
    Route::get('/download/{id}', 'download');
    Route::delete('/{id}', 'delete');
});

Route::middleware('auth:sanctum')->group(function () {

    Route::get('/me', function (Request $request) {
        return $request->user();
    });

    Route::controller(M_kontrakController::class)->prefix('kontrak')->group(function () {
        Route::get('/', 'index');
        Route::get('/search', 'search');
        Route::get('/details/{id}', 'details');
        Route::post('/', 'create');
        Route::put('/{id}', 'edit');
        Route::delete('/{id}', 'delete');
    });

    Route::controller(M_vesselController::class)->prefix('vessel')->group(function () {
        Route::get('/', 'index');
        Route::get('/search', 'search');
        Route::get('/details/{id}', 'details');
        Route::post('/', 'create');
        Route::put('/{id}', 'edit');
        Route::delete('/{id}', 'delete');

        Route::get('/kontrak/{id}', 'kontrak');
    });

    Route::controller(T_klaim_detailController::class)->prefix('klaim_detail')->group(function () {
        Route::get('/', 'index');
        Route::get('/details/{id}', 'details');
        Route::post('/', 'create');
        Route::put('/{id}', 'edit');
        Route::delete('/{id}', 'delete');
    });

    Route::controller(T_klaimController::class)->prefix('klaim')->group(function () {
        Route::get('/', 'index');
        Route::get('/search', 'search');
        Route::get('/details/{id}', 'details');
        Route::post('/', 'create');
        Route::put('/{id}', 'edit');
        Route::delete('/{id}', 'delete');
    });

    Route::controller(T_master_cableController::class)->prefix('cable')->group(function () {
        Route::get('/', 'index');
        Route::get('/search', 'search');
        Route::get('/refs', 'refs');
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
