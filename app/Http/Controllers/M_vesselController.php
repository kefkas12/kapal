<?php

namespace App\Http\Controllers;

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
            $m_vessel->no_voyage_gab = $request->input('no_voyage_gab');
            $m_vessel->no_voyage = $request->input('no_voyage');
            $m_vessel->jenis_voyage = $request->input('jenis_voyage');
            $m_vessel->kode_vessel = $request->input('kode_vessel');
            $m_vessel->captain = $request->input('captain');
            $m_vessel->atd_port = $request->input('atd_port');
            $m_vessel->atd_time = $request->input('atd_time');
            $m_vessel->atd_rob = $request->input('atd_rob');
            $m_vessel->ata_port = $request->input('ata_port');
            $m_vessel->ata_time = $request->input('ata_time');
            $m_vessel->ata_rob = $request->input('ata_rob');
            $m_vessel->distance = $request->input('distance');
            $m_vessel->speed = $request->input('speed');
            $m_vessel->est_sail_day = $request->input('est_sail_day');
            $m_vessel->act_sail_day = $request->input('act_sail_day');
            $m_vessel->charter_rate_day = $request->input('charter_rate_day');
            $m_vessel->est_claim_speed = $request->input('est_claim_speed');
            $m_vessel->std_bunker_cons = $request->input('std_bunker_cons');
            $m_vessel->act_bunker_cons = $request->input('act_bunker_cons');
            $m_vessel->excess_bunker = $request->input('excess_bunker');
            $m_vessel->bunker_price = $request->input('bunker_price');
            $m_vessel->est_claim_bunker = $request->input('est_claim_bunker');
            $m_vessel->status = $request->input('status');
            $m_vessel->file_upload = $request->input('file_upload');
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
            $m_vessel->no_voyage_gab = $request->input('no_voyage_gab');
            $m_vessel->no_voyage = $request->input('no_voyage');
            $m_vessel->jenis_voyage = $request->input('jenis_voyage');
            $m_vessel->kode_vessel = $request->input('kode_vessel');
            $m_vessel->captain = $request->input('captain');
            $m_vessel->atd_port = $request->input('atd_port');
            $m_vessel->atd_time = $request->input('atd_time');
            $m_vessel->atd_rob = $request->input('atd_rob');
            $m_vessel->ata_port = $request->input('ata_port');
            $m_vessel->ata_time = $request->input('ata_time');
            $m_vessel->ata_rob = $request->input('ata_rob');
            $m_vessel->distance = $request->input('distance');
            $m_vessel->speed = $request->input('speed');
            $m_vessel->est_sail_day = $request->input('est_sail_day');
            $m_vessel->act_sail_day = $request->input('act_sail_day');
            $m_vessel->charter_rate_day = $request->input('charter_rate_day');
            $m_vessel->est_claim_speed = $request->input('est_claim_speed');
            $m_vessel->std_bunker_cons = $request->input('std_bunker_cons');
            $m_vessel->act_bunker_cons = $request->input('act_bunker_cons');
            $m_vessel->excess_bunker = $request->input('excess_bunker');
            $m_vessel->bunker_price = $request->input('bunker_price');
            $m_vessel->est_claim_bunker = $request->input('est_claim_bunker');
            $m_vessel->status = $request->input('status');
            $m_vessel->file_upload = $request->input('file_upload');
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
}
