<?php

use App\Http\Controllers\T_doc_cargoController;
use App\Http\Controllers\T_klaimController;
use App\Http\Controllers\T_master_cableController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/doc-cargo/import', [T_doc_cargoController::class, 'importPage'])
    ->name('doc-cargo.import.page');
Route::get('/doc-cargo/import-template', [T_doc_cargoController::class, 'importTemplate'])
    ->name('doc-cargo.import.template');
Route::get('/doc-cargo/import-source', [T_doc_cargoController::class, 'exportImportSource'])
    ->name('doc-cargo.import.source');
Route::post('/doc-cargo/import', [T_doc_cargoController::class, 'importExcelWeb'])
    ->name('doc-cargo.import.submit');
Route::post('/doc-cargo/refresh', [T_doc_cargoController::class, 'refreshWeb'])
    ->name('doc-cargo.refresh.submit');
Route::post('/doc-cargo/create-klaim-awal', [T_doc_cargoController::class, 'createKlaimAwalWeb'])
    ->name('doc-cargo.klaim-awal.submit');

Route::get('/cable/import', [T_master_cableController::class, 'importPage'])
    ->name('cable.import.page');
Route::get('/cable/import-template', [T_master_cableController::class, 'importTemplate'])
    ->name('cable.import.template');
Route::get('/cable/import-source', [T_master_cableController::class, 'exportImportSource'])
    ->name('cable.import.source');
Route::post('/cable/import', [T_master_cableController::class, 'importExcelWeb'])
    ->name('cable.import.submit');

Route::get('/klaim/import', [T_klaimController::class, 'importPage'])
    ->name('klaim.import.page');
Route::get('/klaim/import-template', [T_klaimController::class, 'importTemplate'])
    ->name('klaim.import.template');
Route::get('/klaim/import-source', [T_klaimController::class, 'exportImportSource'])
    ->name('klaim.import.source');
Route::post('/klaim/import', [T_klaimController::class, 'importExcelWeb'])
    ->name('klaim.import.submit');
