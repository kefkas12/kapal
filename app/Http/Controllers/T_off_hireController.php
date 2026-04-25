<?php

namespace App\Http\Controllers;

use App\Models\File_upload;
use App\Models\Settings;
use App\Models\T_off_hire;
use App\Models\T_master_cable;
use App\Support\FileUploadHelper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;

class T_off_hireController extends Controller
{
    private function offHireColumns(): array
    {
        return Schema::getColumnListing('t_off_hire');
    }

    private function toNumber($value): float
    {
        if ($value === null || $value === '') {
            return 0.0;
        }

        $str = trim((string) $value);
        if ($str === '') {
            return 0.0;
        }

        // dukung format angka: 1.234,56 atau 1,234.56
        if (str_contains($str, ',') && str_contains($str, '.')) {
            if (strrpos($str, ',') > strrpos($str, '.')) {
                $str = str_replace('.', '', $str);
                $str = str_replace(',', '.', $str);
            } else {
                $str = str_replace(',', '', $str);
            }
        } elseif (str_contains($str, ',')) {
            $str = str_replace(',', '.', $str);
        }

        $cleaned = preg_replace('/[^0-9.\-]/', '', $str);
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

    private function sanitizeOffHirePayload(Request $request): array
    {
        $idCable = $request->input('id_cable');

        $cable = null;
        if ($idCable) {
            $cable = T_master_cable::where('id', $idCable)->first();
        }

        $kontrak = null;
        if ($cable?->id_vessel) {
            $kontrak = DB::table('m_kontrak')
                ->where('id_vessel', $cable->id_vessel)
                ->where('status', 'ACTIVE')
                ->orderByDesc('id')
                ->first();
        }

        $dateTimeOffHire = $request->input('date_time_off_hire');
        $dateTimeOnHire = $request->input('date_time_on_hire');
        $offHireTs = strtotime((string) $dateTimeOffHire);
        $onHireTs = strtotime((string) $dateTimeOnHire);
        $selisihHari = 0.0;
        if ($offHireTs !== false && $onHireTs !== false) {
            $selisihHari = ($onHireTs - $offHireTs) / 86400;
        }

        $charterRate = $this->toNumber($kontrak?->charter_rate);
        $bunkerOffHire = $this->toNumber($request->input('bunker_off_hire'));
        $bunkerOnHire = $this->toNumber($request->input('bunker_on_hire'));
        $bunkerPrice = $this->toNumber($request->input('bunker_price'));
        $estClaimBunkerFactor = $this->getEstClaimBunkerFactor();
        $estOh = $selisihHari * $charterRate;
        $estBoh = ($bunkerOnHire - $bunkerOffHire) * $bunkerPrice * 1000 * $estClaimBunkerFactor;

        $payload = [
            'id_cable' => $idCable,
            'no_kontrak' => $request->input('no_kontrak') ?: ($kontrak?->no_kontrak ?? null),
            'no_voyage_gab' => $cable?->no_voyage_gab,
            'bunker_price' => $request->input('bunker_price'),
            'est_oh' => $this->numberToStorage($estOh),
            'est_boh' => $this->numberToStorage($estBoh),
            'date_time_off_hire' => $request->input('date_time_off_hire'),
            'tempat_off_hire' => $request->input('tempat_off_hire'),
            'bunker_off_hire' => $request->input('bunker_off_hire'),
            'date_time_on_hire' => $request->input('date_time_on_hire'),
            'tempat_on_hire' => $request->input('tempat_on_hire'),
            'bunker_on_hire' => $request->input('bunker_on_hire'),
            'status' => 'OPEN',
            'user_id' => Auth::id(),
            'updated_at' => now(),
        ];

        $allowedColumns = array_flip($this->offHireColumns());
        return array_intersect_key($payload, $allowedColumns);
    }

    private function getEstClaimBunkerFactor(): float
    {
        $value = Settings::query()
            ->where('nama', 'variable est_claim_bunker')
            ->where('status', 'ACTIVE')
            ->orderByDesc('id')
            ->value('value');

        $factor = $this->toNumber($value);
        if (!is_finite($factor) || $factor <= 0) {
            return 0.847;
        }

        return $factor;
    }

    private function numberToStorage(float $value): string
    {
        if (!is_finite($value)) {
            return '0';
        }

        return rtrim(rtrim(number_format($value, 6, '.', ''), '0'), '.');
    }

    private function assertOnHireAfterOffHire(Request $request): void
    {
        $offRaw = trim((string) $request->input('date_time_off_hire', ''));
        $onRaw = trim((string) $request->input('date_time_on_hire', ''));
        if ($offRaw === '' || $onRaw === '') {
            return;
        }

        $offTs = strtotime($offRaw);
        $onTs = strtotime($onRaw);
        if ($offTs === false || $onTs === false) {
            return;
        }

        if ($onTs <= $offTs) {
            throw ValidationException::withMessages([
                'date_time_on_hire' => 'Tanggal/Waktu On Hire harus lebih besar dari Off Hire.',
            ]);
        }
    }

    private function normalizedIncomingFiles(Request $request, string $key): array
    {
        return array_values(array_filter((array) $request->file($key, [])));
    }

    private function assertPdfFiles(array $files): void
    {
        foreach ($files as $file) {
            $ext = strtolower((string) $file?->getClientOriginalExtension());
            if ($ext !== 'pdf') {
                throw ValidationException::withMessages([
                    'files' => 'File cable hanya boleh PDF.',
                ]);
            }
        }
    }

    private function persistFiles(array $files, string $column, int $id, string $directory): void
    {
        foreach ($files as $file) {
            if (!$file) {
                continue;
            }
            $path = FileUploadHelper::storeWithOriginalName($file, $directory);
            $upload = new File_upload();
            $upload->{$column} = $id;
            $upload->nama_file = $path;
            $upload->save();
        }
    }

    private function assertNumericField(Request $request, string $field, string $label): void
    {
        $raw = trim((string) $request->input($field, ''));
        if ($raw === '') {
            throw ValidationException::withMessages([
                $field => $label . ' wajib diisi.',
            ]);
        }
        $normalized = str_replace(',', '.', $raw);
        if (!is_numeric($normalized)) {
            throw ValidationException::withMessages([
                $field => $label . ' harus berupa angka.',
            ]);
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

        $query = DB::table('t_off_hire')
            ->leftJoin('t_master_cable', 't_master_cable.id', '=', 't_off_hire.id_cable')
            ->select(
                't_off_hire.*',
                DB::raw('COALESCE(t_off_hire.no_voyage_gab, t_master_cable.no_voyage_gab) as no_voyage_gab_display'),
                't_master_cable.id_vessel',
                't_master_cable.no_voyage',
                't_master_cable.atd_port',
                't_master_cable.ata_port',
                't_master_cable.atd_time',
                't_master_cable.ata_time'
            );

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('t_off_hire.no_voyage_gab', 'like', "%{$search}%")
                    ->orWhere('t_master_cable.no_voyage_gab', 'like', "%{$search}%")
                    ->orWhere('t_off_hire.bunker_price', 'like', "%{$search}%")
                    ->orWhere('t_off_hire.status', 'like', "%{$search}%");
            });
        }

        $idCable = $request->input('id_cable');
        if (!is_null($idCable) && $idCable !== '') {
            $query->where('t_off_hire.id_cable', $idCable);
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
                    ->whereColumn('t_klaim_detail.id_cable', 't_off_hire.id_cable');

                if (!is_null($excludeKlaimId) && $excludeKlaimId !== '') {
                    $sub->where('t_klaim_detail.id_klaim', '!=', $excludeKlaimId);
                }
                if ($jenisKlaim !== '') {
                    $sub->where('t_klaim.jenis_klaim', $jenisKlaim);
                }
            });
        }

        $status = $request->input('status');
        if (!is_null($status) && $status !== '') {
            $query->where('t_off_hire.status', $status);
        }

        $allowedSort = [
            'id' => 't_off_hire.id',
            'no_voyage_gab' => 't_off_hire.no_voyage_gab',
            'bunker_price' => 't_off_hire.bunker_price',
            'status' => 't_off_hire.status',
            'created_at' => 't_off_hire.created_at',
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
            'message' => 'Data T_off_hire berhasil diambil',
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

        $data = DB::table('t_off_hire')
            ->leftJoin('t_master_cable', 't_master_cable.id', '=', 't_off_hire.id_cable')
            ->where('t_off_hire.id', $id)
            ->select(
                't_off_hire.*',
                DB::raw('COALESCE(t_off_hire.no_voyage_gab, t_master_cable.no_voyage_gab) as no_voyage_gab_display')
            )
            ->first();

        $filesOffHire = File_upload::where('id_off_hire', $id)
            ->orderBy('id', 'asc')
            ->get();
        $filesOnHire = File_upload::where('id_on_hire', $id)
            ->orderBy('id', 'asc')
            ->get();
        $files = $filesOffHire->concat($filesOnHire)->unique('id')->values();

        return response()->json([
            'success' => true,
            'message' => 'Data details T_off_hire berhasil diambil',
            'data' => [
                'detail' => $data,
                'files' => $files->values(),
                'files_off_hire' => $filesOffHire->values(),
                'files_on_hire' => $filesOnHire->values(),
            ],
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $filesOffHire = $this->normalizedIncomingFiles($request, 'files_off_hire');
            $filesOnHire = $this->normalizedIncomingFiles($request, 'files_on_hire');
            $legacyFiles = $this->normalizedIncomingFiles($request, 'files');
            if (!empty($legacyFiles) && empty($filesOffHire) && empty($filesOnHire)) {
                $filesOffHire = $legacyFiles;
                $filesOnHire = $legacyFiles;
            }
            if (empty($filesOffHire) || empty($filesOnHire)) {
                throw ValidationException::withMessages([
                    'files' => 'File upload wajib diisi.',
                ]);
            }
            $this->assertNumericField($request, 'bunker_off_hire', 'Bunker Off Hire (MT)');
            $this->assertNumericField($request, 'bunker_on_hire', 'Bunker On Hire (MT)');
            $this->assertOnHireAfterOffHire($request);
            $this->assertPdfFiles(array_merge($filesOffHire, $filesOnHire));

            $payload = $this->sanitizeOffHirePayload($request);
            $payload['created_at'] = now();

            $offHireId = DB::table('t_off_hire')->insertGetId($payload);

            $this->persistFiles($filesOffHire, 'id_off_hire', $offHireId, 'uploads/off_hire');
            $this->persistFiles($filesOnHire, 'id_on_hire', $offHireId, 'uploads/on_hire');

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_off_hire berhasil ditambah',
                'data' => [
                    'id' => $offHireId,
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
            $incomingFilesOffHire = $this->normalizedIncomingFiles($request, 'files_off_hire');
            $incomingFilesOnHire = $this->normalizedIncomingFiles($request, 'files_on_hire');
            $legacyFiles = $this->normalizedIncomingFiles($request, 'files');
            if (!empty($legacyFiles) && empty($incomingFilesOffHire) && empty($incomingFilesOnHire)) {
                $incomingFilesOffHire = $legacyFiles;
                $incomingFilesOnHire = $legacyFiles;
            }
            $hasExistingFilesOffHire = File_upload::where('id_off_hire', $id)->exists();
            $hasExistingFilesOnHire = File_upload::where('id_on_hire', $id)->exists();
            if ((empty($incomingFilesOffHire) && !$hasExistingFilesOffHire) || (empty($incomingFilesOnHire) && !$hasExistingFilesOnHire)) {
                throw ValidationException::withMessages([
                    'files' => 'File upload wajib diisi.',
                ]);
            }
            $this->assertNumericField($request, 'bunker_off_hire', 'Bunker Off Hire (MT)');
            $this->assertNumericField($request, 'bunker_on_hire', 'Bunker On Hire (MT)');
            $this->assertOnHireAfterOffHire($request);
            $this->assertPdfFiles(array_merge($incomingFilesOffHire, $incomingFilesOnHire));

            $existing = T_off_hire::where('id', $id)->firstOrFail();
            if (strtoupper((string) $existing->status) === 'APPROVE') {
                throw ValidationException::withMessages([
                    'status' => 'Off Hire yang sudah APPROVE tidak bisa diubah.',
                ]);
            }
            $payload = $this->sanitizeOffHirePayload($request);

            DB::table('t_off_hire')->where('id', $existing->id)->update($payload);

            $this->persistFiles($incomingFilesOffHire, 'id_off_hire', $existing->id, 'uploads/off_hire');
            $this->persistFiles($incomingFilesOnHire, 'id_on_hire', $existing->id, 'uploads/on_hire');

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_off_hire berhasil diubah',
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

            $offHire = T_off_hire::where('id', $id)->firstOrFail();
            $offHire->status = 'APPROVE';
            $offHire->user_id = Auth::id();
            $offHire->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Off Hire berhasil di-approve',
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

            $offHire = T_off_hire::where('id', $id)->firstOrFail();
            $offHire->status = 'OPEN';
            $offHire->user_id = Auth::id();
            $offHire->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Off Hire berhasil di-unapprove',
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
            $t_off_hire = T_off_hire::where('id', $id)->firstOrFail();
            if (strtoupper((string) $t_off_hire->status) === 'APPROVE') {
                throw ValidationException::withMessages([
                    'status' => 'Off Hire yang sudah APPROVE tidak bisa dihapus.',
                ]);
            }

            $files = File_upload::where('id_off_hire', $id)
                ->orWhere('id_on_hire', $id)
                ->get();
            foreach ($files as $file) {
                if ($file->nama_file) {
                    $disk = Storage::disk('public');
                    if ($disk->exists($file->nama_file)) {
                        $disk->delete($file->nama_file);
                    }
                }
                $file->delete();
            }

            $t_off_hire->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_off_hire berhasil dihapus',
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
