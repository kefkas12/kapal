<?php

namespace App\Http\Controllers;

use App\Models\M_kontrak;
use App\Models\M_vessel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class M_vesselController extends Controller
{
    public function index(Request $request)
    {
        $data = M_vessel::get();

        return response()->json([
            'success' => true,
            'message' => 'Data M_vessel berhasil diambil',
            'data'    => $data
        ]);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = M_vessel::where('id', $id)->first();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details M_vessel berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $m_vessel = new M_vessel();
            $m_vessel->kode_vessel = $request->input('kode_vessel');
            $m_vessel->nama_vessel = $request->input('nama_vessel');
            $m_vessel->jenis_vessel = $request->input('jenis_vessel');
            $m_vessel->status = $request->input('status');
            $m_vessel->user_id = Auth::id();
            $m_vessel->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_vessel berhasil ditambah'
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
            $m_vessel = M_vessel::where('id', $id)->firstOrFail();
            $m_vessel->kode_vessel = $request->input('kode_vessel');
            $m_vessel->nama_vessel = $request->input('nama_vessel');
            $m_vessel->jenis_vessel = $request->input('jenis_vessel');
            $m_vessel->status = $request->input('status');
            $m_vessel->user_id = Auth::id();
            $m_vessel->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_vessel berhasil diubah'
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
            $m_vessel = M_vessel::where('id', $id)->firstOrFail();
            $m_vessel->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_vessel berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function Kontrak(Request $request)
    {
        $id = $request->route('id');

        $data = M_kontrak::where('id_vessel', $id)->get();
        
        return response()->json([
            'success' => true,
            'message' => 'Data M_kontrak dari M_vessel berhasil diambil',
            'data'    => $data
        ]);
    }
}
