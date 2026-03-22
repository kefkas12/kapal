<?php

namespace App\Http\Controllers;

use App\Models\T_master_cable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class T_master_cableController extends Controller
{
    public function index(Request $request)
    {
        $data = T_master_cable::get();

        return response()->json([
            'success' => true,
            'message' => 'Data T_master_cable berhasil diambil',
            'data'    => $data
        ]);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = T_master_cable::where('id', $id)->first();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details T_master_cable berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_master_cable = new T_master_cable();
            $t_master_cable->nama = $request->input('nama');
            $t_master_cable->nama_perusahaan = $request->input('nama_perusahaan');
            $t_master_cable->email = $request->input('email');
            $t_master_cable->nomor_handphone = $request->input('nomor_handphone');
            $t_master_cable->nomor_telepon = $request->input('nomor_telepon');
            $t_master_cable->fax = $request->input('fax');
            $t_master_cable->npwp = $request->input('npwp');
            $t_master_cable->user_id = Auth::id();
            $t_master_cable->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_master_cable berhasil ditambah'
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
            $t_master_cable = T_master_cable::where('id', $id)->firstOrFail();
            $t_master_cable->nama = $request->input('nama');
            $t_master_cable->nama_perusahaan = $request->input('nama_perusahaan');
            $t_master_cable->email = $request->input('email');
            $t_master_cable->nomor_handphone = $request->input('nomor_handphone');
            $t_master_cable->nomor_telepon = $request->input('nomor_telepon');
            $t_master_cable->fax = $request->input('fax');
            $t_master_cable->npwp = $request->input('npwp');
            $t_master_cable->user_id = Auth::id();
            $t_master_cable->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_master_cable berhasil diubah'
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
            $t_master_cable = T_master_cable::where('id', $id)->firstOrFail();
            $t_master_cable->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_master_cable berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
