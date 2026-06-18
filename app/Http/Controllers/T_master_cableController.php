<?php

namespace App\Http\Controllers;

use App\Models\T_master_cable;
use App\Models\File_upload;
use App\Models\Settings;
use App\Support\FileUploadHelper;
use App\Support\SimpleSpreadsheetReader;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class T_master_cableController extends Controller
{
    private function actingUserId(): ?int
    {
        return Auth::id() ?? DB::table('users')->orderBy('id')->value('id');
    }

    private function validateCableUploadExtensions(array $files): void
    {
        foreach ($files as $file) {
            if (!$file) continue;
            $ext = strtolower((string) $file->getClientOriginalExtension());
            if (!in_array($ext, ['pdf', 'xls', 'xlsx'], true)) {
                throw ValidationException::withMessages([
                    'files' => 'File cable hanya boleh PDF/XLS/XLSX.',
                ]);
            }
        }
    }

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

    private function normalizeImportHeader(?string $value): string
    {
        $upper = strtoupper(trim((string) $value));
        return preg_replace('/[^A-Z0-9]/', '', $upper) ?? '';
    }

    private function toNumber($value): ?float
    {
        if ($value === null || $value === '') {
            return null;
        }

        $str = trim((string) $value);
        if ($str === '') {
            return null;
        }

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

    private function formatImportedNumber($value): ?string
    {
        $number = $this->toNumber($value);
        if ($number === null) {
            return null;
        }

        return number_format($number, 6, '.', '');
    }

    private function excelDateToDateTime($value): ?string
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

        $ts = strtotime($text);
        if ($ts === false) {
            return null;
        }

        return date('Y-m-d H:i:s', $ts);
    }

    private function cableImportColumns(): array
    {
        return [
            'no_kontrak' => ['NOKONTRAK', 'CONTRACTNO', 'NOCONTRACT'],
            'no_voyage_gab' => ['NOVOYAGEGAB', 'VOYAGEGAB', 'NOVOYAGE'],
            'master' => ['MASTER'],
            'atd_port' => ['ATDPORT', 'LOADPORT'],
            'atd_time' => ['ATDTIME', 'LOADTIME', 'LOADINGTIME'],
            'atd_rob' => ['ATDROB', 'ATDROBMT'],
            'ata_port' => ['ATAPORT', 'DISCHARGEPORT'],
            'ata_time' => ['ATATIME', 'DISCHARGETIME'],
            'ata_rob' => ['ATAROB', 'ATAROBMT'],
            'distance' => ['DISTANCE', 'DISTANCENM'],
            'bunker_price' => ['BUNKERPRICE', 'BUNKERPRICEIDRLITER'],
        ];
    }

    private function cableImportFieldLabels(): array
    {
        return [
            'no_kontrak' => 'No Kontrak',
            'no_voyage_gab' => 'No Voyage Gab',
            'master' => 'Master',
            'atd_port' => 'ATD Port',
            'atd_time' => 'ATD Time',
            'atd_rob' => 'ATD ROB (MT)',
            'ata_port' => 'ATA Port',
            'ata_time' => 'ATA Time',
            'ata_rob' => 'ATA ROB (MT)',
            'distance' => 'Distance (NM)',
            'bunker_price' => 'Bunker Price (IDR/liter)',
        ];
    }

    private function daysInMonthFromDateTime(?string $value): ?int
    {
        if (!$value) {
            return null;
        }

        $ts = strtotime($value);
        if ($ts === false) {
            return null;
        }

        return (int) date('t', $ts);
    }

    private function diffDays(?string $start, ?string $end): ?float
    {
        if (!$start || !$end) {
            return null;
        }

        $startTs = strtotime($start);
        $endTs = strtotime($end);
        if ($startTs === false || $endTs === false) {
            return null;
        }

        return ($endTs - $startTs) / 86400;
    }

    private function formatComputedNumber(?float $value): ?string
    {
        if ($value === null) {
            return null;
        }

        return number_format($value, 6, '.', '');
    }

    private function getEstClaimBunkerFactor(): float
    {
        $value = $this->toNumber(
            Settings::where('nama', 'variable est_claim_bunker')
                ->where('status', 'ACTIVE')
                ->orderByDesc('id')
                ->value('value')
        );

        return $value ?? 0.847;
    }

    private function applyCableDerivedFields(array $payload, object $kontrak): array
    {
        $distance = $this->toNumber($payload['distance'] ?? null);
        $atdRob = $this->toNumber($payload['atd_rob'] ?? null);
        $ataRob = $this->toNumber($payload['ata_rob'] ?? null);
        $bunkerPrice = $this->toNumber($payload['bunker_price'] ?? null);

        $speed = null;
        if ($distance !== null) {
            $speed = $this->toNumber($kontrak->speed ?? null);
        }

        $estSailDay = ($distance !== null && $speed !== null && $speed != 0.0)
            ? $distance / $speed / 24
            : null;

        $actSailDay = $this->diffDays($payload['atd_time'] ?? null, $payload['ata_time'] ?? null);

        $actSpeed = ($distance !== null && $actSailDay !== null && $actSailDay != 0.0)
            ? $distance / ($actSailDay * 24)
            : null;

        $charterRate = $this->toNumber($kontrak->charter_rate ?? null);
        $charterRateDay = null;
        if ($charterRate !== null) {
            $period = strtoupper(trim((string) ($kontrak->period ?? '')));
            if ($period === 'DAY') {
                $charterRateDay = $charterRate;
            } else {
                $days = $this->daysInMonthFromDateTime($payload['ata_time'] ?? null) ?: (int) date('t');
                if ($days > 0) {
                    $charterRateDay = $charterRate / $days;
                }
            }
        }

        $estClaimSpeed = ($actSailDay !== null && $estSailDay !== null && $charterRateDay !== null)
            ? ($actSailDay - $estSailDay) * $charterRateDay
            : null;

        $meRate = null;
        $jenis = strtoupper(trim((string) ($payload['jenis_voyage'] ?? '')));
        if (str_starts_with($jenis, 'D')) {
            $meRate = $this->toNumber($kontrak->me_laden ?? null);
        } else {
            $meRate = $this->toNumber($kontrak->me_ballast ?? null);
        }

        $stdBunkerCons = ($meRate !== null && $estSailDay !== null)
            ? $meRate * $estSailDay
            : null;

        $actBunkerCons = ($atdRob !== null && $ataRob !== null)
            ? $atdRob - $ataRob
            : null;

        $excessBunker = ($actBunkerCons !== null && $stdBunkerCons !== null)
            ? $actBunkerCons - $stdBunkerCons
            : null;

        $estClaimBunker = ($excessBunker !== null && $bunkerPrice !== null)
            ? $excessBunker * $bunkerPrice * 1000 * $this->getEstClaimBunkerFactor()
            : null;

        $payload['speed'] = $this->formatComputedNumber($speed);
        $payload['est_sail_day'] = $this->formatComputedNumber($estSailDay);
        $payload['act_sail_day'] = $this->formatComputedNumber($actSailDay);
        $payload['act_speed'] = $this->formatComputedNumber($actSpeed);
        $payload['charter_rate_day'] = $this->formatComputedNumber($charterRateDay);
        $payload['est_claim_speed'] = $this->formatComputedNumber($estClaimSpeed);
        $payload['std_bunker_cons'] = $this->formatComputedNumber($stdBunkerCons);
        $payload['act_bunker_cons'] = $this->formatComputedNumber($actBunkerCons);
        $payload['excess_bunker'] = $this->formatComputedNumber($excessBunker);
        $payload['est_claim_bunker'] = $this->formatComputedNumber($estClaimBunker);

        return $payload;
    }

    private function parseCableImportRows(array $rows): array
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
        foreach ($this->cableImportColumns() as $field => $aliases) {
            foreach ($normalizedHeaders as $index => $header) {
                if (in_array($header, $aliases, true)) {
                    $columnIndexes[$field] = $index;
                    break;
                }
            }
        }

        foreach (['no_kontrak', 'no_voyage_gab'] as $required) {
            if (!array_key_exists($required, $columnIndexes)) {
                throw ValidationException::withMessages([
                    'file' => 'Header wajib tidak ditemukan: ' . $required . '.',
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
                $item[$field] = $value === '' ? null : $value;
            }

            if (!$hasValue) {
                continue;
            }

            $parsed[] = $item;
        }

        if ($parsed === []) {
            throw ValidationException::withMessages([
                'file' => 'Tidak ada baris data yang bisa diproses pada file import.',
            ]);
        }

        return [$parsed, array_keys($columnIndexes)];
    }

    private function parseNoVoyageGabImport(string $value): ?array
    {
        $trimmed = trim($value);
        if ($trimmed === '') {
            return null;
        }

        if (!preg_match('/^([^\/]+)\/(\d{5})\/([A-Za-z0-9]+)$/', $trimmed, $matches)) {
            return null;
        }

        return [
            'kode_vessel' => strtoupper(trim($matches[1])),
            'no_voyage' => $matches[2],
            'jenis_voyage' => strtoupper(trim($matches[3])),
            'no_voyage_gab' => strtoupper($trimmed),
        ];
    }

    private function normalizeLookupKey(?string $value): string
    {
        return preg_replace('/[^A-Z0-9]/', '', strtoupper(trim((string) $value))) ?? '';
    }

    private function buildCableImportPayload(array $row, object $kontrak, array $voyageMeta, array $presentColumns): array
    {
        $payload = [
            'id_vessel' => (int) $kontrak->id_vessel,
            'id_kontrak' => (int) $kontrak->id,
            'no_voyage_gab' => $voyageMeta['no_voyage_gab'],
            'no_voyage' => $voyageMeta['no_voyage'],
            'jenis_voyage' => $voyageMeta['jenis_voyage'],
            'status' => 'APPROVE',
            'user_id' => $this->actingUserId(),
            'updated_at' => now(),
        ];

        $dateFields = ['atd_time', 'ata_time'];
        $numberFields = ['atd_rob', 'ata_rob', 'distance', 'bunker_price'];

        foreach ($presentColumns as $column) {
            if (in_array($column, ['no_kontrak', 'no_voyage_gab'], true)) {
                continue;
            }

            $raw = $row[$column] ?? null;
            if (in_array($column, $dateFields, true)) {
                $payload[$column] = $this->excelDateToDateTime($raw);
                continue;
            }

            if (in_array($column, $numberFields, true)) {
                $payload[$column] = $this->formatImportedNumber($raw);
                continue;
            }

            $payload[$column] = $raw;
        }

        return $this->applyCableDerivedFields($payload, $kontrak);
    }

    private function buildCableImportTemplateHtml(): string
    {
        $headers = $this->cableImportFieldLabels();
        $sample = [
            'KONTRAK-001',
            'AL2F8/26001/L',
            'STEVEN',
            'PALEMBANG',
            '2026-05-10 04:18:00',
            '123',
            'JAKARTA',
            '2026-05-14 04:18:00',
            '12',
            '100',
            '1000',
        ];

        $html = '<table border="1"><tr>';
        foreach ($headers as $header) {
            $html .= '<th>' . e($header) . '</th>';
        }
        $html .= '</tr><tr>';
        foreach ($sample as $value) {
            $html .= '<td>' . e((string) $value) . '</td>';
        }
        $html .= '</tr></table>';

        return $html;
    }

    private function buildCableExportHtml(): string
    {
        $rows = DB::table('t_master_cable')
            ->leftJoin('m_kontrak', 'm_kontrak.id', '=', 't_master_cable.id_kontrak')
            ->select(
                'm_kontrak.no_kontrak',
                't_master_cable.no_voyage_gab',
                't_master_cable.master',
                't_master_cable.atd_port',
                't_master_cable.atd_time',
                't_master_cable.atd_rob',
                't_master_cable.ata_port',
                't_master_cable.ata_time',
                't_master_cable.ata_rob',
                't_master_cable.distance',
                't_master_cable.bunker_price',
            )
            ->orderBy('t_master_cable.id')
            ->get();

        $headers = array_keys($this->cableImportFieldLabels());
        $headerLabels = $this->cableImportFieldLabels();

        $html = '<table border="1"><tr>';
        foreach ($headers as $header) {
            $html .= '<th>' . e($headerLabels[$header]) . '</th>';
        }
        $html .= '</tr>';

        foreach ($rows as $row) {
            $html .= '<tr>';
            foreach ($headers as $header) {
                $html .= '<td>' . e((string) ($row->{$header} ?? '')) . '</td>';
            }
            $html .= '</tr>';
        }

        $html .= '</table>';

        return $html;
    }

    private function buildCableKontrakCheckResult(): array
    {
        $kontrakRowsById = DB::table('m_kontrak')
            ->select('id', 'id_vessel', 'no_kontrak', 'status')
            ->get()
            ->keyBy('id');

        $cableRows = DB::table('t_master_cable')
            ->leftJoin('m_vessel', 'm_vessel.id', '=', 't_master_cable.id_vessel')
            ->leftJoin('m_kontrak', 'm_kontrak.id', '=', 't_master_cable.id_kontrak')
            ->select(
                't_master_cable.id',
                't_master_cable.id_vessel',
                't_master_cable.id_kontrak',
                't_master_cable.no_voyage_gab',
                'm_vessel.kode_vessel',
                'm_kontrak.no_kontrak as current_no_kontrak',
                'm_kontrak.status as current_kontrak_status'
            )
            ->orderBy('t_master_cable.id')
            ->get();

        $issues = [];
        foreach ($cableRows as $cable) {
            $currentKontrak = !empty($cable->id_kontrak)
                ? $kontrakRowsById->get((int) $cable->id_kontrak)
                : null;
            $voyageMeta = $this->parseNoVoyageGabImport((string) $cable->no_voyage_gab);
            $reasons = [];

            if (empty($cable->id_kontrak)) {
                $reasons[] = 'id_kontrak pada cable kosong.';
            }

            if ($currentKontrak && (int) $currentKontrak->id_vessel !== (int) $cable->id_vessel) {
                $reasons[] = 'id_kontrak di cable mengarah ke vessel yang berbeda.';
            }

            if (!empty($cable->id_kontrak) && !$currentKontrak) {
                $reasons[] = 'id_kontrak di cable tidak ditemukan di m_kontrak.';
            }

            $expectedKodeVessel = strtoupper(trim((string) $cable->kode_vessel));
            if ($voyageMeta && $expectedKodeVessel !== '' && $voyageMeta['kode_vessel'] !== $expectedKodeVessel) {
                $reasons[] = 'Prefix vessel pada no_voyage_gab tidak cocok dengan kode vessel.';
            }

            if ($reasons === []) {
                continue;
            }

            $issues[] = [
                'cable_id' => (int) $cable->id,
                'no_voyage_gab' => $cable->no_voyage_gab,
                'current_no_kontrak' => $cable->current_no_kontrak,
                'expected_no_kontrak' => null,
                'reasons' => $reasons,
            ];
        }

        return [
            'checked_count' => $cableRows->count(),
            'issue_count' => count($issues),
            'issues' => $issues,
        ];
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

        [$parsedRows, $presentColumns] = $this->parseCableImportRows($rows);

        $kontrakRows = DB::table('m_kontrak')
            ->join('m_vessel', 'm_vessel.id', '=', 'm_kontrak.id_vessel')
            ->select(
                'm_kontrak.id',
                'm_kontrak.id_vessel',
                'm_kontrak.no_kontrak',
                'm_kontrak.status',
                'm_kontrak.speed',
                'm_kontrak.charter_rate',
                'm_kontrak.period',
                'm_kontrak.me_ballast',
                'm_kontrak.me_laden',
                'm_vessel.kode_vessel'
            )
            ->get();

        $kontrakByNo = [];
        foreach ($kontrakRows as $kontrak) {
            $kontrakByNo[$this->normalizeLookupKey($kontrak->no_kontrak)] = $kontrak;
        }

        $existingCables = DB::table('t_master_cable')
            ->leftJoin('m_kontrak', 'm_kontrak.id', '=', 't_master_cable.id_kontrak')
            ->select(
                't_master_cable.id',
                't_master_cable.id_kontrak',
                't_master_cable.no_voyage_gab',
                't_master_cable.status',
                'm_kontrak.no_kontrak'
            )
            ->get()
            ->groupBy(fn ($row) => $this->normalizeLookupKey($row->no_voyage_gab));

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
                $rowNumber = (int) $row['row_number'];
                $noKontrak = trim((string) ($row['no_kontrak'] ?? ''));
                $noVoyageGab = strtoupper(trim((string) ($row['no_voyage_gab'] ?? '')));

                if ($noKontrak === '' || $noVoyageGab === '') {
                    $result['errors'][] = 'Baris ' . $rowNumber . ': no_kontrak dan no_voyage_gab wajib diisi.';
                    $result['skipped']++;
                    continue;
                }

                $kontrak = $kontrakByNo[$this->normalizeLookupKey($noKontrak)] ?? null;
                if (!$kontrak) {
                    $result['errors'][] = 'Baris ' . $rowNumber . ': no_kontrak "' . $noKontrak . '" tidak ditemukan di m_kontrak.';
                    $result['skipped']++;
                    continue;
                }

                $voyageMeta = $this->parseNoVoyageGabImport($noVoyageGab);
                if (!$voyageMeta) {
                    $result['errors'][] = 'Baris ' . $rowNumber . ': format no_voyage_gab "' . $noVoyageGab . '" tidak valid.';
                    $result['skipped']++;
                    continue;
                }

                $expectedKodeVessel = strtoupper(trim((string) $kontrak->kode_vessel));
                if ($expectedKodeVessel !== $voyageMeta['kode_vessel']) {
                    $result['errors'][] = 'Baris ' . $rowNumber . ': no_voyage_gab "' . $noVoyageGab . '" tidak cocok dengan vessel kontrak "' . $noKontrak . '" (kode vessel ' . $expectedKodeVessel . ').';
                    $result['skipped']++;
                    continue;
                }

                $existingGroup = $existingCables[$this->normalizeLookupKey($noVoyageGab)] ?? collect();

                $payload = $this->buildCableImportPayload($row, $kontrak, $voyageMeta, $presentColumns);
                $existing = $existingGroup->first();

                if ($existing) {
                    foreach ($existingGroup as $matchedCable) {
                        DB::table('t_master_cable')->where('id', $matchedCable->id)->update($payload);
                        $result['updated']++;
                        $result['updated_rows'][] = [
                            'row_number' => $rowNumber,
                            'cable_id' => (int) $matchedCable->id,
                            'no_kontrak' => $noKontrak,
                            'no_voyage_gab' => $noVoyageGab,
                            'kontrak_changed' => !empty($matchedCable->id_kontrak) && (int) $matchedCable->id_kontrak !== (int) $kontrak->id,
                            'previous_no_kontrak' => $matchedCable->no_kontrak ?? null,
                            'previous_status' => $matchedCable->status ?? null,
                            'duplicate_group_count' => $existingGroup->count(),
                        ];
                    }
                    continue;
                }

                $payload['created_at'] = now();
                $cableId = DB::table('t_master_cable')->insertGetId($payload);
                $result['created']++;
                $result['created_rows'][] = [
                    'row_number' => $rowNumber,
                    'cable_id' => (int) $cableId,
                    'no_kontrak' => $noKontrak,
                    'no_voyage_gab' => $noVoyageGab,
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
        $filename = 'cable_import_template.xls';

        return response($this->buildCableImportTemplateHtml(), 200, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
        ]);
    }

    public function exportImportSource()
    {
        $filename = 'cable_import_source.xls';

        return response($this->buildCableExportHtml(), 200, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
        ]);
    }

    public function importPage()
    {
        return response()->view('cable-import', [
            'checkResult' => $this->buildCableKontrakCheckResult(),
            'result' => session('result'),
            'errorsFromImport' => session('errors_from_import', []),
        ]);
    }

    public function importExcelWeb(Request $request)
    {
        $result = $this->processImportFile($request);

        return redirect()
            ->route('cable.import.page')
            ->with('result', $result)
            ->with('errors_from_import', $result['errors'] ?? []);
    }

    public function importExcel(Request $request)
    {
        $result = $this->processImportFile($request);

        return response()->json([
            'success' => true,
            'message' => 'Import Cable selesai diproses.',
            'data' => $result,
        ]);
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
                'files.*' => 'file|max:51200',
            ], [
                'files.required' => 'File upload wajib diisi.',
                'files.min' => 'Minimal 1 file harus diupload.',
            ]);
            $this->validateCableUploadExtensions((array) $request->file('files', []));

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

            $activeKontrakQuery = DB::table('m_kontrak')
                ->where('id_vessel', $request->input('id_vessel'))
                ->where('status', 'ACTIVE');
            $activeKontrakCount = (clone $activeKontrakQuery)->count();

            if ($activeKontrakCount !== 1) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Vessel harus memiliki tepat 1 kontrak ACTIVE.'
                ], 422);
            }
            $activeKontrak = (clone $activeKontrakQuery)->orderByDesc('id')->first(['id']);

            $t_master_cable = new T_master_cable();
            $t_master_cable->id_vessel = $request->input('id_vessel');
            $t_master_cable->id_kontrak = $activeKontrak->id ?? null;
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
                'files.*' => 'file|max:51200',
            ]);
            $this->validateCableUploadExtensions((array) $request->file('files', []));

            $incomingFiles = array_filter((array) $request->file('files', []));
            $hasExistingFiles = File_upload::where('id_cable', $id)->exists();
            if (empty($incomingFiles) && !$hasExistingFiles) {
                throw ValidationException::withMessages([
                    'files' => 'File upload wajib diisi.',
                ]);
            }

            $activeKontrakQuery = DB::table('m_kontrak')
                ->where('id_vessel', $request->input('id_vessel'))
                ->where('status', 'ACTIVE');
            $activeKontrakCount = (clone $activeKontrakQuery)->count();

            if ($activeKontrakCount !== 1) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Vessel harus memiliki tepat 1 kontrak ACTIVE.'
                ], 422);
            }
            $activeKontrak = (clone $activeKontrakQuery)->orderByDesc('id')->first(['id']);

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
            $t_master_cable->id_kontrak = $activeKontrak->id ?? null;
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
