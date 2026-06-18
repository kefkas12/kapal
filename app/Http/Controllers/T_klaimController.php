<?php

namespace App\Http\Controllers;

use App\Models\T_klaim;
use App\Models\T_klaim_detail;
use App\Models\T_klaim_detail_nilai;
use App\Models\File_upload;
use App\Support\FileUploadHelper;
use App\Support\SimpleSpreadsheetReader;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class T_klaimController extends Controller
{
    private function actingUserId(): ?int
    {
        return Auth::id() ?? DB::table('users')->orderBy('id')->value('id');
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
            if (!array_key_exists($requiredField, $columnIndexes)) {
                $requiredLabel = $this->klaimImportFieldLabels()[$requiredField] ?? $requiredField;
                throw ValidationException::withMessages([
                    'file' => 'Header wajib tidak ditemukan: ' . $requiredLabel . '.',
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
        }

        $allowed = ['SSOB', 'SPOB', 'TL', 'BOD'];
        return in_array($jenis, $allowed, true) ? $jenis : null;
    }

    private function buildKlaimImportTemplateHtml(): string
    {
        $headers = $this->klaimImportFieldLabels();
        $sampleRows = [
            ['KLAIM/OSL/001', '2026-06-01', 'SSOB', 'AB2F8', '2026-06', '', ''],
            ['KLAIM/OSL/002', '2026-06-05', 'TL', 'AB5FL9', '2026-06', 'FIN/KLAIM/002', '2026-06-12'],
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
            $html .= '<th>' . e($labels[$header]) . '</th>';
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
                if (!$jenisKlaim) {
                    $result['errors'][] = 'Baris ' . $row['row_number'] . ': Jenis Klaim harus salah satu dari SSOB, SPOB, TL, atau BOD.';
                    $result['skipped']++;
                    continue;
                }

                $idVessel = $this->resolveVesselIdFromImport($row['vessel'] ?? null);
                if (!$idVessel) {
                    $result['errors'][] = 'Baris ' . $row['row_number'] . ': Vessel "' . ($row['vessel'] ?? '') . '" tidak ditemukan.';
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
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
        ]);
    }

    public function exportImportSource()
    {
        $filename = 'klaim_import_source.xls';

        return response($this->buildKlaimExportHtml(), 200, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
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

        while (!empty($stack)) {
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
        if (!is_null($idVessel) && $idVessel !== '') {
            $query->where('t_klaim.id_vessel', $idVessel);
        }

        $jenisKlaim = $request->input('jenis_klaim');
        if (!is_null($jenisKlaim) && $jenisKlaim !== '') {
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
        if (!array_key_exists($sortBy, $allowedSort)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $query->orderBy($allowedSort[$sortBy], $sortDir);

        $paginator = $query->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Data T_klaim berhasil diambil',
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

        $data = T_klaim::where('id', $id)->first();
        $filesAwal = File_upload::where('id_klaim_awal', $id)->orderBy('id', 'asc')->get();
        $filesAkhir = File_upload::where('id_klaim_akhir', $id)->orderBy('id', 'asc')->get();

        $files = $filesAwal->concat($filesAkhir)->unique('id')->values();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details T_klaim berhasil diambil',
            'data'    => $data,
            'files' => $files,
            'files_awal' => $filesAwal->values(),
            'files_akhir' => $filesAkhir->values(),
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_klaim = new T_klaim();
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
                    'id' => $t_klaim->id
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
            $hasApprovedDetail = T_klaim_detail::where('id_klaim', $id)
                ->where('status', 'APPROVE')
                ->exists();
            if ($hasApprovedDetail) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Klaim yang sudah APPROVE tidak bisa diubah.'
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
                'message' => 'Data T_klaim berhasil diubah'
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
                    'message' => 'Klaim yang sudah APPROVE tidak bisa dihapus.'
                ], 422);
            }

            $t_klaim = T_klaim::where('id', $id)->firstOrFail();

            $detailIds = T_klaim_detail::where('id_klaim', $id)->pluck('id')->all();
            if (!empty($detailIds)) {
                $lookupIds = array_values(array_unique(array_merge($detailIds, [(int) $id])));
                $files = File_upload::whereIn('id_klaim_awal', $lookupIds)
                    ->orWhereIn('id_klaim_akhir', $lookupIds)
                    ->get();

                foreach ($files as $file) {
                    if ($file->nama_file) {
                        $path = public_path('storage/' . ltrim((string) $file->nama_file, '/'));
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
                'message' => 'Data T_klaim berhasil dihapus'
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
            if (!$user || !($user->hasRole('approval') || $user->hasRole('superadmin'))) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Hanya role approval atau superadmin yang boleh melakukan approve.'
                ], 403);
            }

            $klaim = T_klaim::where('id', $id)->firstOrFail();

            $details = T_klaim_detail::where('id_klaim', $id)->get();
            foreach ($details as $detail) {
                $detail->status = 'APPROVE';
                $detail->user_id = Auth::id();
                $detail->save();

                DB::table('t_klaim_detail_nilai')
                    ->where('id_klaim_detail', $detail->id)
                    ->update([
                        'status' => 'APPROVE',
                        'user_id' => Auth::id(),
                        'updated_at' => now(),
                    ]);
            }

            $klaim->status = 'APPROVE';
            $klaim->user_id = Auth::id();
            $klaim->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Approve Klaim berhasil diproses.'
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
            if (!$user || !($user->hasRole('approval') || $user->hasRole('superadmin'))) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Hanya role approval atau superadmin yang boleh melakukan unapprove.'
                ], 403);
            }

            $klaim = T_klaim::where('id', $id)->firstOrFail();

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
                'message' => 'Unapprove Klaim berhasil diproses.'
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
            if (!$file) continue;
            $ext = strtolower((string) $file->getClientOriginalExtension());
            if (!in_array($ext, ['pdf', 'jpg', 'png', 'jpeg'], true)) {
                throw ValidationException::withMessages([
                    'files' => 'File upload hanya boleh PDF/JPG/JPEG/PNG.'
                ]);
            }
        }
    }

    private function storeKlaimFiles(Request $request, int $klaimId): void
    {
        $incomingFiles = $this->extractIncomingUploadFiles($request);
        if (empty($incomingFiles)) return;

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
            if (!$file) continue;
            $path = FileUploadHelper::storeWithOriginalName($file, 'uploads/klaim');
            $upload = new File_upload();
            $upload->id_klaim_awal = null;
            $upload->id_klaim_akhir = null;
            $upload->{$column} = $klaimId;
            $upload->nama_file = $path;
            $upload->save();
        }
    }
}
