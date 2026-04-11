<?php

namespace App\Http\Controllers;

use App\Models\T_master_cable;
use App\Models\File_upload;
use App\Models\Settings;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class T_master_cableController extends Controller
{
    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 10);
        if ($perPage < 1) {
            $perPage = 10;
        }
        if ($perPage > 100) {
            $perPage = 100;
        }

        $query = T_master_cable::query()
            ->leftJoin('m_kontrak', function ($join) {
                $join->on('m_kontrak.id_vessel', '=', 't_master_cable.id_vessel')
                    ->where('m_kontrak.status', '=', 'ACTIVE');
            })
            ->select('t_master_cable.*', 'm_kontrak.id as id_kontrak', 'm_kontrak.no_kontrak');

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('t_master_cable.no_voyage_gab', 'like', "%{$search}%")
                    ->orWhere('t_master_cable.no_voyage', 'like', "%{$search}%")
                    ->orWhere('t_master_cable.jenis_voyage', 'like', "%{$search}%")
                    ->orWhere('t_master_cable.captain', 'like', "%{$search}%")
                    ->orWhere('t_master_cable.atd_port', 'like', "%{$search}%")
                    ->orWhere('t_master_cable.ata_port', 'like', "%{$search}%")
                    ->orWhere('t_master_cable.status', 'like', "%{$search}%");
            });
        }

        $status = $request->input('status');
        if (!is_null($status) && $status !== '') {
            $query->where('t_master_cable.status', $status);
        }

        $idVessel = $request->input('id_vessel');
        if (!is_null($idVessel) && $idVessel !== '') {
            $query->where('t_master_cable.id_vessel', $idVessel);
        }

        $allowedSort = ['id', 'no_voyage_gab', 'no_voyage', 'jenis_voyage', 'captain', 'atd_port', 'ata_port', 'status', 'created_at'];
        $sortBy = $request->input('sort_by', 'id');
        if (!in_array($sortBy, $allowedSort, true)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $query->orderBy($sortBy, $sortDir);

        $paginator = $query->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Data T_master_cable berhasil diambil',
            'data'    => $paginator->items(),
            'meta'    => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ]
        ]);
    }

    public function search(Request $request)
    {
        return $this->index($request);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = T_master_cable::where('id', $id)->first();
        $files = File_upload::where('id_cable', $id)
            ->orderBy('id', 'asc')
            ->get();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details T_master_cable berhasil diambil',
            'data'    => [
                'detail' => $data,
                'files' => $files,
            ]
        ]);
    }

    public function refs(Request $request)
    {
        $idVessel = $request->query('id_vessel');

        $vessels = DB::table('m_vessel')
            ->join('m_kontrak', function ($join) {
                $join->on('m_kontrak.id_vessel', '=', 'm_vessel.id')
                    ->where('m_kontrak.status', '=', 'ACTIVE');
            })
            ->select('m_vessel.id', 'm_vessel.kode_vessel', 'm_vessel.nama_vessel', 'm_vessel.jenis_vessel', 'm_vessel.status')
            ->groupBy('m_vessel.id', 'm_vessel.kode_vessel', 'm_vessel.nama_vessel', 'm_vessel.jenis_vessel', 'm_vessel.status')
            ->havingRaw('COUNT(m_kontrak.id) = 1')
            ->orderBy('kode_vessel')
            ->get();

        $lastCable = null;
        $captains = [];
        $atdPorts = [];
        $ataPorts = [];
        $kontrak = null;
        $settings = null;

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
                ->where('status', 'ACTIVE')
                ->orderByDesc('id')
                ->first();
        }

        $settingValue = Settings::where('nama', 'variable est_claim_bunker')
            ->where('status', 'ACTIVE')
            ->orderByDesc('id')
            ->value('value');
        $settings = [
            'est_claim_bunker' => $settingValue
        ];

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
                'settings' => $settings,
            ]
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $activeKontrakCount = DB::table('m_kontrak')
                ->where('id_vessel', $request->input('id_vessel'))
                ->where('status', 'ACTIVE')
                ->count();

            if ($activeKontrakCount !== 1) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Vessel harus memiliki tepat 1 kontrak ACTIVE.'
                ], 422);
            }

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
            $t_master_cable->user_id = Auth::id();
            $t_master_cable->save();

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/cable', 'public');
                    $upload = new File_upload();
                    $upload->id_cable = $t_master_cable->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }

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
            $activeKontrakCount = DB::table('m_kontrak')
                ->where('id_vessel', $request->input('id_vessel'))
                ->where('status', 'ACTIVE')
                ->count();

            if ($activeKontrakCount !== 1) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Vessel harus memiliki tepat 1 kontrak ACTIVE.'
                ], 422);
            }

            $t_master_cable = T_master_cable::where('id', $id)->firstOrFail();
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
            $t_master_cable->user_id = Auth::id();
            $t_master_cable->save();

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/cable', 'public');
                    $upload = new File_upload();
                    $upload->id_cable = $t_master_cable->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }

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

    public function approve(Request $request)
    {
        $id = $request->route('id');

        try {
            DB::beginTransaction();
            $t_master_cable = T_master_cable::where('id', $id)->firstOrFail();
            $t_master_cable->status = 'APPROVE';
            $t_master_cable->user_id = Auth::id();
            $t_master_cable->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Cable berhasil di-approve'
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

            $files = File_upload::where('id_cable', $id)->get();
            foreach ($files as $file) {
                if ($file->nama_file) {
                    $disk = Storage::disk('public');
                    if ($disk->exists($file->nama_file)) {
                        $disk->delete($file->nama_file);
                    }
                }
                $file->delete();
            }

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
