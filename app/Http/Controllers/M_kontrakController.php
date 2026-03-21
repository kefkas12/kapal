<?php

namespace App\Http\Controllers;

use App\Models\M_kontrak;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class M_kontrakController extends Controller
{
    public function index(Request $request)
    {
        $data = M_kontrak::get();

        return response()->json([
            'success' => true,
            'message' => 'Data M_kontrak berhasil diambil',
            'data'    => $data
        ]);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = M_kontrak::where('id', $id)
            ->first();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details M_kontrak berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $m_kontrak = new M_kontrak();
            $m_kontrak->nama = $request->input('nama');
            $m_kontrak->nama_perusahaan = $request->input('nama_perusahaan');
            $m_kontrak->email = $request->input('email');
            $m_kontrak->nomor_handphone = $request->input('nomor_handphone');
            $m_kontrak->nomor_telepon = $request->input('nomor_telepon');
            $m_kontrak->fax = $request->input('fax');
            $m_kontrak->npwp = $request->input('npwp');
            $m_kontrak->tipe = 'm_kontrak';
            $m_kontrak->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_kontrak berhasil ditambah'
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
            $m_kontrak = M_kontrak::where('id', $id)->firstOrFail();
            $m_kontrak->nama = $request->input('nama');
            $m_kontrak->nama_perusahaan = $request->input('nama_perusahaan');
            $m_kontrak->email = $request->input('email');
            $m_kontrak->nomor_handphone = $request->input('nomor_handphone');
            $m_kontrak->nomor_telepon = $request->input('nomor_telepon');
            $m_kontrak->fax = $request->input('fax');
            $m_kontrak->npwp = $request->input('npwp');
            $m_kontrak->tipe = 'm_kontrak';
            $m_kontrak->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_kontrak berhasil diubah'
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
            $m_kontrak = M_kontrak::where('id', $id)->firstOrFail();
            $m_kontrak->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_kontrak berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
