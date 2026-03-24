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

    public function refs(Request $request)
    {
        $idVessel = $request->query('id_vessel');

        $vessels = DB::table('m_vessel')
            ->select('id', 'kode_vessel', 'nama_vessel', 'jenis_vessel', 'status')
            ->orderBy('kode_vessel')
            ->get();

        $lastCable = null;
        $captains = [];
        $atdPorts = [];
        $ataPorts = [];
        $kontrak = null;

        if ($idVessel) {
            $lastCable = T_master_cable::where('id_vessel', $idVessel)
                ->orderByDesc('id')
                ->first();

            $captains = T_master_cable::where('id_vessel', $idVessel)
                ->whereNotNull('captain')
                ->select('captain')
                ->distinct()
                ->orderBy('captain')
                ->pluck('captain');

            $atdPorts = T_master_cable::where('id_vessel', $idVessel)
                ->whereNotNull('atd_port')
                ->select('atd_port')
                ->distinct()
                ->orderBy('atd_port')
                ->pluck('atd_port');

            $ataPorts = T_master_cable::where('id_vessel', $idVessel)
                ->whereNotNull('ata_port')
                ->select('ata_port')
                ->distinct()
                ->orderBy('ata_port')
                ->pluck('ata_port');

            $kontrak = DB::table('m_kontrak')
                ->where('id_vessel', $idVessel)
                ->orderByDesc('id')
                ->first();
        }

        return response()->json([
            'success' => true,
            'message' => 'Referensi cable berhasil diambil',
            'data' => [
                'vessels' => $vessels,
                'last_cable' => $lastCable,
                'captains' => $captains,
                'atd_ports' => $atdPorts,
                'ata_ports' => $ataPorts,
                'kontrak' => $kontrak,
            ]
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_master_cable = new T_master_cable();
            $t_master_cable->id_vessel = $request->input('id_vessel');
            $t_master_cable->no_voyage_gab = $request->input('no_voyage_gab');
            $t_master_cable->no_voyage = $request->input('no_voyage');
            $t_master_cable->jenis_voyage = $request->input('jenis_voyage');
            $t_master_cable->captain = $request->input('captain');
            $t_master_cable->atd_port = $request->input('atd_port');
            $t_master_cable->atd_time = $request->input('atd_time');
            $t_master_cable->atd_rob = $request->input('atd_rob');
            $t_master_cable->ata_port = $request->input('ata_port');
            $t_master_cable->ata_time = $request->input('ata_time');
            $t_master_cable->ata_rob = $request->input('ata_rob');
            $t_master_cable->distance = $request->input('distance');
            $t_master_cable->speed = $request->input('speed');
            $t_master_cable->est_sail_day = $request->input('est_sail_day');
            $t_master_cable->act_sail_day = $request->input('act_sail_day');
            $t_master_cable->charter_rate_day = $request->input('charter_rate_day');
            $t_master_cable->est_claim_speed = $request->input('est_claim_speed');
            $t_master_cable->std_bunker_cons = $request->input('std_bunker_cons');
            $t_master_cable->act_bunker_cons = $request->input('act_bunker_cons');
            $t_master_cable->excess_bunker = $request->input('excess_bunker');
            $t_master_cable->bunker_price = $request->input('bunker_price');
            $t_master_cable->est_claim_bunker = $request->input('est_claim_bunker');
            $t_master_cable->status = 'OPEN';
            $t_master_cable->file_upload = $request->input('file_upload');
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
            $t_master_cable->no_voyage_gab = $request->input('no_voyage_gab');
            $t_master_cable->no_voyage = $request->input('no_voyage');
            $t_master_cable->jenis_voyage = $request->input('jenis_voyage');
            $t_master_cable->kode_vessel = $request->input('kode_vessel');
            $t_master_cable->captain = $request->input('captain');
            $t_master_cable->atd_port = $request->input('atd_port');
            $t_master_cable->atd_time = $request->input('atd_time');
            $t_master_cable->atd_rob = $request->input('atd_rob');
            $t_master_cable->ata_port = $request->input('ata_port');
            $t_master_cable->ata_time = $request->input('ata_time');
            $t_master_cable->ata_rob = $request->input('ata_rob');
            $t_master_cable->distance = $request->input('distance');
            $t_master_cable->speed = $request->input('speed');
            $t_master_cable->est_sail_day = $request->input('est_sail_day');
            $t_master_cable->act_sail_day = $request->input('act_sail_day');
            $t_master_cable->charter_rate_day = $request->input('charter_rate_day');
            $t_master_cable->est_claim_speed = $request->input('est_claim_speed');
            $t_master_cable->std_bunker_cons = $request->input('std_bunker_cons');
            $t_master_cable->act_bunker_cons = $request->input('act_bunker_cons');
            $t_master_cable->excess_bunker = $request->input('excess_bunker');
            $t_master_cable->bunker_price = $request->input('bunker_price');
            $t_master_cable->est_claim_bunker = $request->input('est_claim_bunker');
            $t_master_cable->status = 'OPEN';
            $t_master_cable->file_upload = $request->input('file_upload');
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
