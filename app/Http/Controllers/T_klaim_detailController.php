<?php

namespace App\Http\Controllers;

use App\Models\T_klaim_detail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class T_klaim_detailController extends Controller
{
    public function index(Request $request)
    {
        $data = T_klaim_detail::get();

        return response()->json([
            'success' => true,
            'message' => 'Data T_klaim_detail berhasil diambil',
            'data'    => $data
        ]);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = T_klaim_detail::where('id', $id)->first();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details T_klaim_detail berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_klaim_detail = new T_klaim_detail();
            $t_klaim_detail->id_klaim = $request->input('id_klaim');
            $t_klaim_detail->id_cable = $request->input('id_cable');
            $t_klaim_detail->id_kontrak = $request->input('id_kontrak');
            $t_klaim_detail->no_urut = $request->input('no_urut');
            $t_klaim_detail->no_voyage_gab = $request->input('no_voyage_gab');
            $t_klaim_detail->no_kontrak = $request->input('no_kontrak');
            $t_klaim_detail->val_potensi = $request->input('val_potensi');
            $t_klaim_detail->val_klaim_awal = $request->input('val_klaim_awal');
            $t_klaim_detail->val_klaim_akhir = $request->input('val_klaim_akhir');
            $t_klaim_detail->kurs = $request->input('kurs');
            $t_klaim_detail->val_klaim_akhir_idr = $request->input('val_klaim_akhir_idr');
            $t_klaim_detail->keterangan = $request->input('keterangan');
            $t_klaim_detail->no_tagihan_klaim = $request->input('no_tagihan_klaim');
            $t_klaim_detail->no_tagihan_dipotong = $request->input('no_tagihan_dipotong');
            $t_klaim_detail->status = $request->input('status');
            $t_klaim_detail->user_id = Auth::id();
            $t_klaim_detail->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim_detail berhasil ditambah'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function edit(Request $request)
    {
        $id = $request->route('id');

        try {
            DB::beginTransaction();
            $t_klaim_detail = T_klaim_detail::where('id', $id)->firstOrFail();
            $t_klaim_detail->id_klaim = $request->input('id_klaim');
            $t_klaim_detail->id_cable = $request->input('id_cable');
            $t_klaim_detail->id_kontrak = $request->input('id_kontrak');
            $t_klaim_detail->no_urut = $request->input('no_urut');
            $t_klaim_detail->no_voyage_gab = $request->input('no_voyage_gab');
            $t_klaim_detail->no_kontrak = $request->input('no_kontrak');
            $t_klaim_detail->val_potensi = $request->input('val_potensi');
            $t_klaim_detail->val_klaim_awal = $request->input('val_klaim_awal');
            $t_klaim_detail->val_klaim_akhir = $request->input('val_klaim_akhir');
            $t_klaim_detail->kurs = $request->input('kurs');
            $t_klaim_detail->val_klaim_akhir_idr = $request->input('val_klaim_akhir_idr');
            $t_klaim_detail->keterangan = $request->input('keterangan');
            $t_klaim_detail->no_tagihan_klaim = $request->input('no_tagihan_klaim');
            $t_klaim_detail->no_tagihan_dipotong = $request->input('no_tagihan_dipotong');
            $t_klaim_detail->status = $request->input('status');
            $t_klaim_detail->user_id = Auth::id();
            $t_klaim_detail->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim_detail berhasil diubah'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function delete(Request $request)
    {
        $id = $request->route('id');

        try {
            DB::beginTransaction();
            $t_klaim_detail = T_klaim_detail::where('id', $id)->firstOrFail();
            $t_klaim_detail->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim_detail berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
