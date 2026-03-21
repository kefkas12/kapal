<?php

namespace App\Http\Controllers;

use App\Models\T_klaim;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class T_klaimController extends Controller
{
    public function index(Request $request)
    {
        $data = T_klaim::get();

        return response()->json([
            'success' => true,
            'message' => 'Data T_klaim berhasil diambil',
            'data'    => $data
        ]);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = T_klaim::where('id', $id)
            ->first();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details T_klaim berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_klaim = new T_klaim();
            $t_klaim->nama = $request->input('nama');
            $t_klaim->nama_perusahaan = $request->input('nama_perusahaan');
            $t_klaim->email = $request->input('email');
            $t_klaim->nomor_handphone = $request->input('nomor_handphone');
            $t_klaim->nomor_telepon = $request->input('nomor_telepon');
            $t_klaim->fax = $request->input('fax');
            $t_klaim->npwp = $request->input('npwp');
            $t_klaim->tipe = 't_klaim';
            $t_klaim->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim berhasil ditambah'
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
            $t_klaim = T_klaim::where('id', $id)->firstOrFail();
            $t_klaim->nama = $request->input('nama');
            $t_klaim->nama_perusahaan = $request->input('nama_perusahaan');
            $t_klaim->email = $request->input('email');
            $t_klaim->nomor_handphone = $request->input('nomor_handphone');
            $t_klaim->nomor_telepon = $request->input('nomor_telepon');
            $t_klaim->fax = $request->input('fax');
            $t_klaim->npwp = $request->input('npwp');
            $t_klaim->tipe = 't_klaim';
            $t_klaim->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim berhasil diubah'
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
            $t_klaim = T_klaim::where('id', $id)->firstOrFail();
            $t_klaim->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
