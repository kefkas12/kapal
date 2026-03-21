<?php

namespace App\Http\Controllers;

use App\Models\T_klaim_detail;
use Illuminate\Http\Request;
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

        $data = T_klaim_detail::where('id', $id)
            ->first();
        
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
            $t_klaim_detail->nama = $request->input('nama');
            $t_klaim_detail->nama_perusahaan = $request->input('nama_perusahaan');
            $t_klaim_detail->email = $request->input('email');
            $t_klaim_detail->nomor_handphone = $request->input('nomor_handphone');
            $t_klaim_detail->nomor_telepon = $request->input('nomor_telepon');
            $t_klaim_detail->fax = $request->input('fax');
            $t_klaim_detail->npwp = $request->input('npwp');
            $t_klaim_detail->tipe = 't_klaim_detail';
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
            $t_klaim_detail->nama = $request->input('nama');
            $t_klaim_detail->nama_perusahaan = $request->input('nama_perusahaan');
            $t_klaim_detail->email = $request->input('email');
            $t_klaim_detail->nomor_handphone = $request->input('nomor_handphone');
            $t_klaim_detail->nomor_telepon = $request->input('nomor_telepon');
            $t_klaim_detail->fax = $request->input('fax');
            $t_klaim_detail->npwp = $request->input('npwp');
            $t_klaim_detail->tipe = 't_klaim_detail';
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
