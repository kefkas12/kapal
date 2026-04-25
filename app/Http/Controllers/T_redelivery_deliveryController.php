<?php

namespace App\Http\Controllers;

use App\Models\File_upload;
use App\Models\Settings;
use App\Models\T_redelivery_delivery;
use App\Models\T_master_cable;
use App\Support\FileUploadHelper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;

class T_redelivery_deliveryController extends Controller
{
    private function redeliveryDeliveryColumns(): array
    {
        return Schema::getColumnListing('t_redelivery_delivery');
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

    private function sanitizeRedeliveryDeliveryPayload(Request $request): array
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

        $bunkerRedelivery = $this->toNumber($request->input('bunker_redelivery'));
        $bunkerDelivery = $this->toNumber($request->input('bunker_delivery'));
        $estClaimBunkerFactor = $this->getEstClaimBunkerFactor();
        $estBod = ($bunkerDelivery - $bunkerRedelivery) * $bunkerRedelivery * 1000 * $estClaimBunkerFactor;

        $payload = [
            'id_cable' => $idCable,
            'id_kontrak_redelivery' => $request->input('id_kontrak_redelivery') ?: ($kontrak?->id ?? null),
            'id_kontrak_delivery' => $request->input('id_kontrak_delivery') ?: ($kontrak?->id ?? null),
            'no_kontrak_redelivery' => $request->input('no_kontrak_redelivery') ?: ($kontrak?->no_kontrak ?? null),
            'no_kontrak_delivery' => $request->input('no_kontrak_delivery') ?: ($kontrak?->no_kontrak ?? null),
            'no_voyage_gab' => $request->input('no_voyage_gab') ?: ($cable?->no_voyage_gab ?? null),
            'bunker_price' => $request->input('bunker_price'),
            'est_bod' => $this->numberToStorage($estBod),
            'date_time_redelivery' => $request->input('date_time_redelivery'),
            'tempat_redelivery' => $request->input('tempat_redelivery'),
            'bunker_redelivery' => $request->input('bunker_redelivery'),
            'date_time_delivery' => $request->input('date_time_delivery'),
            'tempat_delivery' => $request->input('tempat_delivery'),
            'bunker_delivery' => $request->input('bunker_delivery'),
            'status' => 'OPEN',
            'user_id' => Auth::id(),
            'updated_at' => now(),
        ];

        $allowedColumns = array_flip($this->redeliveryDeliveryColumns());
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

    private function computeEstBodValue($bunkerRedeliveryRaw, $bunkerDeliveryRaw): string
    {
        $bunkerRedelivery = $this->toNumber($bunkerRedeliveryRaw);
        $bunkerDelivery = $this->toNumber($bunkerDeliveryRaw);
        $estClaimBunkerFactor = $this->getEstClaimBunkerFactor();
        $estBod = ($bunkerDelivery - $bunkerRedelivery) * $bunkerRedelivery * 1000 * $estClaimBunkerFactor;
        return $this->numberToStorage($estBod);
    }

    private function hasRedeliveryDeliveryCableColumn(): bool
    {
        return Schema::hasColumn('t_redelivery_delivery', 'id_cable');
    }

    private function redeliveryFileColumn(): string
    {
        if (Schema::hasColumn('file_upload', 'id_redelivery')) {
            return 'id_redelivery';
        }
        return 'id_redelivery_delivery';
    }

    private function deliveryFileColumn(): string
    {
        if (Schema::hasColumn('file_upload', 'id_delivery')) {
            return 'id_delivery';
        }
        return 'id_redelivery_delivery';
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

    private function assertKontrakSelection(Request $request): void
    {
        $idKontrakRedelivery = trim((string) $request->input('id_kontrak_redelivery', ''));
        $idKontrakDelivery = trim((string) $request->input('id_kontrak_delivery', ''));
        if ($idKontrakRedelivery === '' || $idKontrakDelivery === '') {
            throw ValidationException::withMessages([
                'id_kontrak_redelivery' => 'Kontrak Redelivery wajib diisi.',
                'id_kontrak_delivery' => 'Kontrak Delivery wajib diisi.',
            ]);
        }
        if ((int) $idKontrakRedelivery === (int) $idKontrakDelivery) {
            throw ValidationException::withMessages([
                'id_kontrak_delivery' => 'Kontrak Redelivery dan Delivery tidak boleh sama.',
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

        $hasIdCable = $this->hasRedeliveryDeliveryCableColumn();
        $query = DB::table('t_redelivery_delivery');
        if ($hasIdCable) {
            $query->leftJoin('t_master_cable', 't_master_cable.id', '=', 't_redelivery_delivery.id_cable')
                ->select(
                    't_redelivery_delivery.*',
                    DB::raw('COALESCE(t_redelivery_delivery.no_voyage_gab, t_master_cable.no_voyage_gab) as no_voyage_gab_display')
                );
        } else {
            $query->select(
                't_redelivery_delivery.*',
                DB::raw('t_redelivery_delivery.no_voyage_gab as no_voyage_gab_display')
            );
        }

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('t_redelivery_delivery.no_voyage_gab', 'like', "%{$search}%")
                    ->orWhere('t_redelivery_delivery.bunker_price', 'like', "%{$search}%")
                    ->orWhere('t_redelivery_delivery.status', 'like', "%{$search}%");
                if ($hasIdCable) {
                    $q->orWhere('t_master_cable.no_voyage_gab', 'like', "%{$search}%");
                }
            });
        }

        $idCable = $request->input('id_cable');
        if ($hasIdCable && !is_null($idCable) && $idCable !== '') {
            $query->where('t_redelivery_delivery.id_cable', $idCable);
        }

        $status = $request->input('status');
        if (!is_null($status) && $status !== '') {
            $query->where('t_redelivery_delivery.status', $status);
        }

        $allowedSort = [
            'id' => 't_redelivery_delivery.id',
            'no_voyage_gab' => 't_redelivery_delivery.no_voyage_gab',
            'bunker_price' => 't_redelivery_delivery.bunker_price',
            'status' => 't_redelivery_delivery.status',
            'created_at' => 't_redelivery_delivery.created_at',
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
            'message' => 'Data T_redelivery_delivery berhasil diambil',
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

        $hasIdCable = $this->hasRedeliveryDeliveryCableColumn();
        $detailQuery = DB::table('t_redelivery_delivery')->where('t_redelivery_delivery.id', $id);
        if ($hasIdCable) {
            $detailQuery
                ->leftJoin('t_master_cable', 't_master_cable.id', '=', 't_redelivery_delivery.id_cable')
                ->select(
                    't_redelivery_delivery.*',
                    DB::raw('COALESCE(t_redelivery_delivery.no_voyage_gab, t_master_cable.no_voyage_gab) as no_voyage_gab_display')
                );
        } else {
            $detailQuery
                ->select(
                    't_redelivery_delivery.*',
                    DB::raw('t_redelivery_delivery.no_voyage_gab as no_voyage_gab_display')
                );
        }
        $data = $detailQuery->first();
        if ($data && (trim((string) ($data->est_bod ?? '')) === '')) {
            $data->est_bod = $this->computeEstBodValue($data->bunker_redelivery ?? null, $data->bunker_delivery ?? null);
        }

        $redeliveryColumn = $this->redeliveryFileColumn();
        $deliveryColumn = $this->deliveryFileColumn();
        $filesRedelivery = File_upload::where($redeliveryColumn, $id)
            ->orderBy('id', 'asc')
            ->get();
        $filesDelivery = File_upload::where($deliveryColumn, $id)
            ->orderBy('id', 'asc')
            ->get();
        $files = $filesRedelivery->concat($filesDelivery)->unique('id')->values();

        return response()->json([
            'success' => true,
            'message' => 'Data details T_redelivery_delivery berhasil diambil',
            'data' => [
                'detail' => $data,
                'files' => $files->values(),
                'files_redelivery' => $filesRedelivery->values(),
                'files_delivery' => $filesDelivery->values(),
            ],
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $filesRedelivery = $this->normalizedIncomingFiles($request, 'files_redelivery');
            $filesDelivery = $this->normalizedIncomingFiles($request, 'files_delivery');
            $legacyFiles = $this->normalizedIncomingFiles($request, 'files');
            if (!empty($legacyFiles) && empty($filesRedelivery) && empty($filesDelivery)) {
                $filesRedelivery = $legacyFiles;
                $filesDelivery = $legacyFiles;
            }
            if (empty($filesRedelivery) || empty($filesDelivery)) {
                throw ValidationException::withMessages([
                    'files' => 'File upload wajib diisi.',
                ]);
            }
            $this->assertKontrakSelection($request);
            $this->assertNumericField($request, 'bunker_redelivery', 'Bunker Redelivery (MT)');
            $this->assertNumericField($request, 'bunker_delivery', 'Bunker Delivery (MT)');
            $this->assertPdfFiles(array_merge($filesRedelivery, $filesDelivery));

            $payload = $this->sanitizeRedeliveryDeliveryPayload($request);
            $payload['created_at'] = now();

            $redeliveryDeliveryId = DB::table('t_redelivery_delivery')->insertGetId($payload);

            $this->persistFiles($filesRedelivery, $this->redeliveryFileColumn(), $redeliveryDeliveryId, 'uploads/redelivery');
            $this->persistFiles($filesDelivery, $this->deliveryFileColumn(), $redeliveryDeliveryId, 'uploads/delivery');

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_redelivery_delivery berhasil ditambah',
                'data' => [
                    'id' => $redeliveryDeliveryId,
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
            $incomingFilesRedelivery = $this->normalizedIncomingFiles($request, 'files_redelivery');
            $incomingFilesDelivery = $this->normalizedIncomingFiles($request, 'files_delivery');
            $legacyFiles = $this->normalizedIncomingFiles($request, 'files');
            if (!empty($legacyFiles) && empty($incomingFilesRedelivery) && empty($incomingFilesDelivery)) {
                $incomingFilesRedelivery = $legacyFiles;
                $incomingFilesDelivery = $legacyFiles;
            }
            $redeliveryColumn = $this->redeliveryFileColumn();
            $deliveryColumn = $this->deliveryFileColumn();
            $hasExistingFilesRedelivery = File_upload::where($redeliveryColumn, $id)->exists();
            $hasExistingFilesDelivery = File_upload::where($deliveryColumn, $id)->exists();
            if ((empty($incomingFilesRedelivery) && !$hasExistingFilesRedelivery) || (empty($incomingFilesDelivery) && !$hasExistingFilesDelivery)) {
                throw ValidationException::withMessages([
                    'files' => 'File upload wajib diisi.',
                ]);
            }
            $this->assertKontrakSelection($request);
            $this->assertNumericField($request, 'bunker_redelivery', 'Bunker Redelivery (MT)');
            $this->assertNumericField($request, 'bunker_delivery', 'Bunker Delivery (MT)');
            $this->assertPdfFiles(array_merge($incomingFilesRedelivery, $incomingFilesDelivery));

            $existing = T_redelivery_delivery::where('id', $id)->firstOrFail();
            if (strtoupper((string) $existing->status) === 'APPROVE') {
                throw ValidationException::withMessages([
                    'status' => 'Redelivery Delivery yang sudah APPROVE tidak bisa diubah.',
                ]);
            }
            $payload = $this->sanitizeRedeliveryDeliveryPayload($request);

            DB::table('t_redelivery_delivery')->where('id', $existing->id)->update($payload);

            $this->persistFiles($incomingFilesRedelivery, $redeliveryColumn, $existing->id, 'uploads/redelivery');
            $this->persistFiles($incomingFilesDelivery, $deliveryColumn, $existing->id, 'uploads/delivery');

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_redelivery_delivery berhasil diubah',
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

            $redeliveryDelivery = T_redelivery_delivery::where('id', $id)->firstOrFail();
            $redeliveryDelivery->status = 'APPROVE';
            $redeliveryDelivery->user_id = Auth::id();
            $redeliveryDelivery->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Redelivery Delivery berhasil di-approve',
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

            $redeliveryDelivery = T_redelivery_delivery::where('id', $id)->firstOrFail();
            $redeliveryDelivery->status = 'OPEN';
            $redeliveryDelivery->user_id = Auth::id();
            $redeliveryDelivery->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Redelivery Delivery berhasil di-unapprove',
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
            $t_redelivery_delivery = T_redelivery_delivery::where('id', $id)->firstOrFail();
            if (strtoupper((string) $t_redelivery_delivery->status) === 'APPROVE') {
                throw ValidationException::withMessages([
                    'status' => 'Redelivery Delivery yang sudah APPROVE tidak bisa dihapus.',
                ]);
            }

            $redeliveryColumn = $this->redeliveryFileColumn();
            $deliveryColumn = $this->deliveryFileColumn();
            $files = File_upload::where($redeliveryColumn, $id)
                ->orWhere($deliveryColumn, $id)
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

            $t_redelivery_delivery->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_redelivery_delivery berhasil dihapus',
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
