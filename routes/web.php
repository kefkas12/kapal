<?php

use App\Http\Controllers\T_doc_cargoController;
use App\Http\Controllers\T_klaimController;
use App\Http\Controllers\T_master_cableController;
use App\Http\Controllers\WebSessionController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/login', [WebSessionController::class, 'create'])->name('login');
Route::post('/login', [WebSessionController::class, 'store'])
    ->middleware('throttle:5,1')
    ->name('login.store');
Route::post('/logout', [WebSessionController::class, 'destroy'])
    ->middleware('auth:web')
    ->name('web.logout');

Route::get('/doc-cargo/import', [T_doc_cargoController::class, 'importPage'])
    ->name('doc-cargo.import.page');
Route::get('/doc-cargo/import-template', [T_doc_cargoController::class, 'importTemplate'])
    ->name('doc-cargo.import.template');
Route::get('/doc-cargo/import-source', [T_doc_cargoController::class, 'exportImportSource'])
    ->name('doc-cargo.import.source');
Route::post('/doc-cargo/import', [T_doc_cargoController::class, 'importExcelWeb'])
    ->middleware(['auth:sanctum', 'viewer.read-only'])
    ->name('doc-cargo.import.submit');
Route::post('/doc-cargo/refresh', [T_doc_cargoController::class, 'refreshWeb'])
    ->middleware(['auth:sanctum', 'viewer.read-only'])
    ->name('doc-cargo.refresh.submit');
Route::post('/doc-cargo/create-klaim-awal', [T_doc_cargoController::class, 'createKlaimAwalWeb'])
    ->middleware(['auth:sanctum', 'viewer.read-only'])
    ->name('doc-cargo.klaim-awal.submit');

Route::get('/cable/import', [T_master_cableController::class, 'importPage'])
    ->middleware('auth:web')
    ->name('cable.import.page');
Route::get('/cable/import-template', [T_master_cableController::class, 'importTemplate'])
    ->name('cable.import.template');
Route::get('/cable/import-source', [T_master_cableController::class, 'exportImportSource'])
    ->name('cable.import.source');
Route::post('/cable/import', [T_master_cableController::class, 'importExcelWeb'])
    ->middleware(['auth:sanctum', 'viewer.read-only'])
    ->name('cable.import.submit');

Route::get('/klaim/import', [T_klaimController::class, 'importPage'])
    ->name('klaim.import.page');
Route::get('/klaim/import-template', [T_klaimController::class, 'importTemplate'])
    ->name('klaim.import.template');
Route::get('/klaim/import-source', [T_klaimController::class, 'exportImportSource'])
    ->name('klaim.import.source');
Route::post('/klaim/import', [T_klaimController::class, 'importExcelWeb'])
    ->middleware(['auth:sanctum', 'viewer.read-only'])
    ->name('klaim.import.submit');
