<?php

namespace App\Http\Controllers;

use App\Models\M_kontrak;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
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

        $data = M_kontrak::where('id', $id)->first();
        
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
            $m_kontrak->no_kontrak = $request->input('no_kontrak');
            $m_kontrak->kode_vessel = $request->input('kode_vessel');
            $m_kontrak->tgl_awal_kontrak = $request->input('tgl_awal_kontrak');
            $m_kontrak->tgl_akhir_kontrak = $request->input('tgl_akhir_kontrak');
            $m_kontrak->charter_rate = $request->input('charter_rate');
            $m_kontrak->speed = $request->input('speed');
            $m_kontrak->me_ballast = $request->input('me_ballast');
            $m_kontrak->me_laden = $request->input('me_laden');
            $m_kontrak->pumping_rate = $request->input('pumping_rate');
            $m_kontrak->status = $request->input('status');
            $m_kontrak->file_upload = $request->input('file_upload');
            $m_kontrak->user_id = Auth::id();
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
            $m_kontrak->no_kontrak = $request->input('no_kontrak');
            $m_kontrak->kode_vessel = $request->input('kode_vessel');
            $m_kontrak->tgl_awal_kontrak = $request->input('tgl_awal_kontrak');
            $m_kontrak->tgl_akhir_kontrak = $request->input('tgl_akhir_kontrak');
            $m_kontrak->charter_rate = $request->input('charter_rate');
            $m_kontrak->speed = $request->input('speed');
            $m_kontrak->me_ballast = $request->input('me_ballast');
            $m_kontrak->me_laden = $request->input('me_laden');
            $m_kontrak->pumping_rate = $request->input('pumping_rate');
            $m_kontrak->status = $request->input('status');
            $m_kontrak->file_upload = $request->input('file_upload');
            $m_kontrak->user_id = Auth::id();
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
