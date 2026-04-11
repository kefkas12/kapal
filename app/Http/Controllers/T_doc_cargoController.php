<?php

namespace App\Http\Controllers;

use App\Models\File_upload;
use App\Models\M_grade;
use App\Models\T_doc_cargo;
use App\Models\T_master_cable;
use App\Support\FileUploadHelper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;

class T_doc_cargoController extends Controller
{
    private function docCargoColumns(): array
    {
        return Schema::getColumnListing('t_doc_cargo');
    }

    private function docCargoDetailColumns(): array
    {
        return Schema::getColumnListing('t_doc_cargo_detail');
    }

    private function toNumber($value): float
    {
        if ($value === null || $value === '') {
            return 0.0;
        }
        $cleaned = preg_replace('/[^0-9.\-]/', '', (string) $value);
        if ($cleaned === null || $cleaned === '' || $cleaned === '-' || $cleaned === '.') {
            return 0.0;
        }
        return (float) $cleaned;
    }

    private function toDateTimeValue($value): ?string
    {
        if ($value === null || $value === '') {
            return null;
        }
        $ts = strtotime((string) $value);
        if ($ts === false) {
            return null;
        }
        return date('Y-m-d H:i:s', $ts);
    }

    private function calcDischargeTime($startTime, $stopTime): ?string
    {
        if ($startTime === null || $stopTime === null || $startTime === '' || $stopTime === '') {
            return null;
        }

        $startTs = strtotime((string) $startTime);
        $stopTs = strtotime((string) $stopTime);
        if ($startTs === false || $stopTs === false) {
            return null;
        }

        $hours = ($stopTs - $startTs) / 3600;
        $days = $hours / 24;

        return number_format($days, 6, '.', '');
    }

    private function sanitizeDocCargoPayload(Request $request): array
    {
        $idCable = $request->input('id_cable');
        $idGrade = $request->input('id_grade');

        $cable = null;
        if ($idCable) {
            $cable = T_master_cable::where('id', $idCable)->first();
        }

        $grade = null;
        if ($idGrade) {
            $grade = M_grade::where('id', $idGrade)->first();
        }

        $payload = [
            'id_cable' => $idCable,
            'id_grade' => $idGrade,
            'no_voyage_gab' => $cable?->no_voyage_gab,
            'grade' => $grade?->grade,
            'price_bbl' => $grade?->price_bbl,
            'bill_of_lading' => $request->input('bill_of_lading'),
            'r1' => $request->input('r1'),
            'ratio_r1' => $request->input('ratio_r1'),
            'r2' => $request->input('r2'),
            'ratio_r2' => $request->input('ratio_r2'),
            'r3' => $request->input('r3'),
            'ratio_r3' => $request->input('ratio_r3'),
            'r4' => $request->input('r4'),
            'ratio_r4' => $request->input('ratio_r4'),
            'act_receipt' => $request->input('act_receipt'),
            'est_discharge' => $request->input('est_discharge'),
            'act_discharge' => $request->input('act_discharge'),
            'overdue_discharge' => $request->input('overdue_discharge'),
            'est_claim_pumping' => $request->input('est_claim_pumping'),
            'est_claim_bunker' => $request->input('est_claim_bunker'),
            'est_claim_transport' => $request->input('est_claim_transport'),
            'status' => $request->input('status') ?: 'OPEN',
            'user_id' => Auth::id(),
            'updated_at' => now(),
        ];

        $allowedColumns = array_flip($this->docCargoColumns());
        return array_intersect_key($payload, $allowedColumns);
    }

    private function parseDetailItems(Request $request): array
    {
        $raw = $request->input('detail_items');
        if (is_array($raw)) {
            return $raw;
        }
        if (is_string($raw) && trim($raw) !== '') {
            $decoded = json_decode($raw, true);
            return is_array($decoded) ? $decoded : [];
        }
        return [];
    }

    private function syncDetailRows(int $docCargoId, ?string $noVoyageGab, Request $request): void
    {
        $detailColumns = array_flip($this->docCargoDetailColumns());

        DB::table('t_doc_cargo_detail')->where('id_doc_cargo', $docCargoId)->delete();

        $detailItems = $this->parseDetailItems($request);
        $noUrut = 1;
        foreach ($detailItems as $item) {
            $startTimeRaw = $item['start_time'] ?? null;
            $stopTimeRaw = $item['stop_time'] ?? null;
            $dischargeTime = $item['discharge_time'] ?? $this->calcDischargeTime($startTimeRaw, $stopTimeRaw);

            $row = [
                'id_doc_cargo' => $docCargoId,
                'no_voyage_gab' => $noVoyageGab,
                'no_urut' => $item['no_urut'] ?? str_pad((string) $noUrut, 2, '0', STR_PAD_LEFT),
                'start_time' => $startTimeRaw,
                'stop_time' => $stopTimeRaw,
                'discharge_time' => $dischargeTime,
                'user_id' => Auth::id(),
                'created_at' => now(),
                'updated_at' => now(),
            ];

            $filtered = array_intersect_key($row, $detailColumns);
            if (!empty($filtered)) {
                DB::table('t_doc_cargo_detail')->insert($filtered);
            }

            $noUrut += 1;
        }
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

        $query = DB::table('t_doc_cargo')
            ->leftJoin('t_master_cable', 't_master_cable.id', '=', 't_doc_cargo.id_cable')
            ->leftJoin('m_grade', 'm_grade.id', '=', 't_doc_cargo.id_grade')
            ->select(
                't_doc_cargo.*',
                DB::raw('COALESCE(t_doc_cargo.no_voyage_gab, t_master_cable.no_voyage_gab) as no_voyage_gab_display'),
                DB::raw('COALESCE(t_doc_cargo.grade, m_grade.grade) as grade_display'),
                DB::raw('COALESCE(t_doc_cargo.price_bbl, m_grade.price_bbl) as price_bbl_display')
            );

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('t_doc_cargo.no_voyage_gab', 'like', "%{$search}%")
                    ->orWhere('t_master_cable.no_voyage_gab', 'like', "%{$search}%")
                    ->orWhere('t_doc_cargo.grade', 'like', "%{$search}%")
                    ->orWhere('m_grade.grade', 'like', "%{$search}%")
                    ->orWhere('t_doc_cargo.bill_of_lading', 'like', "%{$search}%")
                    ->orWhere('t_doc_cargo.status', 'like', "%{$search}%");
            });
        }

        $idCable = $request->input('id_cable');
        if (!is_null($idCable) && $idCable !== '') {
            $query->where('t_doc_cargo.id_cable', $idCable);
        }

        $status = $request->input('status');
        if (!is_null($status) && $status !== '') {
            $query->where('t_doc_cargo.status', $status);
        }

        $allowedSort = [
            'id' => 't_doc_cargo.id',
            'no_voyage_gab' => 't_doc_cargo.no_voyage_gab',
            'bill_of_lading' => 't_doc_cargo.bill_of_lading',
            'status' => 't_doc_cargo.status',
            'created_at' => 't_doc_cargo.created_at',
        ];
        $sortBy = $request->input('sort_by', 'id');
        if (!array_key_exists($sortBy, $allowedSort)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $query->orderBy($allowedSort[$sortBy], $sortDir);

        $paginator = $query->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Data T_doc_cargo berhasil diambil',
            'data' => $paginator->items(),
            'meta' => [
                'current_page' => $paginator->currentPage(),
                'per_page' => $paginator->perPage(),
                'total' => $paginator->total(),
                'last_page' => $paginator->lastPage(),
            ],
        ]);
    }

    public function search(Request $request)
    {
        return $this->index($request);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = DB::table('t_doc_cargo')
            ->leftJoin('t_master_cable', 't_master_cable.id', '=', 't_doc_cargo.id_cable')
            ->leftJoin('m_grade', 'm_grade.id', '=', 't_doc_cargo.id_grade')
            ->where('t_doc_cargo.id', $id)
            ->select(
                't_doc_cargo.*',
                DB::raw('COALESCE(t_doc_cargo.no_voyage_gab, t_master_cable.no_voyage_gab) as no_voyage_gab_display'),
                DB::raw('COALESCE(t_doc_cargo.grade, m_grade.grade) as grade_display'),
                DB::raw('COALESCE(t_doc_cargo.price_bbl, m_grade.price_bbl) as price_bbl_display')
            )
            ->first();

        $detailItems = DB::table('t_doc_cargo_detail')
            ->where('id_doc_cargo', $id)
            ->orderBy('id', 'asc')
            ->get();

        $files = File_upload::where('id_doc_cargo', $id)
            ->orderBy('id', 'asc')
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Data details T_doc_cargo berhasil diambil',
            'data' => [
                'detail' => $data,
                'detail_items' => $detailItems,
                'files' => $files,
            ],
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $request->validate([
                'files' => 'required|array|min:1',
                'files.*' => 'file|max:51200',
            ], [
                'files.required' => 'File upload wajib diisi.',
                'files.min' => 'Minimal 1 file harus diupload.',
            ]);

            $payload = $this->sanitizeDocCargoPayload($request);
            $payload['created_at'] = now();

            $docCargoId = DB::table('t_doc_cargo')->insertGetId($payload);

            $noVoyageGab = $payload['no_voyage_gab'] ?? null;
            $this->syncDetailRows($docCargoId, $noVoyageGab, $request);

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = FileUploadHelper::storeWithOriginalName($file, 'uploads/doc_cargo');
                    $upload = new File_upload();
                    $upload->id_doc_cargo = $docCargoId;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_doc_cargo berhasil ditambah',
                'data' => [
                    'id' => $docCargoId,
                ],
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
            $incomingFiles = array_filter((array) $request->file('files', []));
            $hasExistingFiles = File_upload::where('id_doc_cargo', $id)->exists();
            if (empty($incomingFiles) && !$hasExistingFiles) {
                throw ValidationException::withMessages([
                    'files' => 'File upload wajib diisi.',
                ]);
            }

            $existing = T_doc_cargo::where('id', $id)->firstOrFail();
            $payload = $this->sanitizeDocCargoPayload($request);

            DB::table('t_doc_cargo')->where('id', $existing->id)->update($payload);

            $noVoyageGab = $payload['no_voyage_gab'] ?? $existing->no_voyage_gab ?? null;
            $this->syncDetailRows((int) $existing->id, $noVoyageGab, $request);

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = FileUploadHelper::storeWithOriginalName($file, 'uploads/doc_cargo');
                    $upload = new File_upload();
                    $upload->id_doc_cargo = $existing->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_doc_cargo berhasil diubah',
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
            $t_doc_cargo = T_doc_cargo::where('id', $id)->firstOrFail();

            $files = File_upload::where('id_doc_cargo', $id)->get();
            foreach ($files as $file) {
                if ($file->nama_file) {
                    $disk = Storage::disk('public');
                    if ($disk->exists($file->nama_file)) {
                        $disk->delete($file->nama_file);
                    }
                }
                $file->delete();
            }

            DB::table('t_doc_cargo_detail')->where('id_doc_cargo', $id)->delete();
            $t_doc_cargo->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_doc_cargo berhasil dihapus',
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
