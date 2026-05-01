<?php

namespace App\Http\Controllers;

use App\Models\T_master_cable;
use App\Models\File_upload;
use App\Models\Settings;
use App\Support\FileUploadHelper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class T_master_cableController extends Controller
{
    private function parseNoVoyageBase(string $raw): ?string
    {
        $trimmed = trim($raw);
        if ($trimmed === '') {
            return null;
        }
        if (preg_match('/^(\d{5})(?:\/[A-Za-z0-9]+)?$/', $trimmed, $matches)) {
            return $matches[1];
        }
        return null;
    }

    private function getNextNoVoyageForVessel(int $idVessel): string
    {
        $yy = date('y');
        $maxSeq = 0;

        $noVoyages = T_master_cable::query()
            ->where('id_vessel', $idVessel)
            ->pluck('no_voyage');

        foreach ($noVoyages as $noVoyage) {
            $base = $this->parseNoVoyageBase((string) $noVoyage);
            if (!$base || !preg_match('/^' . preg_quote($yy, '/') . '(\d{3})$/', $base, $matches)) {
                continue;
            }
            $seq = (int) $matches[1];
            if ($seq > $maxSeq) {
                $maxSeq = $seq;
            }
        }

        $nextSeq = $maxSeq + 1;
        return $yy . str_pad((string) $nextSeq, 3, '0', STR_PAD_LEFT);
    }

    private function buildNextVoyageMeta(int $idVessel, bool $flagL): array
    {
        $latestCable = T_master_cable::query()
            ->where('id_vessel', $idVessel)
            ->orderByDesc('id')
            ->first(['no_voyage', 'jenis_voyage']);
        $kodeVessel = (string) (DB::table('m_vessel')->where('id', $idVessel)->value('kode_vessel') ?? '');

        $hasCable = !is_null($latestCable);
        $forceFlagL = !$hasCable;
        $effectiveFlagL = $forceFlagL ? true : $flagL;

        if ($effectiveFlagL) {
            $nextNoVoyage = $this->getNextNoVoyageForVessel($idVessel);
            $nextJenisVoyage = 'L';
        } else {
            $currentNoVoyage = $this->parseNoVoyageBase((string) ($latestCable?->no_voyage ?? ''));
            if (!preg_match('/^\d{5}$/', (string) $currentNoVoyage)) {
                $currentNoVoyage = $this->getNextNoVoyageForVessel($idVessel);
            }
            $lastJenis = strtoupper(trim((string) ($latestCable?->jenis_voyage ?? '')));
            if (preg_match('/^D(\d+)$/', $lastJenis, $matches)) {
                $nextJenisVoyage = 'D' . (((int) $matches[1]) + 1);
            } else {
                $nextJenisVoyage = 'D1';
            }
            $nextNoVoyage = $currentNoVoyage;
        }

        $noVoyageDisplay = $nextNoVoyage . '/' . $nextJenisVoyage;
        $noVoyageGab = ($kodeVessel !== '' ? $kodeVessel . '/' : '') . $noVoyageDisplay;

        return [
            'has_cable_for_vessel' => $hasCable,
            'force_flag_l' => $forceFlagL,
            'flag_l' => $effectiveFlagL,
            'no_voyage' => $nextNoVoyage,
            'no_voyage_display' => $noVoyageDisplay,
            'jenis_voyage' => $nextJenisVoyage,
            'no_voyage_gab' => $noVoyageGab,
        ];
    }

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
                    ->orWhere('t_master_cable.master', 'like', "%{$search}%")
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

        $availableForKlaim = $request->boolean('available_for_klaim', false);
        if ($availableForKlaim) {
            $excludeKlaimId = $request->input('exclude_klaim_id');
            $jenisKlaim = trim((string) $request->input('jenis_klaim', ''));
            $query->whereNotExists(function ($sub) use ($excludeKlaimId, $jenisKlaim) {
                $sub->select(DB::raw(1))
                    ->from('t_klaim_detail')
                    ->join('t_klaim', 't_klaim.id', '=', 't_klaim_detail.id_klaim')
                    ->whereColumn('t_klaim_detail.id_cable', 't_master_cable.id');

                if (!is_null($excludeKlaimId) && $excludeKlaimId !== '') {
                    $sub->where('t_klaim_detail.id_klaim', '!=', $excludeKlaimId);
                }
                if ($jenisKlaim !== '') {
                    $sub->where('t_klaim.jenis_klaim', $jenisKlaim);
                }
            });
        }

        $availableForDocCargo = $request->boolean('available_for_doc_cargo', false);
        if ($availableForDocCargo) {
            $excludeDocCargoId = $request->input('exclude_doc_cargo_id');
            $query->whereNotExists(function ($sub) use ($excludeDocCargoId) {
                $sub->select(DB::raw(1))
                    ->from('t_doc_cargo')
                    ->whereColumn('t_doc_cargo.id_cable', 't_master_cable.id');

                if (!is_null($excludeDocCargoId) && $excludeDocCargoId !== '') {
                    $sub->where('t_doc_cargo.id', '!=', $excludeDocCargoId);
                }
            });
        }

        $allowedSort = ['id', 'no_voyage_gab', 'no_voyage', 'jenis_voyage', 'master', 'atd_port', 'ata_port', 'status', 'created_at'];
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

        $data = T_master_cable::query()
            ->leftJoin('m_vessel', 'm_vessel.id', '=', 't_master_cable.id_vessel')
            ->where('t_master_cable.id', $id)
            ->select('t_master_cable.*', 'm_vessel.kode_vessel')
            ->first();
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
        $masters = [];
        $atdPorts = [];
        $ataPorts = [];
        $kontrak = null;
        $settings = null;
        $nextVoyage = null;

        if ($idVessel) {
            $lastCable = T_master_cable::where('id_vessel', $idVessel)
                ->orderByDesc('id')
                ->first();
            $nextVoyage = $this->buildNextVoyageMeta((int) $idVessel, $request->boolean('flag_l', false));

            $masters = T_master_cable::where('id_vessel', $idVessel)
                ->whereNotNull('master')
                ->select('master')
                ->distinct()
                ->orderBy('master')
                ->pluck('master');

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
        $settingTransportValue = Settings::where('nama', 'variable est_claim_transport')
            ->where('status', 'ACTIVE')
            ->orderByDesc('id')
            ->value('value');
        $settings = [
            'est_claim_bunker' => $settingValue,
            'est_claim_transport' => $settingTransportValue
        ];

        return response()->json([
            'success' => true,
            'message' => 'Referensi cable berhasil diambil',
            'data' => [
                'vessels' => $vessels,
                'last_cable' => $lastCable,
                'masters' => $masters,
                'atd_ports' => $atdPorts,
                'ata_ports' => $ataPorts,
                'kontrak' => $kontrak,
                'settings' => $settings,
                'next_voyage' => $nextVoyage,
            ]
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $request->validate([
                'files' => 'required|array|min:1',
                'files.*' => 'file|mimes:pdf|max:51200',
            ], [
                'files.required' => 'File upload wajib diisi.',
                'files.min' => 'Minimal 1 file harus diupload.',
                'files.*.mimes' => 'File cable hanya boleh PDF.',
            ]);

            $idVessel = $request->input('id_vessel');
            $atdTimeBaru = $request->input('atd_time');
            if (!$idVessel) {
                throw ValidationException::withMessages([
                    'id_vessel' => 'Vessel wajib diisi.',
                ]);
            }

            $nextVoyage = $this->buildNextVoyageMeta((int) $idVessel, $request->boolean('flag_l', false));

            if ($idVessel && $atdTimeBaru) {
                $lastCable = T_master_cable::where('id_vessel', $idVessel)
                    ->whereNotNull('ata_time')
                    ->orderByDesc('ata_time')
                    ->orderByDesc('id')
                    ->first();

                if ($lastCable && strtotime((string) $atdTimeBaru) <= strtotime((string) $lastCable->ata_time)) {
                    throw ValidationException::withMessages([
                        'atd_time' => 'ATD Time baru harus lebih besar dari ATA Time cable terakhir (' . $lastCable->ata_time . ').',
                    ]);
                }
            }

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
            $t_master_cable->no_voyage_gab = $nextVoyage['no_voyage_gab'];
            $t_master_cable->no_voyage = $nextVoyage['no_voyage'];
            $t_master_cable->jenis_voyage = $nextVoyage['jenis_voyage'];
            $t_master_cable->master = $request->input('master');
            $t_master_cable->atd_port = $request->input('atd_port');
            $t_master_cable->atd_time = $request->input('atd_time');
            $t_master_cable->atd_rob = $request->input('atd_rob');
            $t_master_cable->ata_port = $request->input('ata_port');
            $t_master_cable->ata_time = $request->input('ata_time');
            $t_master_cable->ata_rob = $request->input('ata_rob');
            $t_master_cable->distance = $request->input('distance');
            $t_master_cable->speed = $request->input('speed');
            $t_master_cable->act_speed = $request->input('act_speed');
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
            $t_master_cable->keterangan = $request->input('keterangan');
            $t_master_cable->user_id = Auth::id();
            $t_master_cable->save();

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = FileUploadHelper::storeWithOriginalName($file, 'uploads/cable');
                    $upload = new File_upload();
                    $upload->id_cable = $t_master_cable->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_master_cable berhasil ditambah',
                'data' => [
                    'id' => $t_master_cable->id,
                    'no_voyage_gab' => $t_master_cable->no_voyage_gab,
                    'no_voyage' => $t_master_cable->no_voyage,
                    'jenis_voyage' => $t_master_cable->jenis_voyage,
                ]
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
            $request->validate([
                'files' => 'nullable|array',
                'files.*' => 'file|mimes:pdf|max:51200',
            ], [
                'files.*.mimes' => 'File cable hanya boleh PDF.',
            ]);

            $incomingFiles = array_filter((array) $request->file('files', []));
            $hasExistingFiles = File_upload::where('id_cable', $id)->exists();
            if (empty($incomingFiles) && !$hasExistingFiles) {
                throw ValidationException::withMessages([
                    'files' => 'File upload wajib diisi.',
                ]);
            }

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
            $t_master_cable->master = $request->input('master');
            $t_master_cable->atd_port = $request->input('atd_port');
            $t_master_cable->atd_time = $request->input('atd_time');
            $t_master_cable->atd_rob = $request->input('atd_rob');
            $t_master_cable->ata_port = $request->input('ata_port');
            $t_master_cable->ata_time = $request->input('ata_time');
            $t_master_cable->ata_rob = $request->input('ata_rob');
            $t_master_cable->distance = $request->input('distance');
            $t_master_cable->speed = $request->input('speed');
            $t_master_cable->act_speed = $request->input('act_speed');
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
            $t_master_cable->keterangan = $request->input('keterangan');
            $t_master_cable->user_id = Auth::id();
            $t_master_cable->save();

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = FileUploadHelper::storeWithOriginalName($file, 'uploads/cable');
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
            $user = Auth::user();
            if (!$user || !($user->hasRole('approval') || $user->hasRole('superadmin'))) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Hanya role approval atau superadmin yang boleh melakukan approve.'
                ], 403);
            }

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

    public function unapprove(Request $request)
    {
        $id = $request->route('id');

        try {
            DB::beginTransaction();
            $user = Auth::user();
            if (!$user || !$user->hasRole('approval')) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Hanya role approval yang boleh melakukan unapprove.'
                ], 403);
            }

            $t_master_cable = T_master_cable::where('id', $id)->firstOrFail();
            $t_master_cable->status = 'OPEN';
            $t_master_cable->user_id = Auth::id();
            $t_master_cable->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Cable berhasil di-unapprove'
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
                    $path = public_path('storage/' . ltrim((string) $file->nama_file, '/'));
                    if (file_exists($path)) {
                        @unlink($path);
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
