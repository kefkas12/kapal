<?php

namespace App\Http\Controllers;

use App\Models\File_upload;
use App\Models\M_grade;
use App\Models\Settings;
use App\Models\T_doc_cargo;
use App\Models\T_klaim;
use App\Models\T_master_cable;
use App\Support\FileUploadHelper;
use App\Support\SimpleSpreadsheetReader;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Validation\ValidationException;

class T_doc_cargoController extends Controller
{
    private function actingUserId(): ?int
    {
        return Auth::id() ?? DB::table('users')->orderBy('id')->value('id');
    }

    private function ensureGradeNotUsedOnCable(int $idCable, int $idGrade, ?int $excludeDocCargoId = null): void
    {
        $query = T_doc_cargo::query()
            ->where('id_cable', $idCable)
            ->where('id_grade', $idGrade);

        if (!is_null($excludeDocCargoId)) {
            $query->where('id', '!=', $excludeDocCargoId);
        }

        if ($query->exists()) {
            throw ValidationException::withMessages([
                'id_grade' => 'Grade untuk No Voyage ini sudah pernah digunakan. Pilih grade lain.',
            ]);
        }
    }

    private function docCargoColumns(): array
    {
        return Schema::getColumnListing('t_doc_cargo');
    }

    private function docCargoDetailColumns(): array
    {
        return Schema::getColumnListing('t_doc_cargo_detail');
    }

    private function normalizeImportHeader(?string $value): string
    {
        return $this->normalizeLookup($value);
    }

    private function docCargoImportFieldLabels(): array
    {
        return [
            'no_voyage_gab' => 'No Voyage',
            'grade' => 'Grade',
            'price_bbl' => 'Price (USD/Bbl)',
            'bill_of_lading' => 'Bill of Lading (Bbl 60F)',
            'act_receipt' => 'Actual Receipt (KL 15C)',
            'r1' => 'Diff R1 (Bbl 60F)',
            'ratio_r1' => 'R1 (%)',
            'r2' => 'Diff R2 (Bbl 60F)',
            'ratio_r2' => 'R2 (%)',
            'r3' => 'Diff R3 (Bbl 60F)',
            'ratio_r3' => 'R3 (%)',
            'r4' => 'Diff R4 (Bbl 60F)',
            'ratio_r4' => 'R4 (%)',
            'est_discharge' => 'Discharge Time / CP (day)',
            'act_discharge' => 'Actual Discharge Time (day)',
            'overdue_discharge' => 'Overdue Discharge Time (day)',
            'est_claim_pumping' => 'Est Claim Slow Pumping (USD)',
            'est_claim_bunker' => 'Est Claim Over Bunker (IDR)',
            'est_claim_transport' => 'Est Claim Transport Loss (USD)',
            'flow_rate_pump' => 'Flow Rate Pump (KL/Hr)',
            'nomor_pompa' => 'Nomor Pompa',
            'rpm' => 'RPM',
            'remarks' => 'Remarks',
            'start_time' => 'Start Time Discharge Time',
            'stop_time' => 'Stop Time Discharge Time',
        ];
    }

    private function docCargoImportColumns(): array
    {
        return [
            'no_voyage_gab' => ['NOVOYAGE', 'NOVOYAGEGAB'],
            'grade' => ['GRADE'],
            'price_bbl' => ['PRICEUSDBBL', 'PRICE'],
            'bill_of_lading' => ['BILLOFLADINGBBL60F', 'BILLOFLADING', 'BL'],
            'act_receipt' => ['ACTUALRECEIPTKL15C', 'ACTUALRECEIPT'],
            'r1' => ['DIFFR1BBL60F', 'DIFFR1'],
            'ratio_r1' => ['R1', 'R1PERCENT'],
            'r2' => ['DIFFR2BBL60F', 'DIFFR2'],
            'ratio_r2' => ['R2', 'R2PERCENT'],
            'r3' => ['DIFFR3BBL60F', 'DIFFR3'],
            'ratio_r3' => ['R3', 'R3PERCENT'],
            'r4' => ['DIFFR4BBL60F', 'DIFFR4'],
            'ratio_r4' => ['R4', 'R4PERCENT'],
            'est_discharge' => ['DISCHARGETIMECPDAY', 'ESTDISCHARGE'],
            'act_discharge' => ['ACTUALDISCHARGETIMEDAY', 'ACTDISCHARGE'],
            'overdue_discharge' => ['OVERDUEDISCHARGETIMEDAY', 'OVERDUEDISCHARGE'],
            'est_claim_pumping' => ['ESTCLAIMSLOWPUMPINGUSD', 'ESTCLAIMPUMPING'],
            'est_claim_bunker' => ['ESTCLAIMOVERBUNKERIDR', 'ESTCLAIMBUNKER'],
            'est_claim_transport' => ['ESTCLAIMTRANSPORTLOSSUSD', 'ESTCLAIMTRANSPORT'],
            'flow_rate_pump' => ['FLOWRATEPUMPKLHR', 'FLOWRATEPUMP'],
            'nomor_pompa' => ['NOMORPOMPA'],
            'rpm' => ['RPM'],
            'remarks' => ['REMARKS'],
            'start_time' => ['STARTTIMEDISCHARGETIME', 'STARTTIME'],
            'stop_time' => ['STOPTIMEDISCHARGETIME', 'STOPTIME'],
        ];
    }

    private function isImportValueBlank($value): bool
    {
        return $value === null || trim((string) $value) === '';
    }

    private function normalizeLookup(?string $value): string
    {
        $upper = strtoupper(trim((string) $value));
        return preg_replace('/[^A-Z0-9]/', '', $upper) ?? '';
    }

    private function tokenizeAlias(?string $value): array
    {
        $tokens = preg_split('/[^A-Z0-9]+/', strtoupper(trim((string) $value))) ?: [];
        return array_values(array_filter($tokens, fn ($token) => $token !== ''));
    }

    private function buildTextAliases(?string $value): array
    {
        $normalized = $this->normalizeLookup($value);
        $tokens = $this->tokenizeAlias($value);
        $aliases = [];

        if ($normalized !== '') {
            $aliases[] = $normalized;
        }

        if ($tokens !== []) {
            $initials = implode('', array_map(fn ($token) => substr($token, 0, 1), $tokens));
            if ($initials !== '') {
                $aliases[] = $initials;
            }

            $hybrid = '';
            foreach ($tokens as $index => $token) {
                if ($index === 0) {
                    $hybrid .= strlen($token) <= 3 ? $token : substr($token, 0, 1);
                } else {
                    $hybrid .= $token;
                }
            }
            if ($hybrid !== '') {
                $aliases[] = $hybrid;
            }
        }

        return array_values(array_unique(array_filter($aliases)));
    }

    private function cleanImportCell(array $row, int $index): ?string
    {
        $value = trim((string) ($row[$index] ?? ''));
        return $value === '' ? null : $value;
    }

    private function excelDateToDateTime($value, ?int $defaultYear = null): ?string
    {
        if ($value === null || $value === '') {
            return null;
        }

        if (is_numeric($value)) {
            $serial = (float) $value;
            if ($serial > 0) {
                $unix = (int) round(($serial - 25569) * 86400);
                return gmdate('Y-m-d H:i:s', $unix);
            }
        }

        $text = trim((string) $value);
        if ($text === '') {
            return null;
        }

        if ($defaultYear && !preg_match('/\b\d{4}\b/', $text)) {
            $text .= ' ' . $defaultYear;
        }

        $ts = strtotime($text);
        if ($ts === false) {
            return null;
        }

        return date('Y-m-d H:i:s', $ts);
    }

    private function detectImportReportYear(array $rows): int
    {
        foreach (array_slice($rows, 0, 5) as $row) {
            foreach ($row as $cell) {
                if (preg_match('/\b(20\d{2})\b/', (string) $cell, $matches)) {
                    return (int) $matches[1];
                }
            }
        }

        return (int) date('Y');
    }

    private function normalizeVoyageNumber(?string $voyage, int $reportYear): ?string
    {
        $digits = preg_replace('/\D/', '', (string) $voyage) ?? '';
        if ($digits === '') {
            return null;
        }

        if (strlen($digits) >= 5) {
            return substr($digits, -5);
        }

        if (strlen($digits) <= 3) {
            return substr((string) $reportYear, -2) . str_pad($digits, 3, '0', STR_PAD_LEFT);
        }

        return str_pad($digits, 5, '0', STR_PAD_LEFT);
    }

    private function voyageYearPrefix(int $reportYear): string
    {
        if ($reportYear >= 2000) {
            return substr((string) $reportYear, -2);
        }

        return str_pad((string) $reportYear, 2, '0', STR_PAD_LEFT);
    }

    private function buildVesselAliases(object $vessel): array
    {
        $aliases = [
            $this->normalizeLookup($vessel->kode_vessel ?? ''),
            $this->normalizeLookup($vessel->nama_vessel ?? ''),
        ];

        $tokens = $this->tokenizeAlias($vessel->nama_vessel ?? '');
        $compact = '';
        foreach ($tokens as $token) {
            if ($token === '') {
                continue;
            }
            if (ctype_digit($token)) {
                $compact .= $token;
            } else {
                $compact .= substr($token, 0, min(2, strlen($token)));
            }
        }

        if ($compact !== '') {
            $aliases[] = $this->normalizeLookup($compact);
        }

        $aliases = array_merge($aliases, $this->buildTextAliases($vessel->nama_vessel ?? ''));

        return array_values(array_unique(array_filter($aliases)));
    }

    private function parseImportRows(array $rows, ?int $forcedYear = null): array
    {
        $reportYear = $forcedYear ?: $this->detectImportReportYear($rows);
        $carry = [];
        $parsed = [];

        for ($i = 0; $i < count($rows); $i++) {
            $row = $rows[$i];
            $cells = [];
            for ($col = 0; $col <= 33; $col++) {
                $value = $this->cleanImportCell($row, $col);
                if ($value !== null) {
                    $carry[$col] = $value;
                    $cells[$col] = $value;
                    continue;
                }

                // Kolom gabungan pada format foto biasanya dibiarkan kosong di baris lanjutan.
                if (in_array($col, [1, 2, 3, 4, 10, 11], true) && isset($carry[$col])) {
                    $cells[$col] = $carry[$col];
                } else {
                    $cells[$col] = null;
                }
            }

            $joined = $this->normalizeLookup(implode('|', array_filter($cells, fn ($value) => $value !== null)));
            if (
                $joined === '' ||
                str_contains($joined, 'HEREWITHUPDATEDAILYREPORT') ||
                str_contains($joined, 'VESSELSHIPMENT') ||
                str_contains($joined, 'KL15C') ||
                str_contains($joined, 'QUANTITY') ||
                str_contains($joined, 'NOVOYVESSELNAME') ||
                str_contains($joined, 'STARTTIME') ||
                str_contains($joined, 'BLSFALDIFFR1R1')
            ) {
                continue;
            }

            $voyRaw = $cells[1] ?? null;
            $voyDigits = preg_replace('/\D/', '', (string) $voyRaw) ?? '';
            $hasVoy = $voyDigits !== '';
            $hasVessel = ($cells[2] ?? null) !== null;
            $hasLoadingCargo = ($cells[5] ?? null) !== null;
            $hasDischargeCargo = ($cells[12] ?? null) !== null;

            if (!$hasVoy || !$hasVessel || (!$hasLoadingCargo && !$hasDischargeCargo)) {
                continue;
            }

            $parsed[] = [
                'row_number' => $i + 1,
                'report_year' => $reportYear,
                'voy' => $cells[1],
                'vessel_name' => $cells[2],
                'loading_date' => $this->excelDateToDateTime($cells[3], $reportYear),
                'loading_port' => $cells[4],
                'loading_cargo' => $cells[5],
                'bill_of_lading' => $cells[6],
                'sfal' => $cells[7],
                'r1' => $cells[8],
                'ratio_r1' => $cells[9],
                'discharge_date' => $this->excelDateToDateTime($cells[10], $reportYear),
                'discharge_port' => $cells[11],
                'discharge_cargo' => $cells[12] ?? $cells[5],
                'sfbd' => $cells[13],
                'r2' => $cells[14],
                'ratio_r2' => $cells[15],
                'ar' => $cells[16],
                'r3' => $cells[17],
                'ratio_r3' => $cells[18],
                'r4' => $cells[19],
                'ratio_r4' => $cells[20],
                'start_time' => $this->excelDateToDateTime($cells[21], $reportYear),
                'stop_time' => $this->excelDateToDateTime($cells[22], $reportYear),
                'discharge_time' => $cells[23],
                'est_discharge' => $cells[24],
                'act_discharge' => $cells[25],
                'overdue_discharge' => $cells[26],
                'est_claim_pumping' => $cells[27],
                'est_claim_bunker' => $cells[28],
                'flow_rate_pump' => $cells[29],
                'nomor_pompa' => $cells[30],
                'pressure_pompa' => $cells[31],
                'rpm' => $cells[32],
                'remarks' => $cells[33],
            ];
        }

        $ordinalByGroup = [];
        $sequenceByBucket = [];
        foreach ($parsed as &$item) {
            $kind = (($item['r2'] ?? null) !== null || ($item['r3'] ?? null) !== null || ($item['r4'] ?? null) !== null) ? 'D' : 'L';
            $item['inferred_voyage_kind'] = $kind;

            $vesselKey = $this->normalizeLookup($item['vessel_name'] ?? '');
            $voyageKey = $this->normalizeVoyageNumber($item['voy'] ?? null, $reportYear)
                ?? (preg_replace('/\D/', '', (string) ($item['voy'] ?? '')) ?: '');
            $bucketKey = $vesselKey . '|' . $kind;
            $groupKey = $bucketKey . '|' . $voyageKey;

            if (!isset($ordinalByGroup[$groupKey])) {
                $sequenceByBucket[$bucketKey] = ($sequenceByBucket[$bucketKey] ?? 0) + 1;
                $ordinalByGroup[$groupKey] = $sequenceByBucket[$bucketKey];
            }

            $item['fallback_group_ordinal'] = $ordinalByGroup[$groupKey];
        }
        unset($item);

        return $parsed;
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

    private function percentPointsToDecimal(float $value): float
    {
        return $value / 100;
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

    private function formatImportedNumber($value): ?string
    {
        if ($value === null || $value === '') {
            return null;
        }

        return number_format($this->toNumber($value), 6, '.', '');
    }

    private function formatImportedPercent($value): ?string
    {
        if ($value === null || $value === '') {
            return null;
        }

        $raw = trim((string) $value);
        $raw = str_replace('%', '', $raw);

        return number_format($this->toNumber($raw), 6, '.', '');
    }

    private function computeRatioPercentFromBillOfLading($diffValue, $billOfLadingValue): ?string
    {
        if ($this->isImportValueBlank($diffValue) || $this->isImportValueBlank($billOfLadingValue)) {
            return null;
        }

        $billOfLading = $this->toNumber($billOfLadingValue);
        if ($billOfLading == 0.0) {
            return null;
        }

        $diff = $this->toNumber($diffValue);

        return number_format(($diff / $billOfLading) * 100, 6, '.', '');
    }

    private function resolveGradeForImport(?string $gradeName, $priceBbl = null): array
    {
        $rawGrade = trim((string) $gradeName);
        if ($rawGrade === '') {
            throw ValidationException::withMessages([
                'file' => 'Grade wajib diisi.',
            ]);
        }

        $lookupKey = $this->resolveGradeLookupKey($rawGrade);
        $existing = M_grade::query()
            ->whereRaw('UPPER(TRIM(grade)) = ?', [strtoupper($rawGrade)])
            ->first(['id', 'grade', 'price_bbl']);

        if ($existing) {
            return [
                'id' => (int) $existing->id,
                'grade' => (string) $existing->grade,
                'price_bbl' => $existing->price_bbl,
                'lookup_key' => $lookupKey,
            ];
        }

        $grade = new M_grade();
        $grade->grade = strtoupper($rawGrade);
        $grade->price_bbl = $this->formatImportedNumber($priceBbl) ?? '1';
        $grade->user_id = $this->actingUserId();
        $grade->created_at = now();
        $grade->updated_at = now();
        $grade->save();

        return [
            'id' => (int) $grade->id,
            'grade' => (string) $grade->grade,
            'price_bbl' => $grade->price_bbl,
            'lookup_key' => $lookupKey,
        ];
    }

    private function parseDocCargoImportRows(array $rows): array
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
        foreach ($this->docCargoImportColumns() as $field => $aliases) {
            foreach ($normalizedHeaders as $index => $header) {
                if (in_array($header, $aliases, true)) {
                    $columnIndexes[$field] = $index;
                    break;
                }
            }
        }

        foreach (['no_voyage_gab', 'grade'] as $requiredField) {
            if (!array_key_exists($requiredField, $columnIndexes)) {
                $requiredLabel = $this->docCargoImportFieldLabels()[$requiredField] ?? $requiredField;
                throw ValidationException::withMessages([
                    'file' => 'Header wajib tidak ditemukan: ' . $requiredLabel . '.',
                ]);
            }
        }

        $groups = [];
        foreach (array_slice($rows, 1) as $offset => $row) {
            $item = ['row_number' => $offset + 2];
            $hasValue = false;

            foreach ($columnIndexes as $field => $index) {
                $value = trim((string) ($row[$index] ?? ''));
                if ($value !== '') {
                    $hasValue = true;
                }
                if (in_array($field, ['start_time', 'stop_time'], true)) {
                    $item[$field] = $value === '' ? null : $this->excelDateToDateTime($value);
                } else {
                    $item[$field] = $value === '' ? null : $value;
                }
            }

            if (!$hasValue) {
                continue;
            }

            $groupKey = $this->normalizeLookup($item['no_voyage_gab'] ?? '') . '|' . $this->normalizeLookup($item['grade'] ?? '');
            if ($groupKey === '|' || $groupKey === '') {
                continue;
            }

            if (!isset($groups[$groupKey])) {
                $groups[$groupKey] = [
                    'group_key' => $groupKey,
                    'row_numbers' => [],
                    'first_row_number' => $item['row_number'],
                    'fields' => [],
                    'detail_items' => [],
                ];
            }

            $groups[$groupKey]['row_numbers'][] = $item['row_number'];
            foreach ($columnIndexes as $field => $_index) {
                if (in_array($field, ['start_time', 'stop_time'], true)) {
                    continue;
                }

                if (!$this->isImportValueBlank($item[$field] ?? null)) {
                    $groups[$groupKey]['fields'][$field] = $item[$field];
                }
            }

            if (!$this->isImportValueBlank($item['start_time'] ?? null) || !$this->isImportValueBlank($item['stop_time'] ?? null)) {
                $groups[$groupKey]['detail_items'][] = [
                    'row_number' => $item['row_number'],
                    'start_time' => $item['start_time'] ?? null,
                    'stop_time' => $item['stop_time'] ?? null,
                ];
            }
        }

        if ($groups === []) {
            throw ValidationException::withMessages([
                'file' => 'Tidak ada baris data yang bisa diproses pada file import.',
            ]);
        }

        return [
            'groups' => array_values($groups),
            'present_columns' => array_keys($columnIndexes),
        ];
    }

    private function buildDocCargoImportPayload(array $fields, object $cable, array $gradeMeta): array
    {
        $billOfLading = $this->formatImportedNumber($fields['bill_of_lading'] ?? null);
        $priceBbl = $this->formatImportedNumber($fields['price_bbl'] ?? ($gradeMeta['price_bbl'] ?? null));

        return [
            'id_cable' => (int) $cable->id,
            'id_grade' => (int) $gradeMeta['id'],
            'price_bbl' => $priceBbl,
            'bill_of_lading' => $billOfLading,
            'act_receipt' => $this->formatImportedNumber($fields['act_receipt'] ?? null),
            'r1' => $this->formatImportedNumber($fields['r1'] ?? null),
            'ratio_r1' => $this->formatImportedPercent($fields['ratio_r1'] ?? null) ?: $this->computeRatioPercentFromBillOfLading($fields['r1'] ?? null, $fields['bill_of_lading'] ?? null),
            'r2' => $this->formatImportedNumber($fields['r2'] ?? null),
            'ratio_r2' => $this->formatImportedPercent($fields['ratio_r2'] ?? null) ?: $this->computeRatioPercentFromBillOfLading($fields['r2'] ?? null, $fields['bill_of_lading'] ?? null),
            'r3' => $this->formatImportedNumber($fields['r3'] ?? null),
            'ratio_r3' => $this->formatImportedPercent($fields['ratio_r3'] ?? null) ?: $this->computeRatioPercentFromBillOfLading($fields['r3'] ?? null, $fields['bill_of_lading'] ?? null),
            'r4' => $this->formatImportedNumber($fields['r4'] ?? null),
            'ratio_r4' => $this->formatImportedPercent($fields['ratio_r4'] ?? null) ?: $this->computeRatioPercentFromBillOfLading($fields['r4'] ?? null, $fields['bill_of_lading'] ?? null),
            'est_discharge' => $this->formatImportedNumber($fields['est_discharge'] ?? null),
            'act_discharge' => $this->formatImportedNumber($fields['act_discharge'] ?? null),
            'overdue_discharge' => $this->formatImportedNumber($fields['overdue_discharge'] ?? null),
            'est_claim_pumping' => $this->formatImportedNumber($fields['est_claim_pumping'] ?? null),
            'est_claim_bunker' => $this->formatImportedNumber($fields['est_claim_bunker'] ?? null),
            'est_claim_transport' => $this->formatImportedNumber($fields['est_claim_transport'] ?? null),
            'flow_rate_pump' => $this->formatImportedNumber($fields['flow_rate_pump'] ?? null),
            'nomor_pompa' => $fields['nomor_pompa'] ?? null,
            'rpm' => $this->formatImportedNumber($fields['rpm'] ?? null),
            'remarks' => $fields['remarks'] ?? null,
        ];
    }

    private function buildDocCargoImportTemplateHtml(): string
    {
        $headers = array_values($this->docCargoImportFieldLabels());
        $sampleRows = [
            [
                'AB2F8/25001/L', 'B40', '65.500000', '3559.513000', '3548.700000',
                '-3.411000', '-0.095827', '', '', '', '', '', '',
                '', '', '', '', '', '',
                '', '01', '1200.000000', 'Contoh row 1', '2025-05-10 08:00:00', '2025-05-10 14:00:00',
            ],
            [
                'AB2F8/25001/L', 'B40', '65.500000', '3559.513000', '3548.700000',
                '-3.411000', '-0.095827', '', '', '', '', '', '',
                '', '', '', '', '', '',
                '', '01', '1200.000000', 'Contoh row 2', '2025-05-10 15:00:00', '2025-05-10 21:00:00',
            ],
        ];

        $html = '<table border="1"><tr>';
        foreach ($headers as $header) {
            $html .= '<th>' . e($header) . '</th>';
        }
        $html .= '</tr>';

        foreach ($sampleRows as $sampleRow) {
            $html .= '<tr>';
            foreach ($sampleRow as $value) {
                $html .= '<td>' . e((string) $value) . '</td>';
            }
            $html .= '</tr>';
        }

        $html .= '</table>';

        return $html;
    }

    private function buildDocCargoExportHtml(): string
    {
        $labels = $this->docCargoImportFieldLabels();
        $headers = array_keys($labels);

        $docCargoRows = DB::table('t_doc_cargo')
            ->leftJoin('t_doc_cargo_detail', 't_doc_cargo_detail.id_doc_cargo', '=', 't_doc_cargo.id')
            ->select(
                't_doc_cargo.id',
                't_doc_cargo.no_voyage_gab',
                't_doc_cargo.grade',
                't_doc_cargo.price_bbl',
                't_doc_cargo.bill_of_lading',
                't_doc_cargo.act_receipt',
                't_doc_cargo.r1',
                't_doc_cargo.ratio_r1',
                't_doc_cargo.r2',
                't_doc_cargo.ratio_r2',
                't_doc_cargo.r3',
                't_doc_cargo.ratio_r3',
                't_doc_cargo.r4',
                't_doc_cargo.ratio_r4',
                't_doc_cargo.est_discharge',
                't_doc_cargo.act_discharge',
                't_doc_cargo.overdue_discharge',
                't_doc_cargo.est_claim_pumping',
                't_doc_cargo.est_claim_bunker',
                't_doc_cargo.est_claim_transport',
                't_doc_cargo.flow_rate_pump',
                't_doc_cargo.nomor_pompa',
                't_doc_cargo.rpm',
                't_doc_cargo.remarks',
                't_doc_cargo_detail.start_time',
                't_doc_cargo_detail.stop_time'
            )
            ->orderBy('t_doc_cargo.id')
            ->orderBy('t_doc_cargo_detail.id')
            ->get();

        $html = '<table border="1"><tr>';
        foreach ($headers as $header) {
            $html .= '<th>' . e($labels[$header]) . '</th>';
        }
        $html .= '</tr>';

        foreach ($docCargoRows as $row) {
            $html .= '<tr>';
            foreach ($headers as $header) {
                $html .= '<td>' . e((string) ($row->{$header} ?? '')) . '</td>';
            }
            $html .= '</tr>';
        }

        $html .= '</table>';

        return $html;
    }

    private function resolveGradeId(array $row, array $grades): ?int
    {
        $normalized = $this->resolveGradeLookupKey($row['loading_cargo'] ?? $row['discharge_cargo'] ?? '');
        return $grades[$normalized]['id'] ?? null;
    }

    private function ensureGradeExists(array $row, array &$grades): array
    {
        $cargoRaw = trim((string) ($row['loading_cargo'] ?? $row['discharge_cargo'] ?? ''));
        $lookupKey = $this->resolveGradeLookupKey($cargoRaw);

        if ($lookupKey !== '' && isset($grades[$lookupKey])) {
            return $grades[$lookupKey];
        }

        $gradeName = $cargoRaw !== '' ? strtoupper($cargoRaw) : 'UNKNOWN';
        $existing = M_grade::query()
            ->whereRaw('UPPER(TRIM(grade)) = ?', [$gradeName])
            ->first(['id', 'grade', 'price_bbl']);

        if ($existing) {
            $meta = [
                'id' => (int) $existing->id,
                'price_bbl' => $existing->price_bbl,
            ];
            $grades[$lookupKey !== '' ? $lookupKey : $this->normalizeLookup($existing->grade)] = $meta;
            return $meta;
        }

        $grade = new M_grade();
        $grade->grade = $gradeName;
        $grade->price_bbl = '1';
        $grade->user_id = $this->actingUserId();
        $grade->created_at = now();
        $grade->updated_at = now();
        $grade->save();

        $meta = [
            'id' => (int) $grade->id,
            'price_bbl' => $grade->price_bbl,
        ];
        $grades[$lookupKey !== '' ? $lookupKey : $this->normalizeLookup($gradeName)] = $meta;

        return $meta;
    }

    private function resolveGradeLookupKey(?string $cargo): string
    {
        $normalized = $this->normalizeLookup($cargo);
        $cargoAliases = [
            'BIOSOLAR' => 'B40',
            'SOLAR' => 'B40',
            'B30' => 'B40',
        ];
        if (isset($cargoAliases[$normalized])) {
            $normalized = $this->normalizeLookup($cargoAliases[$normalized]);
        }

        return $normalized;
    }

    private function resolveCableRow(array $row, array $cables, array $vessels): ?array
    {
        $resolution = $this->resolveCableWithDebug($row, $cables, $vessels);
        return $resolution['cable'] ?? null;
    }

    private function resolveCableWithDebug(array $row, array $cables, array $vessels): array
    {
        $reportYear = (int) ($row['report_year'] ?? date('Y'));
        $voyage = $this->normalizeVoyageNumber($row['voy'] ?? null, $reportYear);
        $voyDigits = preg_replace('/\D/', '', (string) ($row['voy'] ?? '')) ?? '';
        if ($voyage === null && $voyDigits === '') {
            return [
                'cable' => null,
                'reason' => 'voyage kosong atau tidak valid',
            ];
        }

        $loadingPortAliases = $this->buildTextAliases($row['loading_port'] ?? '');
        $dischargePortAliases = $this->buildTextAliases($row['discharge_port'] ?? '');
        $vesselName = $this->normalizeLookup($row['vessel_name'] ?? '');
        $loadingDate = $row['loading_date'] ? date('m-d', strtotime($row['loading_date'])) : null;
        $dischargeDate = $row['discharge_date'] ? date('m-d', strtotime($row['discharge_date'])) : null;
        $voyageSuffix = substr(str_pad($voyDigits, 3, '0', STR_PAD_LEFT), -3);
        $reportYearPrefix = $this->voyageYearPrefix($reportYear);
        $kind = strtoupper((string) ($row['inferred_voyage_kind'] ?? ''));

        $best = null;
        $bestScore = -1;

        foreach ($cables as $cable) {
            $jenisVoyage = strtoupper((string) ($cable['jenis_voyage'] ?? ''));
            if ($kind === 'L' && $jenisVoyage !== 'L') {
                continue;
            }
            if ($kind === 'D' && !str_starts_with($jenisVoyage, 'D')) {
                continue;
            }

            $cableVoyage = (string) ($cable['no_voyage'] ?? '');
            $cableVoyageDigits = preg_replace('/\D/', '', $cableVoyage) ?? '';
            if ($cableVoyageDigits !== '' && !str_starts_with($cableVoyageDigits, $reportYearPrefix)) {
                continue;
            }

            $score = 0;
            if ($voyage !== null && $cableVoyage === $voyage) {
                $score += 120;
            } elseif ($voyageSuffix !== '' && str_ends_with($cableVoyageDigits, $voyageSuffix)) {
                $score += 70;
            } else {
                continue;
            }

            $cableAtdAliases = $this->buildTextAliases($cable['atd_port'] ?? '');
            $cableAtaAliases = $this->buildTextAliases($cable['ata_port'] ?? '');

            if ($loadingPortAliases !== [] && array_intersect($loadingPortAliases, $cableAtdAliases) !== []) {
                $score += 90;
            }
            if ($dischargePortAliases !== [] && array_intersect($dischargePortAliases, $cableAtaAliases) !== []) {
                $score += 90;
            }
            if ($loadingDate && !empty($cable['atd_time']) && date('m-d', strtotime($cable['atd_time'])) === $loadingDate) {
                $score += 20;
            }
            if ($dischargeDate && !empty($cable['ata_time']) && date('m-d', strtotime($cable['ata_time'])) === $dischargeDate) {
                $score += 20;
            }

            $aliases = $vessels[(int) $cable['id_vessel']]['aliases'] ?? [];
            foreach ($aliases as $alias) {
                if ($alias !== '' && ($alias === $vesselName || str_contains($vesselName, $alias) || str_contains($alias, $vesselName))) {
                    $score += 100;
                    break;
                }
            }

            if ($score > $bestScore) {
                $best = $cable;
                $bestScore = $score;
            }
        }

        if ($bestScore >= 80) {
            return [
                'cable' => $best,
                'reason' => null,
            ];
        }

        $fallbackCandidates = [];
        foreach ($cables as $cable) {
            $aliases = $vessels[(int) $cable['id_vessel']]['aliases'] ?? [];
            $matchesVessel = false;
            foreach ($aliases as $alias) {
                if ($alias !== '' && ($alias === $vesselName || str_contains($vesselName, $alias) || str_contains($alias, $vesselName))) {
                    $matchesVessel = true;
                    break;
                }
            }
            if (!$matchesVessel) {
                continue;
            }

            $jenisVoyage = strtoupper((string) ($cable['jenis_voyage'] ?? ''));
            if ($kind === 'L' && $jenisVoyage !== 'L') {
                continue;
            }
            if ($kind === 'D' && !str_starts_with($jenisVoyage, 'D')) {
                continue;
            }

            $cableVoyageDigits = preg_replace('/\D/', '', (string) ($cable['no_voyage'] ?? '')) ?? '';
            if ($cableVoyageDigits !== '' && !str_starts_with($cableVoyageDigits, $reportYearPrefix)) {
                continue;
            }

            $cableAtdAliases = $this->buildTextAliases($cable['atd_port'] ?? '');
            $cableAtaAliases = $this->buildTextAliases($cable['ata_port'] ?? '');
            if ($loadingPortAliases !== [] && array_intersect($loadingPortAliases, $cableAtdAliases) === []) {
                continue;
            }
            if ($dischargePortAliases !== [] && array_intersect($dischargePortAliases, $cableAtaAliases) === []) {
                continue;
            }

            $fallbackCandidates[] = $cable;
        }

        if ($fallbackCandidates !== []) {
            usort($fallbackCandidates, function ($left, $right) {
                $leftVoy = (int) preg_replace('/\D/', '', (string) ($left['no_voyage'] ?? ''));
                $rightVoy = (int) preg_replace('/\D/', '', (string) ($right['no_voyage'] ?? ''));
                if ($leftVoy !== $rightVoy) {
                    return $leftVoy <=> $rightVoy;
                }

                $leftJenis = strtoupper((string) ($left['jenis_voyage'] ?? ''));
                $rightJenis = strtoupper((string) ($right['jenis_voyage'] ?? ''));
                $leftOrder = $leftJenis === 'L' ? 0 : (int) preg_replace('/\D/', '', $leftJenis);
                $rightOrder = $rightJenis === 'L' ? 0 : (int) preg_replace('/\D/', '', $rightJenis);
                return $leftOrder <=> $rightOrder;
            });

            $ordinal = max(1, (int) ($row['fallback_group_ordinal'] ?? 1));
            $index = min(count($fallbackCandidates) - 1, $ordinal - 1);
            return [
                'cable' => $fallbackCandidates[$index],
                'reason' => 'fallback ordinal by vessel+kind digunakan',
            ];
        }

        return [
            'cable' => null,
            'reason' => 'tidak ada candidate cable yang score-nya cukup',
            'debug' => [
                'voy_input' => (string) ($row['voy'] ?? ''),
                'voy_resolved' => $voyage,
                'voy_suffix' => $voyageSuffix,
                'vessel' => (string) ($row['vessel_name'] ?? ''),
                'loading' => (string) ($row['loading_port'] ?? ''),
                'discharge' => (string) ($row['discharge_port'] ?? ''),
                'loading_date' => $loadingDate,
                'discharge_date' => $dischargeDate,
            ],
        ];
    }

    private function buildImportPayload(array $row, array $cable, int $gradeId, ?string $priceBbl): array
    {
        $dischargeTime = $row['discharge_time'] ?? $this->calcDischargeTime($row['start_time'] ?? null, $row['stop_time'] ?? null);
        $actReceipt = $row['ar'] ?? null;
        $estDischarge = $row['est_discharge'] ?? null;
        $actDischarge = $row['act_discharge'] ?? $dischargeTime;
        $overdueDischarge = $row['overdue_discharge'] ?? null;

        $pumpingRate = $this->toNumber($cable['pumping_rate'] ?? null);
        if (($estDischarge === null || $estDischarge === '') && $actReceipt !== null && $actReceipt !== '' && $pumpingRate > 0) {
            $estDischarge = number_format($this->toNumber($actReceipt) / $pumpingRate / 24, 6, '.', '');
        }

        if (($overdueDischarge === null || $overdueDischarge === '') && $actDischarge !== null && $actDischarge !== '' && $estDischarge !== null && $estDischarge !== '') {
            $overdueDischarge = number_format($this->toNumber($actDischarge) - $this->toNumber($estDischarge), 6, '.', '');
        }

        return [
            'id_cable' => $cable['id'],
            'id_grade' => $gradeId,
            'price_bbl' => $priceBbl,
            'bill_of_lading' => $this->formatImportedNumber($row['bill_of_lading'] ?? null),
            'r1' => $this->formatImportedNumber($row['r1'] ?? null),
            'ratio_r1' => $this->formatImportedPercent($row['ratio_r1'] ?? null),
            'r2' => $this->formatImportedNumber($row['r2'] ?? null),
            'ratio_r2' => $this->formatImportedPercent($row['ratio_r2'] ?? null),
            'r3' => $this->formatImportedNumber($row['r3'] ?? null),
            'ratio_r3' => $this->formatImportedPercent($row['ratio_r3'] ?? null),
            'r4' => $this->formatImportedNumber($row['r4'] ?? null),
            'ratio_r4' => $this->formatImportedPercent($row['ratio_r4'] ?? null),
            'act_receipt' => $this->formatImportedNumber($actReceipt),
            'est_discharge' => $this->formatImportedNumber($estDischarge),
            'act_discharge' => $this->formatImportedNumber($actDischarge),
            'overdue_discharge' => $this->formatImportedNumber($overdueDischarge),
            'est_claim_pumping' => $this->formatImportedNumber($row['est_claim_pumping'] ?? null),
            'est_claim_bunker' => $this->formatImportedNumber($row['est_claim_bunker'] ?? null),
            'flow_rate_pump' => $this->formatImportedNumber($row['flow_rate_pump'] ?? null),
            'nomor_pompa' => $row['nomor_pompa'] ?? null,
            'pressure_pompa' => $this->formatImportedNumber($row['pressure_pompa'] ?? null),
            'rpm' => $this->formatImportedNumber($row['rpm'] ?? null),
            'remarks' => $row['remarks'] ?? null,
            '_detail_item' => [
                'no_urut' => '01',
                'start_time' => $row['start_time'] ?? null,
                'stop_time' => $row['stop_time'] ?? null,
                'discharge_time' => $this->formatImportedNumber($dischargeTime),
            ],
        ];
    }

    private function buildImportTemplateHtml(): string
    {
        $sample = [
            '1',
            '020',
            'AL5-FL9',
            '2025-12-20',
            'Tg Uban',
            'B40',
            '3559.513',
            '3556.102',
            '-3.411',
            '-0.10%',
            '2025-12-27',
            'Belinyu',
            'B40',
            '3541.947',
            '6.624',
            '0.19%',
            '3528.970',
            '-12.980',
            '-0.37%',
            '-19.320',
            '-0.54%',
            '2025-12-27 08:00',
            '2025-12-27 20:00',
            '0.500000',
            '0.735202',
            '0.500000',
            '-0.235202',
            '',
            '',
            '',
            '',
            '',
            '',
            'Contoh import dari report harian.',
        ];

        $headerRows = <<<HTML
<tr><th colspan="34" style="font-size:16px;text-align:left;background:#f3f3f3;">Herewith Update Daily Report Vessel Shipment</th></tr>
<tr>
    <th rowspan="2">No</th>
    <th rowspan="2">Voy</th>
    <th rowspan="2">Vessel Name</th>
    <th rowspan="2">Date</th>
    <th rowspan="2">Loading</th>
    <th rowspan="2">Cargo</th>
    <th colspan="4">Quantity Loading</th>
    <th rowspan="2">Date</th>
    <th rowspan="2">Discharge</th>
    <th rowspan="2">Cargo</th>
    <th colspan="8">Quantity Discharge</th>
    <th colspan="13">Tambahan Untuk Import</th>
</tr>
<tr>
    <th>B/L</th>
    <th>SFAL</th>
    <th>DIFF R1</th>
    <th>R1</th>
    <th>SFBD</th>
    <th>DIFF R2</th>
    <th>R2</th>
    <th>AR</th>
    <th>DIFF R3</th>
    <th>R3</th>
    <th>DIFF R4</th>
    <th>R4</th>
    <th>Start Time</th>
    <th>Stop Time</th>
    <th>Discharge Time</th>
    <th>Est Discharge</th>
    <th>Act Discharge</th>
    <th>Overdue Discharge</th>
    <th>Est Claim Pumping</th>
    <th>Est Claim Bunker</th>
    <th>Flow Rate Pump</th>
    <th>Nomor Pompa</th>
    <th>Pressure Pompa</th>
    <th>RPM</th>
    <th>Remarks</th>
</tr>
HTML;

        $sampleCells = '';
        foreach ($sample as $value) {
            $sampleCells .= '<td>' . htmlspecialchars((string) $value, ENT_QUOTES, 'UTF-8') . '</td>';
        }

        return '<html><head><meta charset="utf-8"></head><body><table border="1">' . $headerRows . '<tr>' . $sampleCells . '</tr></table></body></html>';
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

        $priceBbl = $request->input('price_bbl');
        if ($priceBbl === null || $priceBbl === '') {
            $priceBbl = $grade?->price_bbl;
        }

        $transportLossThresholdRaw = Settings::query()
            ->where('nama', 'variable est_claim_transport')
            ->value('value');
        $transportLossThreshold = $this->toNumber($transportLossThresholdRaw);
        if ($transportLossThresholdRaw === null || $transportLossThresholdRaw === '') {
            $transportLossThreshold = -0.07;
        }

        $ratioR2Percent = $this->toNumber($request->input('ratio_r2'));
        $priceBblNum = $this->toNumber($priceBbl);
        $bolNum = $this->toNumber($request->input('bill_of_lading'));
        $estClaimTransport = 0;
        if ($ratioR2Percent < $transportLossThreshold) {
            $ratioR2 = $this->percentPointsToDecimal($ratioR2Percent);
            $threshold = $this->percentPointsToDecimal($transportLossThreshold);
            $estClaimTransport = (abs($ratioR2) - abs($threshold)) * $priceBblNum * $bolNum;
        }

        $payload = [
            'id_cable' => $idCable,
            'id_grade' => $idGrade,
            'no_voyage_gab' => $cable?->no_voyage_gab,
            'grade' => $grade?->grade,
            'price_bbl' => $priceBbl,
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
            'est_claim_transport' => number_format($estClaimTransport, 6, '.', ''),
            'flow_rate_pump' => $request->input('flow_rate_pump'),
            'nomor_pompa' => $request->input('nomor_pompa'),
            'pressure_pompa' => $request->input('pressure_pompa'),
            'rpm' => $request->input('rpm'),
            'remarks' => $request->input('remarks'),
            'status' => 'OPEN',
            'user_id' => $this->actingUserId(),
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
                'user_id' => $this->actingUserId(),
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

    private function refreshDetailDischargeTimes(int $docCargoId): array
    {
        $detailRows = DB::table('t_doc_cargo_detail')
            ->where('id_doc_cargo', $docCargoId)
            ->orderBy('id', 'asc')
            ->get();

        $totalDischarge = 0.0;
        foreach ($detailRows as $detailRow) {
            $dischargeTime = $this->calcDischargeTime($detailRow->start_time, $detailRow->stop_time);
            DB::table('t_doc_cargo_detail')
                ->where('id', $detailRow->id)
                ->update([
                    'discharge_time' => $dischargeTime,
                    'updated_at' => now(),
                ]);

            $totalDischarge += $this->toNumber($dischargeTime);
        }

        return [
            'rows' => $detailRows,
            'act_discharge' => number_format($totalDischarge, 6, '.', ''),
        ];
    }

    private function resolveKontrakForCable(?object $cable): ?object
    {
        if (!$cable) {
            return null;
        }

        if (!empty($cable->id_kontrak)) {
            $kontrak = DB::table('m_kontrak')->where('id', $cable->id_kontrak)->first();
            if ($kontrak) {
                return $kontrak;
            }
        }

        return DB::table('m_kontrak')
            ->where('id_vessel', $cable->id_vessel)
            ->where('status', 'ACTIVE')
            ->orderByDesc('id')
            ->first();
    }

    private function calculateRefreshedDocCargoFields(object $docCargo): array
    {
        $cable = DB::table('t_master_cable')->where('id', $docCargo->id_cable)->first();
        $kontrak = $this->resolveKontrakForCable($cable);

        $detailSummary = $this->refreshDetailDischargeTimes((int) $docCargo->id);
        $actDischarge = $this->toNumber($detailSummary['act_discharge'] ?? null);
        $actReceipt = $this->toNumber($docCargo->act_receipt);
        $pumpingRate = $this->toNumber($kontrak->pumping_rate ?? null);
        $charterRateDay = $this->toNumber($cable->charter_rate_day ?? null);
        $bunkerPrice = $this->toNumber($cable->bunker_price ?? null);
        $dischargeFactor = $this->toNumber($kontrak->discharge ?? null);

        $settingsEstClaimBunker = $this->toNumber(
            Settings::query()->where('nama', 'variable est_claim_bunker')->value('value')
        );
        if ($settingsEstClaimBunker === 0.0) {
            $settingsEstClaimBunker = 0.847;
        }

        $transportLossThreshold = $this->toNumber(
            Settings::query()->where('nama', 'variable est_claim_transport')->value('value')
        );
        if ($transportLossThreshold === 0.0) {
            $transportLossThreshold = -0.07;
        }

        $estDischarge = 0.0;
        if ($actReceipt > 0 && $pumpingRate > 0) {
            $estDischarge = $actReceipt / $pumpingRate / 24;
        }

        $flowRatePump = 0.0;
        if ($actReceipt > 0 && $actDischarge > 0) {
            $flowRatePump = $actReceipt / $actDischarge / 24;
        }

        $overdueDischarge = $actDischarge - $estDischarge;
        $estClaimPumping = $overdueDischarge * $charterRateDay;
        $estClaimBunker = $overdueDischarge * $bunkerPrice * 1000 * $settingsEstClaimBunker * $dischargeFactor;

        $ratioR2Percent = $this->toNumber($docCargo->ratio_r2);
        $priceBbl = $this->toNumber($docCargo->price_bbl);
        $billOfLading = $this->toNumber($docCargo->bill_of_lading);
        $estClaimTransport = 0.0;
        if ($ratioR2Percent < $transportLossThreshold) {
            $ratioR2 = $this->percentPointsToDecimal($ratioR2Percent);
            $threshold = $this->percentPointsToDecimal($transportLossThreshold);
            $estClaimTransport = (abs($ratioR2) - abs($threshold)) * $priceBbl * $billOfLading;
        }

        return [
            'act_discharge' => number_format($actDischarge, 6, '.', ''),
            'est_discharge' => number_format($estDischarge, 6, '.', ''),
            'overdue_discharge' => number_format($overdueDischarge, 6, '.', ''),
            'est_claim_pumping' => number_format($estClaimPumping, 6, '.', ''),
            'est_claim_bunker' => number_format($estClaimBunker, 6, '.', ''),
            'est_claim_transport' => number_format($estClaimTransport, 6, '.', ''),
            'flow_rate_pump' => $flowRatePump > 0 ? number_format($flowRatePump, 6, '.', '') : null,
        ];
    }

    public function importTemplate()
    {
        $filename = 'doc_cargo_import_template.xls';

        return response($this->buildDocCargoImportTemplateHtml(), 200, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
        ]);
    }

    public function exportImportSource()
    {
        $filename = 'doc_cargo_import_source.xls';

        return response($this->buildDocCargoExportHtml(), 200, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
        ]);
    }

    public function importPage()
    {
        return response()->view('doc-cargo-import', [
            'result' => session('result'),
            'errorsFromImport' => session('errors_from_import', []),
            'refreshResult' => session('refresh_result'),
            'klaimAwalResult' => session('klaim_awal_result'),
        ]);
    }

    private function klaimSubJenisByJenis(string $jenisKlaim): array
    {
        return match (strtoupper(trim($jenisKlaim))) {
            'SSOB' => ['SS', 'OB'],
            'SPOB' => ['SP', 'OB'],
            'TL' => ['TL'],
            default => [],
        };
    }

    private function resolveKlaimNilaiPotensi(string $jenisKlaim, string $subJenis, object $docCargo, ?object $cable): ?string
    {
        $sub = strtoupper($subJenis);
        $jenis = strtoupper($jenisKlaim);

        $value = match ($sub) {
            'SS' => $cable?->est_claim_speed,
            'SP' => $docCargo->est_claim_pumping ?? null,
            'TL' => $docCargo->est_claim_transport ?? $docCargo->est_transport_loss ?? null,
            'OB' => $jenis === 'SPOB'
                ? ($docCargo->est_claim_bunker ?? ($cable?->est_claim_bunker ?? null))
                : ($cable?->est_claim_bunker ?? null),
            default => null,
        };

        if ($value === null || $value === '') {
            return '0';
        }

        return number_format($this->toNumber($value), 6, '.', '');
    }

    private function resolveKlaimCurrency(string $subJenis): ?string
    {
        return in_array(strtoupper($subJenis), ['OB'], true) ? 'IDR' : 'USD';
    }

    private function generateAutoKlaimAwalNumber(string $jenisKlaim, ?string $kodeVessel, int $sequence): string
    {
        $datePart = now()->format('Ymd');
        $timePart = now()->format('His');
        $vesselPart = strtoupper(preg_replace('/[^A-Z0-9]/', '', (string) $kodeVessel) ?: 'VESSEL');
        return "AUTO/{$jenisKlaim}/{$vesselPart}/{$datePart}/{$timePart}/" . str_pad((string) $sequence, 2, '0', STR_PAD_LEFT);
    }

    private function eligibleDocCargoQueryForJenis(string $jenisKlaim, int $sourceUserId)
    {
        $hasIdDocCargoColumn = Schema::hasColumn('t_klaim_detail', 'id_doc_cargo');

        return DB::table('t_doc_cargo')
            ->join('t_master_cable', 't_master_cable.id', '=', 't_doc_cargo.id_cable')
            ->leftJoin('m_vessel', 'm_vessel.id', '=', 't_master_cable.id_vessel')
            ->leftJoin('m_kontrak', 'm_kontrak.id', '=', 't_master_cable.id_kontrak')
            ->where('t_doc_cargo.user_id', $sourceUserId)
            ->whereNotExists(function ($sub) use ($jenisKlaim, $hasIdDocCargoColumn) {
                $sub->select(DB::raw(1))
                    ->from('t_klaim_detail')
                    ->join('t_klaim', 't_klaim.id', '=', 't_klaim_detail.id_klaim')
                    ->where('t_klaim.jenis_klaim', $jenisKlaim)
                    ->where(function ($joinCond) use ($hasIdDocCargoColumn) {
                        if ($hasIdDocCargoColumn) {
                            $joinCond->whereColumn('t_klaim_detail.id_doc_cargo', 't_doc_cargo.id')
                                ->orWhere(function ($legacy) {
                                    $legacy->whereNull('t_klaim_detail.id_doc_cargo')
                                        ->whereColumn('t_klaim_detail.id_cable', 't_doc_cargo.id_cable');
                                });
                        } else {
                            $joinCond->whereColumn('t_klaim_detail.id_cable', 't_doc_cargo.id_cable');
                        }
                    });
            })
            ->select([
                't_doc_cargo.*',
                't_master_cable.id_vessel',
                't_master_cable.no_voyage_gab as cable_no_voyage_gab',
                't_master_cable.id_kontrak',
                't_master_cable.est_claim_speed',
                't_master_cable.est_claim_bunker as cable_est_claim_bunker',
                'm_kontrak.no_kontrak',
                'm_vessel.kode_vessel',
            ])
            ->orderBy('t_master_cable.id_vessel')
            ->orderBy('t_doc_cargo.id');
    }

    private function createKlaimAwalBatchFromDocCargo(string $requestedJenis, int $sourceUserId = 1): array
    {
        $jenisTargets = strtoupper($requestedJenis) === 'ALL'
            ? ['SSOB', 'SPOB', 'TL']
            : [strtoupper($requestedJenis)];

        $summary = [
            'user_id' => $sourceUserId,
            'jenis_klaim' => $requestedJenis,
            'headers_created' => 0,
            'details_created' => 0,
            'groups' => [],
        ];

        $sequence = 1;
        foreach ($jenisTargets as $jenisKlaim) {
            $rows = $this->eligibleDocCargoQueryForJenis($jenisKlaim, $sourceUserId)->get();
            if ($rows->isEmpty()) {
                continue;
            }

            $grouped = $rows->groupBy(fn ($row) => (int) $row->id_vessel);
            foreach ($grouped as $idVessel => $docCargoRows) {
                $first = $docCargoRows->first();
                $klaimId = DB::table('t_klaim')->insertGetId([
                    'id_vessel' => $idVessel,
                    'no_klaim_awal' => $this->generateAutoKlaimAwalNumber($jenisKlaim, $first->kode_vessel ?? null, $sequence),
                    'tgl_klaim_awal' => now()->format('Y-m-d H:i:s'),
                    'jenis_klaim' => $jenisKlaim,
                    'periode_klaim' => now()->format('Y-m'),
                    'status' => 'OPEN',
                    'user_id' => $this->actingUserId(),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                $sequence++;
                $summary['headers_created']++;

                $detailNoUrut = 1;
                foreach ($docCargoRows as $docCargo) {
                    $detailPayload = [
                        'id_klaim' => $klaimId,
                        'id_cable' => $docCargo->id_cable,
                        'id_off_hire' => null,
                        'id_redelivery_delivery' => null,
                        'no_urut' => str_pad((string) $detailNoUrut, 2, '0', STR_PAD_LEFT),
                        'no_voyage_gab' => $docCargo->no_voyage_gab ?: $docCargo->cable_no_voyage_gab,
                        'no_kontrak' => $docCargo->no_kontrak,
                        'keterangan' => 'Auto generated from Doc Cargo ID ' . $docCargo->id,
                        'status' => 'OPEN',
                        'user_id' => $this->actingUserId(),
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                    if (Schema::hasColumn('t_klaim_detail', 'id_doc_cargo')) {
                        $detailPayload['id_doc_cargo'] = $docCargo->id;
                    }

                    $klaimDetailId = DB::table('t_klaim_detail')->insertGetId($detailPayload);

                    $cable = (object) [
                        'est_claim_speed' => $docCargo->est_claim_speed ?? null,
                        'est_claim_bunker' => $docCargo->cable_est_claim_bunker ?? null,
                    ];

                    foreach ($this->klaimSubJenisByJenis($jenisKlaim) as $subJenis) {
                        $valPotensi = $this->resolveKlaimNilaiPotensi($jenisKlaim, $subJenis, $docCargo, $cable);
                        $currency = $this->resolveKlaimCurrency($subJenis);

                        DB::table('t_klaim_detail_nilai')->insert([
                            'id_klaim_detail' => $klaimDetailId,
                            'sub_jenis' => $subJenis,
                            'currency' => $currency,
                            'kurs' => $currency === 'IDR' ? '1' : null,
                            'val_potensi' => $valPotensi,
                            'val_klaim_awal' => $valPotensi,
                            'val_klaim_akhir' => null,
                            'val_klaim_akhir_idr' => null,
                            'status' => 'OPEN',
                            'user_id' => $this->actingUserId(),
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                    }

                    $detailNoUrut++;
                    $summary['details_created']++;
                }

                $summary['groups'][] = [
                    'klaim_id' => $klaimId,
                    'jenis_klaim' => $jenisKlaim,
                    'id_vessel' => (int) $idVessel,
                    'kode_vessel' => $first->kode_vessel ?? null,
                    'doc_cargo_count' => $docCargoRows->count(),
                ];
            }
        }

        return $summary;
    }

    private function executeRefresh(int $id): array
    {
        $docCargo = T_doc_cargo::query()->where('id', $id)->firstOrFail();
        if (strtoupper((string) $docCargo->status) === 'APPROVE') {
            throw ValidationException::withMessages([
                'status' => 'Doc Cargo yang sudah APPROVE tidak bisa di-refresh.',
            ]);
        }

        $payload = $this->calculateRefreshedDocCargoFields($docCargo);
        $payload['updated_at'] = now();
        $payload['user_id'] = $this->actingUserId();

        DB::table('t_doc_cargo')->where('id', $id)->update($payload);

        return $payload;
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

        $parsed = $this->parseDocCargoImportRows($rows);
        $groupedRows = $parsed['groups'];

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
            foreach ($groupedRows as $group) {
                $fields = $group['fields'] ?? [];
                $rowNumber = (int) ($group['first_row_number'] ?? 0);
                $noVoyageGab = trim((string) ($fields['no_voyage_gab'] ?? ''));
                $gradeName = trim((string) ($fields['grade'] ?? ''));

                if ($noVoyageGab === '' || $gradeName === '') {
                    $result['errors'][] = 'Baris ' . $rowNumber . ': No Voyage dan Grade wajib diisi.';
                    $result['skipped']++;
                    continue;
                }

                $cable = T_master_cable::query()
                    ->whereRaw('UPPER(TRIM(no_voyage_gab)) = ?', [strtoupper($noVoyageGab)])
                    ->first();
                if (!$cable) {
                    $result['errors'][] = 'Baris ' . $rowNumber . ': No Voyage "' . $noVoyageGab . '" tidak ditemukan di master cable.';
                    $result['skipped']++;
                    continue;
                }

                $gradeMeta = $this->resolveGradeForImport($gradeName, $fields['price_bbl'] ?? null);
                $importPayload = $this->buildDocCargoImportPayload($fields, $cable, $gradeMeta);
                $syntheticRequest = new Request($importPayload + [
                    'id_cable' => (int) $cable->id,
                    'id_grade' => (int) $gradeMeta['id'],
                ]);
                $payload = $this->sanitizeDocCargoPayload($syntheticRequest);
                $payload['status'] = 'APPROVE';

                $detailItems = [];
                foreach (($group['detail_items'] ?? []) as $index => $detailItem) {
                    $detailItems[] = [
                        'no_urut' => str_pad((string) ($index + 1), 2, '0', STR_PAD_LEFT),
                        'start_time' => $detailItem['start_time'] ?? null,
                        'stop_time' => $detailItem['stop_time'] ?? null,
                    ];
                }
                $detailRequest = new Request([
                    'detail_items' => $detailItems,
                ]);

                $existing = T_doc_cargo::query()
                    ->where('id_cable', (int) $cable->id)
                    ->where('id_grade', (int) $gradeMeta['id'])
                    ->first();

                if ($existing) {
                    DB::table('t_doc_cargo')->where('id', $existing->id)->update($payload);
                    $this->syncDetailRows((int) $existing->id, $payload['no_voyage_gab'] ?? $existing->no_voyage_gab, $detailRequest);
                    $refreshedPayload = $this->calculateRefreshedDocCargoFields(
                        T_doc_cargo::query()->where('id', $existing->id)->firstOrFail()
                    );
                    DB::table('t_doc_cargo')->where('id', $existing->id)->update(array_merge($refreshedPayload, [
                        'status' => 'APPROVE',
                        'updated_at' => now(),
                        'user_id' => $this->actingUserId(),
                    ]));
                    $result['updated']++;
                    $result['updated_rows'][] = [
                        'row_number' => implode(', ', $group['row_numbers'] ?? [$rowNumber]),
                        'doc_cargo_id' => (int) $existing->id,
                        'no_voyage_gab' => $payload['no_voyage_gab'] ?? $existing->no_voyage_gab,
                        'grade_id' => (int) $gradeMeta['id'],
                        'grade_name' => $gradeMeta['grade'],
                        'bill_of_lading' => $payload['bill_of_lading'] ?? null,
                        'cable_id' => (int) $cable->id,
                        'detail_count' => count($detailItems),
                        'previous_status' => $existing->status,
                    ];
                    continue;
                }

                $payload['created_at'] = now();
                $docCargoId = DB::table('t_doc_cargo')->insertGetId($payload);
                $this->syncDetailRows($docCargoId, $payload['no_voyage_gab'] ?? null, $detailRequest);
                $refreshedPayload = $this->calculateRefreshedDocCargoFields(
                    T_doc_cargo::query()->where('id', $docCargoId)->firstOrFail()
                );
                DB::table('t_doc_cargo')->where('id', $docCargoId)->update(array_merge($refreshedPayload, [
                    'status' => 'APPROVE',
                    'updated_at' => now(),
                    'user_id' => $this->actingUserId(),
                ]));
                $result['created']++;
                $result['created_rows'][] = [
                    'row_number' => implode(', ', $group['row_numbers'] ?? [$rowNumber]),
                    'doc_cargo_id' => (int) $docCargoId,
                    'no_voyage_gab' => $payload['no_voyage_gab'] ?? null,
                    'grade_id' => (int) $gradeMeta['id'],
                    'grade_name' => $gradeMeta['grade'],
                    'bill_of_lading' => $payload['bill_of_lading'] ?? null,
                    'cable_id' => (int) $cable->id,
                    'detail_count' => count($detailItems),
                ];
            }

            DB::commit();
        } catch (\Throwable $e) {
            DB::rollBack();
            throw $e;
        }

        return $result;
    }

    public function importExcelWeb(Request $request)
    {
        $result = $this->processImportFile($request);

        return redirect()
            ->route('doc-cargo.import.page')
            ->with('result', $result)
            ->with('errors_from_import', $result['errors'] ?? []);
    }

    public function importExcel(Request $request)
    {
        $result = $this->processImportFile($request);

        return response()->json([
            'success' => true,
            'message' => 'Import Doc Cargo selesai diproses.',
            'data' => $result,
        ]);
    }

    public function refreshWeb(Request $request)
    {
        DB::beginTransaction();
        try {
            $docCargoRows = T_doc_cargo::query()
                ->where('user_id', 1)
                ->whereRaw('UPPER(COALESCE(status, "")) != ?', ['APPROVE'])
                ->orderBy('id', 'asc')
                ->get(['id']);

            $refreshedIds = [];
            foreach ($docCargoRows as $docCargoRow) {
                $this->executeRefresh((int) $docCargoRow->id);
                $refreshedIds[] = (int) $docCargoRow->id;
            }

            DB::commit();

            return redirect()
                ->route('doc-cargo.import.page')
                ->with('refresh_result', [
                    'user_id' => 1,
                    'count' => count($refreshedIds),
                    'doc_cargo_ids' => $refreshedIds,
                ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function createKlaimAwalWeb(Request $request)
    {
        $validated = $request->validate([
            'jenis_klaim' => 'required|string|in:ALL,SSOB,SPOB,TL',
        ], [
            'jenis_klaim.required' => 'Jenis Klaim wajib dipilih.',
            'jenis_klaim.in' => 'Jenis Klaim tidak valid.',
        ]);

        DB::beginTransaction();
        try {
            $result = $this->createKlaimAwalBatchFromDocCargo((string) $validated['jenis_klaim'], 1);
            DB::commit();

            return redirect()
                ->route('doc-cargo.import.page')
                ->with('klaim_awal_result', $result);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
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

        $idVessel = $request->input('id_vessel');
        if (!is_null($idVessel) && $idVessel !== '') {
            // t_doc_cargo does not store vessel directly; filter through cable relation.
            $query->where('t_master_cable.id_vessel', $idVessel);
        }

        $status = $request->input('status');
        if (!is_null($status) && $status !== '') {
            $query->where('t_doc_cargo.status', $status);
        }

        $availableForKlaim = $request->boolean('available_for_klaim', false);
        if ($availableForKlaim) {
            $excludeKlaimId = $request->input('exclude_klaim_id');
            $jenisKlaim = trim((string) $request->input('jenis_klaim', ''));
            $hasIdDocCargoColumn = Schema::hasColumn('t_klaim_detail', 'id_doc_cargo');

            $query->whereNotExists(function ($sub) use ($excludeKlaimId, $jenisKlaim, $hasIdDocCargoColumn) {
                $sub->select(DB::raw(1))
                    ->from('t_klaim_detail')
                    ->join('t_klaim', 't_klaim.id', '=', 't_klaim_detail.id_klaim')
                    ->where(function ($joinCond) use ($hasIdDocCargoColumn) {
                        if ($hasIdDocCargoColumn) {
                            $joinCond->whereColumn('t_klaim_detail.id_doc_cargo', 't_doc_cargo.id')
                                ->orWhere(function ($legacy) {
                                    $legacy->whereNull('t_klaim_detail.id_doc_cargo')
                                        ->whereColumn('t_klaim_detail.id_cable', 't_doc_cargo.id_cable');
                                });
                        } else {
                            // Legacy schema in kapal.sql: t_klaim_detail does not have id_doc_cargo.
                            $joinCond->whereColumn('t_klaim_detail.id_cable', 't_doc_cargo.id_cable');
                        }
                    });

                if (!is_null($excludeKlaimId) && $excludeKlaimId !== '') {
                    $sub->where('t_klaim_detail.id_klaim', '!=', $excludeKlaimId);
                }
                if ($jenisKlaim !== '') {
                    $sub->where('t_klaim.jenis_klaim', $jenisKlaim);
                }
            });
        }

        $allowedSort = [
            'id' => 't_doc_cargo.id',
            'no_voyage_gab' => 't_doc_cargo.no_voyage_gab',
            'no_voyage_gab_display' => 't_doc_cargo.no_voyage_gab',
            'bill_of_lading' => 't_doc_cargo.bill_of_lading',
            'status' => 't_doc_cargo.status',
            'created_at' => 't_doc_cargo.created_at',
        ];
        $sortBy = $request->input('sort_by', 'id');
        if (!array_key_exists($sortBy, $allowedSort)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'asc')) === 'desc' ? 'desc' : 'asc';

        if (in_array($sortBy, ['no_voyage_gab', 'no_voyage_gab_display'], true)) {
            $voyageExpr = "COALESCE(t_doc_cargo.no_voyage_gab, t_master_cable.no_voyage_gab)";
            $gradeExpr = "UPPER(TRIM(COALESCE(t_doc_cargo.grade, m_grade.grade, '')))";
            $query
                ->orderByRaw("SUBSTRING_INDEX({$voyageExpr}, '/', 1) asc")
                ->orderByRaw("CAST(SUBSTRING_INDEX(SUBSTRING_INDEX({$voyageExpr}, '/', 2), '/', -1) AS UNSIGNED) {$sortDir}")
                ->orderByRaw("{$gradeExpr} asc")
                ->orderByRaw("CASE
                    WHEN UPPER(SUBSTRING_INDEX({$voyageExpr}, '/', -1)) = 'L' THEN 0
                    WHEN UPPER(SUBSTRING_INDEX({$voyageExpr}, '/', -1)) LIKE 'D%' THEN 1
                    ELSE 2
                END asc")
                ->orderByRaw("CASE
                    WHEN UPPER(SUBSTRING_INDEX({$voyageExpr}, '/', -1)) LIKE 'D%'
                      THEN CAST(SUBSTRING(UPPER(SUBSTRING_INDEX({$voyageExpr}, '/', -1)), 2) AS UNSIGNED)
                    ELSE 0
                END asc")
                ->orderBy('t_doc_cargo.id', 'desc');
        } else {
            $query->orderBy($allowedSort[$sortBy], $sortDir);
        }

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

    public function refresh(Request $request)
    {
        $id = (int) $request->route('id');

        try {
            DB::beginTransaction();
            $payload = $this->executeRefresh($id);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data Doc Cargo berhasil di-refresh dari detail.',
                'data' => $payload,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
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
                'files.*.mimes' => 'File cable hanya boleh PDF.',
            ]);

            $payload = $this->sanitizeDocCargoPayload($request);
            $idCable = (int) ($payload['id_cable'] ?? 0);
            $idGrade = (int) ($payload['id_grade'] ?? 0);
            if ($idCable > 0 && $idGrade > 0) {
                $this->ensureGradeNotUsedOnCable($idCable, $idGrade);
            }
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
            if (strtoupper((string) $existing->status) === 'APPROVE') {
                throw ValidationException::withMessages([
                    'status' => 'Doc Cargo yang sudah APPROVE tidak bisa diubah.',
                ]);
            }
            $payload = $this->sanitizeDocCargoPayload($request);
            $idCable = (int) ($payload['id_cable'] ?? 0);
            $idGrade = (int) ($payload['id_grade'] ?? 0);
            if ($idCable > 0 && $idGrade > 0) {
                $this->ensureGradeNotUsedOnCable($idCable, $idGrade, (int) $existing->id);
            }

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

            $docCargo = T_doc_cargo::where('id', $id)->firstOrFail();
            $docCargo->status = 'APPROVE';
            $docCargo->user_id = Auth::id();
            $docCargo->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Doc Cargo berhasil di-approve',
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

            $docCargo = T_doc_cargo::where('id', $id)->firstOrFail();
            $docCargo->status = 'OPEN';
            $docCargo->user_id = Auth::id();
            $docCargo->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Doc Cargo berhasil di-unapprove',
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
            if (strtoupper((string) $t_doc_cargo->status) === 'APPROVE') {
                throw ValidationException::withMessages([
                    'status' => 'Doc Cargo yang sudah APPROVE tidak bisa dihapus.',
                ]);
            }

            $files = File_upload::where('id_doc_cargo', $id)->get();
            foreach ($files as $file) {
                if ($file->nama_file) {
                    $path = public_path('storage/' . ltrim((string) $file->nama_file, '/'));
                    if (file_exists($path)) {
                        @unlink($path);
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
