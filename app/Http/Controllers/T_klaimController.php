<?php

namespace App\Http\Controllers;

use App\Models\File_upload;
use App\Models\T_klaim;
use App\Models\T_klaim_detail;
use App\Models\T_klaim_detail_nilai;
use App\Support\FileUploadHelper;
use App\Support\SimpleSpreadsheetReader;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Validation\ValidationException;

class T_klaimController extends Controller
{
    private const KLAIM_IMPORT_ALLOWED_JENIS = ['SSOB', 'SPOB', 'TL', 'BOD', 'OH', 'BOH', 'OHBOH'];

    private function actingUserId(): ?int
    {
        return Auth::id() ?? DB::table('users')->orderBy('id')->value('id');
    }

    private function refreshEstimateHistoriesForApproval(T_klaim $klaim, T_klaim_detail $detail, Request $request, int $userId): void
    {
        $latestValues = $this->resolveLatestEstimateValues($klaim, $detail);
        $incomingValues = $this->approvalEstimateItems($request);
        $historySnapshots = $this->approvalEstimateHistorySnapshots($klaim, $request, (int) $detail->id);
        $estimateHistoryFields = ['val_potensi', 'val_klaim_awal', 'val_klaim_akhir'];

        $nilaiRows = T_klaim_detail_nilai::query()
            ->where('id_klaim_detail', $detail->id)
            ->lockForUpdate()
            ->get();

        foreach ($nilaiRows as $nilai) {
            $subJenis = strtoupper((string) $nilai->sub_jenis);
            $latestValPotensi = $latestValues[$subJenis] ?? null;
            $updates = [];
            $snapshot = $historySnapshots['id'][$nilai->id] ?? $historySnapshots['sub_jenis'][$subJenis] ?? null;

            if ($this->hasEstimateValue($latestValPotensi) && ! $this->sameEstimateValue($nilai->val_potensi, $latestValPotensi)) {
                $updates['val_potensi'] = $latestValPotensi;
            }

            if ($this->hasEstimateValue($latestValPotensi)
                && $this->shouldSyncKlaimAwalForApproval($nilai->val_klaim_awal, $nilai->val_potensi)
                && ! $this->sameEstimateValue($nilai->val_klaim_awal, $latestValPotensi)) {
                $updates['val_klaim_awal'] = $latestValPotensi;
            }

            $incoming = $incomingValues['id'][$nilai->id] ?? $incomingValues['sub_jenis'][$subJenis] ?? null;
            if (is_array($incoming)) {
                foreach (['val_potensi', 'val_klaim_awal', 'val_klaim_akhir', 'val_klaim_akhir_idr'] as $field) {
                    if (! array_key_exists($field, $incoming)) {
                        continue;
                    }

                    $incomingValue = $this->normalizeApprovalEstimateValue($incoming[$field]);
                    if (! $this->sameEstimateValue($nilai->{$field}, $incomingValue)) {
                        $updates[$field] = $incomingValue;
                    }
                }
            }

            $nextValues = [
                'val_potensi' => $updates['val_potensi'] ?? $nilai->val_potensi,
                'val_klaim_awal' => $updates['val_klaim_awal'] ?? $nilai->val_klaim_awal,
                'val_klaim_akhir' => $updates['val_klaim_akhir'] ?? $nilai->val_klaim_akhir,
                'val_klaim_akhir_idr' => $updates['val_klaim_akhir_idr'] ?? $nilai->val_klaim_akhir_idr,
            ];

            $oldValues = is_array($snapshot)
                ? [
                    'val_potensi' => $snapshot['val_potensi'] ?? $nilai->val_potensi,
                    'val_klaim_awal' => $snapshot['val_klaim_awal'] ?? $nilai->val_klaim_awal,
                    'val_klaim_akhir' => $snapshot['val_klaim_akhir'] ?? $nilai->val_klaim_akhir,
                    'val_klaim_akhir_idr' => $snapshot['val_klaim_akhir_idr'] ?? $nilai->val_klaim_akhir_idr,
                ]
                : [
                    'val_potensi' => $nilai->val_potensi,
                    'val_klaim_awal' => $nilai->val_klaim_awal,
                    'val_klaim_akhir' => $nilai->val_klaim_akhir,
                    'val_klaim_akhir_idr' => $nilai->val_klaim_akhir_idr,
                ];

            $hasChangedEstimate = collect($estimateHistoryFields)->contains(
                fn (string $field): bool => ! $this->sameEstimateValue($oldValues[$field] ?? null, $nextValues[$field] ?? null)
            );

            if (! $hasChangedEstimate && $updates === []) {
                continue;
            }

            if ($hasChangedEstimate) {
                $this->insertEstimateHistory($klaim, $detail, $nilai, $oldValues, $nextValues, $userId);
            }

            if ($updates !== []) {
                T_klaim_detail_nilai::query()
                    ->where('id', $nilai->id)
                    ->update($updates + [
                        'user_id' => $userId,
                        'updated_at' => now(),
                    ]);
            }
        }
    }

    private function approvalEstimateHistorySnapshots(T_klaim $klaim, Request $request, int $klaimDetailId): array
    {
        $raw = $request->input('estimate_history_snapshots');
        if (is_string($raw) && trim($raw) !== '') {
            $decoded = json_decode($raw, true);
            $raw = is_array($decoded) ? $decoded : [];
        }

        $cached = $this->getPendingEstimateHistoryCache($this->estimateHistoryPendingCacheKey((int) $klaim->id));
        if (is_array($cached) && $cached !== []) {
            $raw = array_merge(is_array($raw) ? $raw : [], $cached);
        }

        if (! is_array($raw)) {
            return ['id' => [], 'sub_jenis' => []];
        }

        $items = ['id' => [], 'sub_jenis' => []];
        foreach ($raw as $item) {
            if (! is_array($item) || (int) ($item['id_klaim_detail'] ?? 0) !== $klaimDetailId) {
                continue;
            }

            $id = (int) ($item['id_klaim_detail_nilai'] ?? $item['id_nilai'] ?? $item['id'] ?? 0);
            if ($id > 0) {
                $items['id'][$id] = $item;
            }

            $subJenis = strtoupper(trim((string) ($item['sub_jenis'] ?? '')));
            if ($subJenis !== '') {
                $items['sub_jenis'][$subJenis] = $item;
            }
        }

        return $items;
    }

    private function estimateHistoryPendingCacheKey(int $klaimId): string
    {
        return "klaim-estimate-history-pending:{$klaimId}";
    }

    private function getPendingEstimateHistoryCache(string $key): array
    {
        if (Schema::hasTable('cache')) {
            $row = DB::table('cache')
                ->where('key', $key)
                ->where('expiration', '>', now()->timestamp)
                ->first();

            if ($row) {
                $decoded = json_decode((string) $row->value, true);

                return is_array($decoded) ? $decoded : [];
            }
        }

        $cached = Cache::get($key, []);

        return is_array($cached) ? $cached : [];
    }

    private function forgetPendingEstimateHistoryCache(string $key): void
    {
        if (Schema::hasTable('cache')) {
            DB::table('cache')->where('key', $key)->delete();
        }

        Cache::forget($key);
    }

    private function putPendingEstimateHistoryCache(string $key, array $value): void
    {
        if (Schema::hasTable('cache')) {
            DB::table('cache')->updateOrInsert(
                ['key' => $key],
                [
                    'value' => json_encode($value),
                    'expiration' => now()->addHours(6)->timestamp,
                ]
            );

            return;
        }

        Cache::put($key, $value, now()->addHours(6));
    }

    private function rememberCurrentEstimateValuesForNextApproval(T_klaim $klaim): void
    {
        $snapshots = DB::table('t_klaim_detail as detail')
            ->join('t_klaim_detail_nilai as nilai', 'nilai.id_klaim_detail', '=', 'detail.id')
            ->where('detail.id_klaim', $klaim->id)
            ->select([
                'detail.id as id_klaim_detail',
                'nilai.id as id_klaim_detail_nilai',
                'nilai.sub_jenis',
                'nilai.val_potensi',
                'nilai.val_klaim_awal',
                'nilai.val_klaim_akhir',
                'nilai.val_klaim_akhir_idr',
            ])
            ->get()
            ->map(fn ($row): array => [
                'id_klaim' => $klaim->id,
                'id_klaim_detail' => (int) $row->id_klaim_detail,
                'id_klaim_detail_nilai' => (int) $row->id_klaim_detail_nilai,
                'sub_jenis' => (string) $row->sub_jenis,
                'val_potensi' => (string) ($row->val_potensi ?? ''),
                'val_klaim_awal' => (string) ($row->val_klaim_awal ?? ''),
                'val_klaim_akhir' => (string) ($row->val_klaim_akhir ?? ''),
                'val_klaim_akhir_idr' => (string) ($row->val_klaim_akhir_idr ?? ''),
            ])
            ->all();

        $this->putPendingEstimateHistoryCache($this->estimateHistoryPendingCacheKey((int) $klaim->id), $snapshots);
    }

    private function insertEstimateHistory(
        T_klaim $klaim,
        T_klaim_detail $detail,
        T_klaim_detail_nilai $nilai,
        array $oldValues,
        array $nextValues,
        int $userId
    ): void {
        DB::table('t_klaim_estimate_histories')->insert([
            'id_klaim' => $klaim->id,
            'id_klaim_detail' => $detail->id,
            'id_klaim_detail_nilai' => $nilai->id,
            'sub_jenis' => (string) $nilai->sub_jenis,
            'val_potensi' => (string) ($nextValues['val_potensi'] ?? ''),
            'val_klaim_awal' => (string) ($nextValues['val_klaim_awal'] ?? ''),
            'val_klaim_akhir' => (string) ($nextValues['val_klaim_akhir'] ?? ''),
            'val_klaim_akhir_idr' => (string) ($nextValues['val_klaim_akhir_idr'] ?? ''),
            'old_val_potensi' => (string) ($oldValues['val_potensi'] ?? ''),
            'old_val_klaim_awal' => (string) ($oldValues['val_klaim_awal'] ?? ''),
            'old_val_klaim_akhir' => (string) ($oldValues['val_klaim_akhir'] ?? ''),
            'old_val_klaim_akhir_idr' => (string) ($oldValues['val_klaim_akhir_idr'] ?? ''),
            'user_id' => $userId,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    private function approvalEstimateItems(Request $request): array
    {
        $raw = $request->input('nilai_items');
        if (is_string($raw) && trim($raw) !== '') {
            $decoded = json_decode($raw, true);
            $raw = is_array($decoded) ? $decoded : [];
        }

        if (! is_array($raw)) {
            return ['id' => [], 'sub_jenis' => []];
        }

        $items = ['id' => [], 'sub_jenis' => []];
        foreach ($raw as $item) {
            if (! is_array($item)) {
                continue;
            }

            $id = (int) ($item['id'] ?? $item['id_nilai'] ?? $item['id_klaim_detail_nilai'] ?? 0);
            if ($id > 0) {
                $items['id'][$id] = $item;
            }

            $subJenis = strtoupper(trim((string) ($item['sub_jenis'] ?? '')));
            if ($subJenis !== '') {
                $items['sub_jenis'][$subJenis] = $item;
            }
        }

        return $items;
    }

    private function normalizeApprovalEstimateValue($value): ?string
    {
        $value = trim((string) ($value ?? ''));

        return $value !== '' ? $value : null;
    }

    private function resolveLatestEstimateValues(T_klaim $klaim, T_klaim_detail $detail): array
    {
        $jenisKlaim = strtoupper((string) $klaim->jenis_klaim);
        $idCable = $detail->id_cable;
        $noVoyageGab = $detail->no_voyage_gab;
        $cable = null;

        if ($idCable) {
            $cable = DB::table('t_master_cable')->where('id', $idCable)->first();
            $noVoyageGab = $noVoyageGab ?: ($cable->no_voyage_gab ?? null);
        }

        $docCargo = $this->findDocCargoForEstimate($detail->id_doc_cargo ?? null, $idCable, $noVoyageGab);
        $offHire = $this->findOffHireForEstimate($detail->id_off_hire ?? null, $idCable, $noVoyageGab);
        $redeliveryDelivery = $this->findRedeliveryDeliveryForEstimate($detail->id_redelivery_delivery ?? null, $idCable, $noVoyageGab);

        return [
            'SS' => $cable->est_claim_speed ?? null,
            'SP' => $docCargo->est_claim_pumping ?? null,
            'TL' => $docCargo->est_claim_transport ?? ($docCargo->est_transport_loss ?? null),
            'OB' => $jenisKlaim === 'SPOB'
                ? ($docCargo->est_claim_bunker ?? null)
                : ($cable->est_claim_bunker ?? null),
            'OH' => $offHire->est_oh ?? null,
            'BOH' => $offHire->est_boh ?? null,
            'BOD' => $redeliveryDelivery->est_bod ?? null,
        ];
    }

    private function findDocCargoForEstimate($idDocCargo, $idCable, $noVoyageGab): ?object
    {
        $query = DB::table('t_doc_cargo');

        if (! empty($idDocCargo)) {
            $query->where('id', $idDocCargo);
        } elseif (! empty($idCable)) {
            $query->where('id_cable', $idCable);
        } elseif (! empty($noVoyageGab)) {
            $query->where('no_voyage_gab', $noVoyageGab);
        } else {
            return null;
        }

        return $query->orderByDesc('id')->first();
    }

    private function findOffHireForEstimate($idOffHire, $idCable, $noVoyageGab): ?object
    {
        $query = DB::table('t_off_hire');
        $hasIdCable = Schema::hasColumn('t_off_hire', 'id_cable');
        $hasNoVoyageGab = Schema::hasColumn('t_off_hire', 'no_voyage_gab');

        if (! empty($idOffHire)) {
            $query->where('id', $idOffHire);
        } elseif (! empty($idCable) && $hasIdCable) {
            $query->where('id_cable', $idCable);
        } elseif (! empty($noVoyageGab) && $hasNoVoyageGab) {
            $query->where('no_voyage_gab', $noVoyageGab);
        } else {
            return null;
        }

        return $query->orderByDesc('id')->first();
    }

    private function findRedeliveryDeliveryForEstimate($idRedeliveryDelivery, $idCable, $noVoyageGab): ?object
    {
        $query = DB::table('t_redelivery_delivery');
        $hasIdCable = Schema::hasColumn('t_redelivery_delivery', 'id_cable');
        $hasNoVoyageGab = Schema::hasColumn('t_redelivery_delivery', 'no_voyage_gab');

        if (! empty($idRedeliveryDelivery)) {
            $query->where('id', $idRedeliveryDelivery);
        } elseif (! empty($idCable)) {
            if ($hasIdCable) {
                $query->where('id_cable', $idCable);
            } else {
                $query->where('id', $idCable);
            }
        } elseif (! empty($noVoyageGab) && $hasNoVoyageGab) {
            $query->where('no_voyage_gab', $noVoyageGab);
        } else {
            return null;
        }

        return $query->orderByDesc('id')->first();
    }

    private function shouldSyncKlaimAwalForApproval($currentValue, $currentEstimate): bool
    {
        if (! $this->hasEstimateValue($currentValue)) {
            return true;
        }

        $currentNumber = $this->estimateNumber($currentValue);
        if ($currentNumber !== null && abs($currentNumber) < 0.000001) {
            return true;
        }

        return $this->sameEstimateValue($currentValue, $currentEstimate);
    }

    private function sameEstimateValue($left, $right): bool
    {
        $leftNumber = $this->estimateNumber($left);
        $rightNumber = $this->estimateNumber($right);

        if ($leftNumber !== null && $rightNumber !== null) {
            return abs($leftNumber - $rightNumber) < 0.000001;
        }

        return trim((string) ($left ?? '')) === trim((string) ($right ?? ''));
    }

    private function hasEstimateValue($value): bool
    {
        return trim((string) ($value ?? '')) !== '';
    }

    private function estimateNumber($value): ?float
    {
        if (! $this->hasEstimateValue($value)) {
            return null;
        }

        $str = trim((string) $value);
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
            return null;
        }

        return (float) $cleaned;
    }

    private function normalizeImportHeader(?string $value): string
    {
        $upper = strtoupper(trim((string) $value));

        return preg_replace('/[^A-Z0-9]/', '', $upper) ?? '';
    }

    private function klaimImportFieldLabels(): array
    {
        return [
            'no_klaim_awal' => 'No Klaim Awal',
            'tgl_klaim_awal' => 'Tgl Klaim Awal',
            'jenis_klaim' => 'Jenis Klaim',
            'vessel' => 'Vessel',
            'periode_klaim' => 'Periode Klaim',
            'no_klaim_akhir' => 'No Klaim Akhir',
            'tgl_klaim_akhir' => 'Tgl Klaim Akhir',
        ];
    }

    private function klaimImportColumns(): array
    {
        return [
            'no_klaim_awal' => ['NOKLAIMAWAL'],
            'tgl_klaim_awal' => ['TGLKLAIMAWAL'],
            'jenis_klaim' => ['JENISKLAIM'],
            'vessel' => ['VESSEL'],
            'periode_klaim' => ['PERIODEKLAIM'],
            'no_klaim_akhir' => ['NOKLAIMAKHIR'],
            'tgl_klaim_akhir' => ['TGLKLAIMAKHIR'],
        ];
    }

    private function excelDateToDateTime($value, bool $dateOnly = false): ?string
    {
        if ($value === null || $value === '') {
            return null;
        }

        if (is_numeric($value)) {
            $serial = (float) $value;
            if ($serial > 0) {
                $unix = (int) round(($serial - 25569) * 86400);

                return gmdate($dateOnly ? 'Y-m-d' : 'Y-m-d H:i:s', $unix);
            }
        }

        $text = trim((string) $value);
        if ($text === '') {
            return null;
        }

        $ts = strtotime($text);
        if ($ts === false) {
            return null;
        }

        return date($dateOnly ? 'Y-m-d' : 'Y-m-d H:i:s', $ts);
    }

    private function parseKlaimImportRows(array $rows): array
    {
        if ($rows === []) {
            throw ValidationException::withMessages([
                'file' => 'File import kosong.',
            ]);
        }

        $headerRow = $rows[0] ?? [];
        $normalizedHeaders = [];
        foreach ($headerRow as $index => $header) {
            $normalizedHeaders[$index] = $this->normalizeImportHeader($header);
        }

        $columnIndexes = [];
        foreach ($this->klaimImportColumns() as $field => $aliases) {
            foreach ($normalizedHeaders as $index => $header) {
                if (in_array($header, $aliases, true)) {
                    $columnIndexes[$field] = $index;
                    break;
                }
            }
        }

        foreach (['no_klaim_awal', 'tgl_klaim_awal', 'jenis_klaim', 'vessel'] as $requiredField) {
            if (! array_key_exists($requiredField, $columnIndexes)) {
                $requiredLabel = $this->klaimImportFieldLabels()[$requiredField] ?? $requiredField;
                throw ValidationException::withMessages([
                    'file' => 'Header wajib tidak ditemukan: '.$requiredLabel.'.',
                ]);
            }
        }

        $parsed = [];
        foreach (array_slice($rows, 1) as $offset => $row) {
            $item = ['row_number' => $offset + 2];
            $hasValue = false;

            foreach ($columnIndexes as $field => $index) {
                $value = trim((string) ($row[$index] ?? ''));
                if ($value !== '') {
                    $hasValue = true;
                }

                if (in_array($field, ['tgl_klaim_awal', 'tgl_klaim_akhir'], true)) {
                    $item[$field] = $value === '' ? null : $this->excelDateToDateTime($value, true);
                } else {
                    $item[$field] = $value === '' ? null : $value;
                }
            }

            if (! $hasValue) {
                continue;
            }

            $parsed[] = $item;
        }

        if ($parsed === []) {
            throw ValidationException::withMessages([
                'file' => 'Tidak ada baris data yang bisa diproses pada file import.',
            ]);
        }

        return $parsed;
    }

    private function resolveVesselIdFromImport(?string $value): ?int
    {
        $lookup = $this->normalizeImportHeader($value);
        if ($lookup === '') {
            return null;
        }

        $vessel = DB::table('m_vessel')
            ->select('id', 'kode_vessel', 'nama_vessel')
            ->get()
            ->first(function ($row) use ($lookup) {
                $kode = $this->normalizeImportHeader($row->kode_vessel ?? '');
                $nama = $this->normalizeImportHeader($row->nama_vessel ?? '');

                return $lookup === $kode || $lookup === $nama || str_contains($nama, $lookup) || str_contains($lookup, $nama);
            });

        return $vessel ? (int) $vessel->id : null;
    }

    private function normalizeJenisKlaimImport(?string $value): ?string
    {
        $jenis = strtoupper(trim((string) $value));
        if ($jenis === '') {
            return null;
        }

        $aliases = [
            'BUNKEROFFDELIVERY' => 'BOD',
            'BUNKEROFDELIVERY' => 'BOD',
        ];

        $normalized = preg_replace('/[^A-Z0-9]/', '', $jenis) ?? '';
        if (isset($aliases[$normalized])) {
            $jenis = $aliases[$normalized];
        } else {
            $jenis = $normalized;
        }

        return in_array($jenis, self::KLAIM_IMPORT_ALLOWED_JENIS, true) ? $jenis : null;
    }

    private function buildKlaimImportTemplateHtml(): string
    {
        $headers = $this->klaimImportFieldLabels();
        $sampleRows = [
            ['KLAIM/OSL/001', '2026-06-01', 'SSOB', 'AB2F8', '2026-06', '', ''],
            ['KLAIM/OSL/002', '2026-06-05', 'OHBOH', 'AB5FL9', '2026-06', 'FIN/KLAIM/002', '2026-06-12'],
        ];

        $html = '<table border="1"><tr>';
        foreach ($headers as $header) {
            $html .= '<th>'.e($header).'</th>';
        }
        $html .= '</tr>';

        foreach ($sampleRows as $sampleRow) {
            $html .= '<tr>';
            foreach ($sampleRow as $value) {
                $html .= '<td>'.e((string) $value).'</td>';
            }
            $html .= '</tr>';
        }

        $html .= '</table>';

        return $html;
    }

    private function buildKlaimExportHtml(): string
    {
        $headers = array_keys($this->klaimImportFieldLabels());
        $labels = $this->klaimImportFieldLabels();

        $rows = DB::table('t_klaim')
            ->leftJoin('m_vessel', 'm_vessel.id', '=', 't_klaim.id_vessel')
            ->select(
                't_klaim.no_klaim_awal',
                't_klaim.tgl_klaim_awal',
                't_klaim.jenis_klaim',
                'm_vessel.kode_vessel as vessel',
                't_klaim.periode_klaim',
                't_klaim.no_klaim_akhir',
                't_klaim.tgl_klaim_akhir'
            )
            ->orderBy('t_klaim.id')
            ->get();

        $html = '<table border="1"><tr>';
        foreach ($headers as $header) {
            $html .= '<th>'.e($labels[$header]).'</th>';
        }
        $html .= '</tr>';

        foreach ($rows as $row) {
            $html .= '<tr>';
            foreach ($headers as $header) {
                $html .= '<td>'.e((string) ($row->{$header} ?? '')).'</td>';
            }
            $html .= '</tr>';
        }

        $html .= '</table>';

        return $html;
    }

    private function processImportFile(Request $request): array
    {
        $request->validate([
            'file' => 'required|file|mimes:xlsx,xls,csv,html,xml|max:20480',
        ], [
            'file.required' => 'File import wajib diisi.',
            'file.mimes' => 'File import harus berupa XLSX/XLS/CSV.',
        ]);

        $file = $request->file('file');
        try {
            $rows = SimpleSpreadsheetReader::readRows(
                $file->getRealPath(),
                $file->getClientOriginalExtension()
            );
        } catch (\RuntimeException $e) {
            throw ValidationException::withMessages([
                'file' => $e->getMessage(),
            ]);
        }

        $parsedRows = $this->parseKlaimImportRows($rows);

        $result = [
            'created' => 0,
            'updated' => 0,
            'skipped' => 0,
            'errors' => [],
            'created_rows' => [],
            'updated_rows' => [],
        ];

        DB::beginTransaction();
        try {
            foreach ($parsedRows as $row) {
                $jenisKlaim = $this->normalizeJenisKlaimImport($row['jenis_klaim'] ?? null);
                if (! $jenisKlaim) {
                    $result['errors'][] = 'Baris '.$row['row_number'].': Jenis Klaim harus salah satu dari '.implode(', ', self::KLAIM_IMPORT_ALLOWED_JENIS).'.';
                    $result['skipped']++;

                    continue;
                }

                $idVessel = $this->resolveVesselIdFromImport($row['vessel'] ?? null);
                if (! $idVessel) {
                    $result['errors'][] = 'Baris '.$row['row_number'].': Vessel "'.($row['vessel'] ?? '').'" tidak ditemukan.';
                    $result['skipped']++;

                    continue;
                }

                $payload = [
                    'id_vessel' => $idVessel,
                    'no_klaim_awal' => $row['no_klaim_awal'],
                    'tgl_klaim_awal' => $row['tgl_klaim_awal'],
                    'jenis_klaim' => $jenisKlaim,
                    'no_klaim_akhir' => $row['no_klaim_akhir'] ?? null,
                    'tgl_klaim_akhir' => $row['tgl_klaim_akhir'] ?? null,
                    'periode_klaim' => $row['periode_klaim'] ?? null,
                    'status' => 'OPEN',
                    'user_id' => $this->actingUserId(),
                    'updated_at' => now(),
                ];

                $existing = T_klaim::query()
                    ->where('no_klaim_awal', $row['no_klaim_awal'])
                    ->first();

                if ($existing) {
                    DB::table('t_klaim')->where('id', $existing->id)->update($payload);
                    $result['updated']++;
                    $result['updated_rows'][] = [
                        'row_number' => $row['row_number'],
                        'klaim_id' => (int) $existing->id,
                        'no_klaim_awal' => $payload['no_klaim_awal'],
                        'jenis_klaim' => $payload['jenis_klaim'],
                        'vessel' => $row['vessel'] ?? null,
                        'previous_status' => $existing->status,
                    ];

                    continue;
                }

                $payload['created_at'] = now();
                $klaimId = DB::table('t_klaim')->insertGetId($payload);
                $result['created']++;
                $result['created_rows'][] = [
                    'row_number' => $row['row_number'],
                    'klaim_id' => (int) $klaimId,
                    'no_klaim_awal' => $payload['no_klaim_awal'],
                    'jenis_klaim' => $payload['jenis_klaim'],
                    'vessel' => $row['vessel'] ?? null,
                ];
            }

            DB::commit();
        } catch (\Throwable $e) {
            DB::rollBack();
            throw $e;
        }

        return $result;
    }

    public function importTemplate()
    {
        $filename = 'klaim_import_template.xls';

        return response($this->buildKlaimImportTemplateHtml(), 200, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="'.$filename.'"',
        ]);
    }

    public function exportImportSource()
    {
        $filename = 'klaim_import_source.xls';

        return response($this->buildKlaimExportHtml(), 200, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="'.$filename.'"',
        ]);
    }

    public function importPage()
    {
        return response()->view('klaim-import', [
            'result' => session('result'),
            'errorsFromImport' => session('errors_from_import', []),
        ]);
    }

    public function importExcelWeb(Request $request)
    {
        $result = $this->processImportFile($request);

        return redirect()
            ->route('klaim.import.page')
            ->with('result', $result)
            ->with('errors_from_import', $result['errors'] ?? []);
    }

    public function importExcel(Request $request)
    {
        $result = $this->processImportFile($request);

        return response()->json([
            'success' => true,
            'message' => 'Import Klaim selesai diproses.',
            'data' => $result,
        ]);
    }

    private function extractIncomingUploadFiles(Request $request): array
    {
        $all = $request->allFiles();
        $stack = is_array($all) ? array_values($all) : [$all];
        $files = [];

        while (! empty($stack)) {
            $current = array_pop($stack);
            if (is_array($current)) {
                foreach ($current as $item) {
                    $stack[] = $item;
                }

                continue;
            }
            if ($current) {
                $files[] = $current;
            }
        }

        return $files;
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

        if ($request->boolean('detail_nilai', false)) {
            return $this->indexDetailNilai($request, $perPage);
        }

        $query = T_klaim::query()
            ->leftJoin('m_vessel', 'm_vessel.id', '=', 't_klaim.id_vessel')
            ->select('t_klaim.*', 'm_vessel.nama_vessel');

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('t_klaim.no_klaim_awal', 'like', "%{$search}%")
                    ->orWhere('t_klaim.tgl_klaim_awal', 'like', "%{$search}%")
                    ->orWhere('t_klaim.jenis_klaim', 'like', "%{$search}%")
                    ->orWhere('t_klaim.id_vessel', 'like', "%{$search}%")
                    ->orWhere('t_klaim.no_klaim_akhir', 'like', "%{$search}%")
                    ->orWhere('t_klaim.tgl_klaim_akhir', 'like', "%{$search}%")
                    ->orWhere('m_vessel.nama_vessel', 'like', "%{$search}%")
                    ->orWhere('t_klaim.status', 'like', "%{$search}%");
            });
        }

        $idVessel = $request->input('id_vessel');
        if (! is_null($idVessel) && $idVessel !== '') {
            $query->where('t_klaim.id_vessel', $idVessel);
        }

        $jenisKlaim = $request->input('jenis_klaim');
        if (! is_null($jenisKlaim) && $jenisKlaim !== '') {
            $query->where('t_klaim.jenis_klaim', $jenisKlaim);
        }

        $requireFinalKlaim = $request->boolean('require_final_klaim', false);
        if ($requireFinalKlaim) {
            $query->whereRaw('UPPER(TRIM(COALESCE(t_klaim.no_klaim_akhir, ""))) NOT IN ("", "-")')
                ->whereRaw('TRIM(COALESCE(t_klaim.tgl_klaim_akhir, "")) <> ""');
        }

        $allowedSort = [
            'id' => 't_klaim.id',
            'no_klaim_awal' => 't_klaim.no_klaim_awal',
            'tgl_klaim_awal' => 't_klaim.tgl_klaim_awal',
            'jenis_klaim' => 't_klaim.jenis_klaim',
            'id_vessel' => 't_klaim.id_vessel',
            'nama_vessel' => 'm_vessel.nama_vessel',
            'no_klaim_akhir' => 't_klaim.no_klaim_akhir',
            'tgl_klaim_akhir' => 't_klaim.tgl_klaim_akhir',
            'created_at' => 't_klaim.created_at',
            'status' => 't_klaim.status',
        ];
        $sortBy = $request->input('sort_by', 'id');
        if (! array_key_exists($sortBy, $allowedSort)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $query->orderBy($allowedSort[$sortBy], $sortDir);

        $paginator = $query->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Data T_klaim berhasil diambil',
            'data' => $paginator->items(),
            'meta' => [
                'current_page' => $paginator->currentPage(),
                'per_page' => $paginator->perPage(),
                'total' => $paginator->total(),
                'last_page' => $paginator->lastPage(),
            ],
        ]);
    }

    public function detailNilaiList(Request $request)
    {
        $perPage = (int) $request->input('per_page', 10);
        if ($perPage < 1) {
            $perPage = 10;
        }
        if ($perPage > 100) {
            $perPage = 100;
        }

        return $this->indexDetailNilai($request, $perPage);
    }

    private function indexDetailNilai(Request $request, int $perPage)
    {
        $query = DB::table('t_klaim_detail')
            ->join('t_klaim', 't_klaim.id', '=', 't_klaim_detail.id_klaim')
            ->leftJoin('m_vessel', 'm_vessel.id', '=', 't_klaim.id_vessel')
            ->leftJoin('t_klaim_detail_nilai as nilai', 'nilai.id_klaim_detail', '=', 't_klaim_detail.id')
            ->select([
                't_klaim.id as id',
                DB::raw('COALESCE(nilai.id, t_klaim_detail.id) as row_key'),
                't_klaim.id_vessel',
                't_klaim.no_klaim_awal',
                't_klaim.tgl_klaim_awal',
                't_klaim.jenis_klaim as jenis_klaim_header',
                DB::raw('COALESCE(NULLIF(nilai.sub_jenis, ""), t_klaim.jenis_klaim) as jenis_klaim'),
                't_klaim.no_klaim_akhir',
                't_klaim.tgl_klaim_akhir',
                't_klaim.periode_klaim',
                't_klaim.user_id',
                't_klaim.status',
                't_klaim.created_at',
                't_klaim.updated_at',
                'm_vessel.nama_vessel',
                't_klaim_detail.id as id_klaim_detail',
                't_klaim_detail.no_urut',
                't_klaim_detail.no_voyage_gab',
                't_klaim_detail.keterangan',
                't_klaim_detail.status as status_detail',
                'nilai.id as id_nilai',
                'nilai.sub_jenis',
                'nilai.currency',
                'nilai.val_potensi',
                'nilai.val_klaim_awal',
                'nilai.val_klaim_akhir',
                'nilai.val_klaim_akhir_idr',
                'nilai.no_tagihan_klaim',
                'nilai.tanggal_tagihan_klaim',
                'nilai.no_tagihan_dipotong',
                'nilai.tanggal_tagihan_dipotong',
            ]);

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('t_klaim.no_klaim_awal', 'like', "%{$search}%")
                    ->orWhere('t_klaim.tgl_klaim_awal', 'like', "%{$search}%")
                    ->orWhere('t_klaim.jenis_klaim', 'like', "%{$search}%")
                    ->orWhere('m_vessel.nama_vessel', 'like', "%{$search}%")
                    ->orWhere('t_klaim_detail.no_voyage_gab', 'like', "%{$search}%")
                    ->orWhere('t_klaim.no_klaim_akhir', 'like', "%{$search}%")
                    ->orWhere('t_klaim.status', 'like', "%{$search}%")
                    ->orWhere('t_klaim_detail.keterangan', 'like', "%{$search}%")
                    ->orWhere('nilai.sub_jenis', 'like', "%{$search}%")
                    ->orWhere('nilai.val_potensi', 'like', "%{$search}%")
                    ->orWhere('nilai.val_klaim_awal', 'like', "%{$search}%")
                    ->orWhere('nilai.val_klaim_akhir', 'like', "%{$search}%")
                    ->orWhere('nilai.no_tagihan_klaim', 'like', "%{$search}%")
                    ->orWhere('nilai.tanggal_tagihan_klaim', 'like', "%{$search}%")
                    ->orWhere('nilai.tanggal_tagihan_dipotong', 'like', "%{$search}%");
            });
        }

        $status = $request->input('status');
        if (! is_null($status) && $status !== '') {
            $query->whereRaw('UPPER(COALESCE(t_klaim_detail.status, "")) = ?', [strtoupper((string) $status)]);
        }

        $idVessel = $request->input('id_vessel');
        if (! is_null($idVessel) && $idVessel !== '') {
            $query->where('t_klaim.id_vessel', $idVessel);
        }

        $jenisKlaim = $request->input('jenis_klaim');
        if (! is_null($jenisKlaim) && $jenisKlaim !== '') {
            $query->where('t_klaim.jenis_klaim', $jenisKlaim);
        }

        if ($request->boolean('exclude_zero_klaim_akhir')) {
            // val_klaim_akhir disimpan sebagai varchar (bisa null/kosong/berformat ribuan).
            // Sembunyikan baris yang nilai klaim akhirnya 0/kosong.
            $query->whereRaw("CAST(REPLACE(COALESCE(nilai.val_klaim_akhir, ''), ',', '') AS DECIMAL(30,4)) <> 0");
        }

        $allowedSort = [
            'id' => 't_klaim.id',
            'id_klaim_detail' => 't_klaim_detail.id',
            'id_nilai' => 'nilai.id',
            'no_voyage_gab' => 't_klaim_detail.no_voyage_gab',
            'no_klaim_awal' => 't_klaim.no_klaim_awal',
            'tgl_klaim_awal' => 't_klaim.tgl_klaim_awal',
            'jenis_klaim' => 't_klaim.jenis_klaim',
            'id_vessel' => 't_klaim.id_vessel',
            'nama_vessel' => 'm_vessel.nama_vessel',
            'no_klaim_akhir' => 't_klaim.no_klaim_akhir',
            'tgl_klaim_akhir' => 't_klaim.tgl_klaim_akhir',
            'val_potensi' => 'nilai.val_potensi',
            'val_klaim_awal' => 'nilai.val_klaim_awal',
            'val_klaim_akhir' => 'nilai.val_klaim_akhir',
            'no_tagihan_klaim' => 'nilai.no_tagihan_klaim',
            'tanggal_tagihan_klaim' => 'nilai.tanggal_tagihan_klaim',
            'tanggal_tagihan_dipotong' => 'nilai.tanggal_tagihan_dipotong',
            'created_at' => 't_klaim.created_at',
            'status' => 't_klaim.status',
        ];
        $sortBy = $request->input('sort_by', 'id');
        if (! array_key_exists($sortBy, $allowedSort)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $paginator = $query
            ->orderBy($allowedSort[$sortBy], $sortDir)
            ->orderBy('t_klaim_detail.id', 'asc')
            ->orderBy('nilai.id', 'asc')
            ->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Data T_klaim detail nilai berhasil diambil',
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

        $data = T_klaim::where('id', $id)->first();
        $filesAwal = File_upload::where('id_klaim_awal', $id)->orderBy('id', 'asc')->get();
        $filesAkhir = File_upload::where('id_klaim_akhir', $id)->orderBy('id', 'asc')->get();

        $files = $filesAwal->concat($filesAkhir)->unique('id')->values();

        return response()->json([
            'success' => true,
            'message' => 'Data details T_klaim berhasil diambil',
            'data' => $data,
            'files' => $files,
            'files_awal' => $filesAwal->values(),
            'files_akhir' => $filesAkhir->values(),
        ]);
    }

    public function estimateHistories(Request $request)
    {
        $id = (int) $request->route('id');

        $rows = DB::table('t_klaim_estimate_histories as history')
            ->join('t_klaim_detail as detail', 'detail.id', '=', 'history.id_klaim_detail')
            ->leftJoin('t_klaim_detail_nilai as nilai', 'nilai.id', '=', 'history.id_klaim_detail_nilai')
            ->leftJoin('users', 'users.id', '=', 'history.user_id')
            ->where('history.id_klaim', $id)
            ->orderByDesc('history.id')
            ->select([
                'history.id',
                'history.id_klaim',
                'history.id_klaim_detail',
                'history.id_klaim_detail_nilai',
                'history.sub_jenis',
                'history.val_potensi',
                'history.val_klaim_awal',
                'history.val_klaim_akhir',
                'history.val_klaim_akhir_idr',
                'history.old_val_potensi',
                'history.old_val_klaim_awal',
                'history.old_val_klaim_akhir',
                'history.old_val_klaim_akhir_idr',
                'history.user_id',
                'history.created_at',
                'detail.no_urut',
                'detail.no_voyage_gab',
                'detail.keterangan',
                'nilai.val_potensi as current_val_potensi',
                'nilai.val_klaim_awal as current_val_klaim_awal',
                'nilai.val_klaim_akhir as current_val_klaim_akhir',
                'nilai.val_klaim_akhir_idr as current_val_klaim_akhir_idr',
                'users.name as user_name',
            ])
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'History perubahan estimasi klaim berhasil diambil',
            'data' => $rows,
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_klaim = new T_klaim;
            $t_klaim->id_vessel = $request->input('id_vessel');
            $t_klaim->no_klaim_awal = $request->input('no_klaim_awal');
            $t_klaim->tgl_klaim_awal = $request->input('tgl_klaim_awal');
            $t_klaim->jenis_klaim = $request->input('jenis_klaim');
            $t_klaim->no_klaim_akhir = $request->input('no_klaim_akhir');
            $t_klaim->tgl_klaim_akhir = $request->input('tgl_klaim_akhir');
            $t_klaim->periode_klaim = $request->input('periode_klaim');
            $t_klaim->status = 'OPEN';
            $t_klaim->user_id = Auth::id();
            $t_klaim->save();
            $this->validateIncomingUploadFilesArePdf($request);
            $this->storeKlaimFiles($request, (int) $t_klaim->id);
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim berhasil ditambah',
                'data' => [
                    'id' => $t_klaim->id,
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
            $hasApprovedDetail = T_klaim_detail::where('id_klaim', $id)
                ->where('status', 'APPROVE')
                ->exists();
            if ($hasApprovedDetail) {
                DB::rollBack();

                return response()->json([
                    'success' => false,
                    'message' => 'Klaim yang sudah APPROVE tidak bisa diubah.',
                ], 422);
            }

            $t_klaim = T_klaim::where('id', $id)->firstOrFail();
            $t_klaim->id_vessel = $request->input('id_vessel');
            $t_klaim->no_klaim_awal = $request->input('no_klaim_awal');
            $t_klaim->tgl_klaim_awal = $request->input('tgl_klaim_awal');
            $t_klaim->jenis_klaim = $request->input('jenis_klaim');
            $t_klaim->no_klaim_akhir = $request->input('no_klaim_akhir');
            $t_klaim->tgl_klaim_akhir = $request->input('tgl_klaim_akhir');
            $t_klaim->periode_klaim = $request->input('periode_klaim');
            $t_klaim->user_id = Auth::id();
            $t_klaim->save();
            $this->validateIncomingUploadFilesArePdf($request);
            $this->storeKlaimFiles($request, (int) $t_klaim->id);
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim berhasil diubah',
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
            $hasApprovedDetail = T_klaim_detail::where('id_klaim', $id)
                ->where('status', 'APPROVE')
                ->exists();
            if ($hasApprovedDetail) {
                DB::rollBack();

                return response()->json([
                    'success' => false,
                    'message' => 'Klaim yang sudah APPROVE tidak bisa dihapus.',
                ], 422);
            }

            $t_klaim = T_klaim::where('id', $id)->firstOrFail();

            $detailIds = T_klaim_detail::where('id_klaim', $id)->pluck('id')->all();
            if (! empty($detailIds)) {
                $lookupIds = array_values(array_unique(array_merge($detailIds, [(int) $id])));
                $files = File_upload::whereIn('id_klaim_awal', $lookupIds)
                    ->orWhereIn('id_klaim_akhir', $lookupIds)
                    ->get();

                foreach ($files as $file) {
                    if ($file->nama_file) {
                        $path = public_path('storage/'.ltrim((string) $file->nama_file, '/'));
                        if (file_exists($path)) {
                            @unlink($path);
                        }
                    }
                    $file->delete();
                }

                T_klaim_detail_nilai::whereIn('id_klaim_detail', $detailIds)->delete();
                T_klaim_detail::whereIn('id', $detailIds)->delete();
            }

            $t_klaim->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim berhasil dihapus',
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function approve(Request $request)
    {
        $id = (int) $request->route('id');

        try {
            DB::beginTransaction();

            $user = Auth::user();
            if (! $user || ! ($user->hasRole('approval') || $user->hasRole('superadmin'))) {
                DB::rollBack();

                return response()->json([
                    'success' => false,
                    'message' => 'Hanya role approval atau superadmin yang boleh melakukan approve.',
                ], 403);
            }
            $userId = (int) $user->id;

            $klaim = T_klaim::where('id', $id)->firstOrFail();

            $details = T_klaim_detail::where('id_klaim', $id)->lockForUpdate()->get();
            foreach ($details as $detail) {
                $this->refreshEstimateHistoriesForApproval($klaim, $detail, $request, $userId);

                $detail->status = 'APPROVE';
                $detail->user_id = $userId;
                $detail->save();

                DB::table('t_klaim_detail_nilai')
                    ->where('id_klaim_detail', $detail->id)
                    ->update([
                        'status' => 'APPROVE',
                        'user_id' => $userId,
                        'updated_at' => now(),
                    ]);
            }

            $klaim->status = 'APPROVE';
            $klaim->user_id = $userId;
            $klaim->save();
            $this->forgetPendingEstimateHistoryCache($this->estimateHistoryPendingCacheKey((int) $klaim->id));

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Approve Klaim berhasil diproses.',
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function unapprove(Request $request)
    {
        $id = (int) $request->route('id');

        try {
            DB::beginTransaction();

            $user = Auth::user();
            if (! $user || ! ($user->hasRole('approval') || $user->hasRole('superadmin'))) {
                DB::rollBack();

                return response()->json([
                    'success' => false,
                    'message' => 'Hanya role approval atau superadmin yang boleh melakukan unapprove.',
                ], 403);
            }

            $klaim = T_klaim::where('id', $id)->firstOrFail();
            $this->rememberCurrentEstimateValuesForNextApproval($klaim);

            $details = T_klaim_detail::where('id_klaim', $id)->get();
            foreach ($details as $detail) {
                $detail->status = 'OPEN';
                $detail->user_id = Auth::id();
                $detail->save();

                DB::table('t_klaim_detail_nilai')
                    ->where('id_klaim_detail', $detail->id)
                    ->update([
                        'status' => 'OPEN',
                        'user_id' => Auth::id(),
                        'updated_at' => now(),
                    ]);
            }

            $klaim->status = 'OPEN';
            $klaim->user_id = Auth::id();
            $klaim->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Unapprove Klaim berhasil diproses.',
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    private function validateIncomingUploadFilesArePdf(Request $request): void
    {
        $files = $this->extractIncomingUploadFiles($request);

        foreach ($files as $file) {
            if (! $file) {
                continue;
            }
            $ext = strtolower((string) $file->getClientOriginalExtension());
            if (! in_array($ext, ['pdf', 'jpg', 'png', 'jpeg'], true)) {
                throw ValidationException::withMessages([
                    'files' => 'File upload hanya boleh PDF/JPG/JPEG/PNG.',
                ]);
            }
        }
    }

    private function storeKlaimFiles(Request $request, int $klaimId): void
    {
        $incomingFiles = $this->extractIncomingUploadFiles($request);
        if (empty($incomingFiles)) {
            return;
        }

        $scope = strtoupper(trim((string) $request->input('upload_scope', '')));
        if ($scope === 'AWAL') {
            $column = 'id_klaim_awal';
        } elseif ($scope === 'AKHIR') {
            $column = 'id_klaim_akhir';
        } else {
            $hasFinalKlaim = trim((string) $request->input('no_klaim_akhir', '')) !== ''
                && trim((string) $request->input('tgl_klaim_akhir', '')) !== '';
            $column = $hasFinalKlaim ? 'id_klaim_akhir' : 'id_klaim_awal';
        }

        foreach ($incomingFiles as $file) {
            if (! $file) {
                continue;
            }
            $path = FileUploadHelper::storeWithOriginalName($file, 'uploads/klaim');
            $upload = new File_upload;
            $upload->id_klaim_awal = null;
            $upload->id_klaim_akhir = null;
            $upload->{$column} = $klaimId;
            $upload->nama_file = $path;
            $upload->save();
        }
    }
}
