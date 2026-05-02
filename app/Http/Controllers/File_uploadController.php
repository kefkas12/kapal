<?php

namespace App\Http\Controllers;

use App\Models\File_upload;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use ZipArchive;

class File_uploadController extends Controller
{
    private function sectionMeta(): array
    {
        return [
            'kontrak' => ['label' => 'Kontrak'],
            'cable' => ['label' => 'Cable'],
            'doc_cargo' => ['label' => 'Doc Cargo'],
            'off_hire_on_hire' => ['label' => 'Off Hire dan On Hire'],
            'redelivery_delivery' => ['label' => 'Redelivery dan Delivery'],
            'klaim_awal' => ['label' => 'Klaim Awal'],
            'klaim_akhir' => ['label' => 'Klaim Akhir'],
        ];
    }

    private function resolveSectionKey(object $row): string
    {
        if (!is_null($row->id_kontrak)) return 'kontrak';
        if (!is_null($row->id_cable)) return 'cable';
        if (!is_null($row->id_doc_cargo)) return 'doc_cargo';
        if (!is_null($row->id_off_hire) || !is_null($row->id_on_hire)) return 'off_hire_on_hire';
        if (!is_null($row->id_redelivery) || !is_null($row->id_delivery)) return 'redelivery_delivery';
        if (!is_null($row->id_klaim_awal) || !is_null($row->id_klaim_detail_awal)) return 'klaim_awal';
        if (!is_null($row->id_klaim_akhir) || !is_null($row->id_klaim_detail_akhir)) return 'klaim_akhir';
        return 'others';
    }

    private function buildVesselResolverMaps($rows): array
    {
        $kontrakIds = [];
        $cableIds = [];
        $docCargoIds = [];
        $offHireIds = [];
        $redeliveryIds = [];
        $klaimIdsAwal = [];
        $klaimIdsAkhir = [];
        $klaimDetailIdsAwal = [];
        $klaimDetailIdsAkhir = [];

        foreach ($rows as $row) {
            if (!is_null($row->id_kontrak)) $kontrakIds[] = (int) $row->id_kontrak;
            if (!is_null($row->id_cable)) $cableIds[] = (int) $row->id_cable;
            if (!is_null($row->id_doc_cargo)) $docCargoIds[] = (int) $row->id_doc_cargo;
            if (!is_null($row->id_off_hire)) $offHireIds[] = (int) $row->id_off_hire;
            if (!is_null($row->id_on_hire)) $offHireIds[] = (int) $row->id_on_hire;
            if (!is_null($row->id_redelivery)) $redeliveryIds[] = (int) $row->id_redelivery;
            if (!is_null($row->id_delivery)) $redeliveryIds[] = (int) $row->id_delivery;
            if (!is_null($row->id_klaim_awal)) $klaimIdsAwal[] = (int) $row->id_klaim_awal;
            if (!is_null($row->id_klaim_akhir)) $klaimIdsAkhir[] = (int) $row->id_klaim_akhir;
            if (!is_null($row->id_klaim_detail_awal)) $klaimDetailIdsAwal[] = (int) $row->id_klaim_detail_awal;
            if (!is_null($row->id_klaim_detail_akhir)) $klaimDetailIdsAkhir[] = (int) $row->id_klaim_detail_akhir;
        }

        $kontrakMap = DB::table('m_kontrak')
            ->whereIn('id', array_values(array_unique($kontrakIds)))
            ->pluck('id_vessel', 'id');

        $cableMap = DB::table('t_master_cable')
            ->whereIn('id', array_values(array_unique($cableIds)))
            ->pluck('id_vessel', 'id');

        $docCargoMap = DB::table('t_doc_cargo')
            ->leftJoin('t_master_cable', 't_master_cable.id', '=', 't_doc_cargo.id_cable')
            ->whereIn('t_doc_cargo.id', array_values(array_unique($docCargoIds)))
            ->pluck('t_master_cable.id_vessel', 't_doc_cargo.id');

        $offHireMap = DB::table('t_off_hire')
            ->whereIn('id', array_values(array_unique($offHireIds)))
            ->pluck('id_vessel', 'id');

        $redeliveryMap = DB::table('t_redelivery_delivery')
            ->whereIn('id', array_values(array_unique($redeliveryIds)))
            ->pluck('id_vessel', 'id');

        $klaimMap = DB::table('t_klaim')
            ->whereIn('id', array_values(array_unique(array_merge($klaimIdsAwal, $klaimIdsAkhir))))
            ->pluck('id_vessel', 'id');

        $klaimDetailMap = DB::table('t_klaim_detail')
            ->whereIn('id', array_values(array_unique(array_merge($klaimDetailIdsAwal, $klaimDetailIdsAkhir))))
            ->pluck('id_klaim', 'id');

        return [
            'kontrak' => $kontrakMap,
            'cable' => $cableMap,
            'doc_cargo' => $docCargoMap,
            'off_hire_on_hire' => $offHireMap,
            'redelivery_delivery' => $redeliveryMap,
            'klaim' => $klaimMap,
            'klaim_detail_to_klaim' => $klaimDetailMap,
        ];
    }

    private function resolveVesselId(object $row, string $sectionKey, array $maps): ?int
    {
        if ($sectionKey === 'kontrak' && !is_null($row->id_kontrak)) {
            $v = $maps['kontrak'][$row->id_kontrak] ?? null;
            return is_null($v) ? null : (int) $v;
        }
        if ($sectionKey === 'cable' && !is_null($row->id_cable)) {
            $v = $maps['cable'][$row->id_cable] ?? null;
            return is_null($v) ? null : (int) $v;
        }
        if ($sectionKey === 'doc_cargo' && !is_null($row->id_doc_cargo)) {
            $v = $maps['doc_cargo'][$row->id_doc_cargo] ?? null;
            return is_null($v) ? null : (int) $v;
        }
        if ($sectionKey === 'off_hire_on_hire') {
            $id = !is_null($row->id_off_hire) ? $row->id_off_hire : $row->id_on_hire;
            if (is_null($id)) return null;
            $v = $maps['off_hire_on_hire'][$id] ?? null;
            return is_null($v) ? null : (int) $v;
        }
        if ($sectionKey === 'redelivery_delivery') {
            $id = !is_null($row->id_redelivery) ? $row->id_redelivery : $row->id_delivery;
            if (is_null($id)) return null;
            $v = $maps['redelivery_delivery'][$id] ?? null;
            return is_null($v) ? null : (int) $v;
        }
        if ($sectionKey === 'klaim_awal' || $sectionKey === 'klaim_akhir') {
            $klaimId = $sectionKey === 'klaim_awal' ? $row->id_klaim_awal : $row->id_klaim_akhir;
            if (!is_null($klaimId)) {
                $v = $maps['klaim'][$klaimId] ?? null;
                return is_null($v) ? null : (int) $v;
            }
            $detailId = $sectionKey === 'klaim_awal' ? $row->id_klaim_detail_awal : $row->id_klaim_detail_akhir;
            if (is_null($detailId)) return null;
            $resolvedKlaimId = $maps['klaim_detail_to_klaim'][$detailId] ?? null;
            if (is_null($resolvedKlaimId)) return null;
            $v = $maps['klaim'][$resolvedKlaimId] ?? null;
            return is_null($v) ? null : (int) $v;
        }
        return null;
    }

    private function buildPdfHierarchy(): array
    {
        $sectionMeta = $this->sectionMeta();
        $currentYear = (int) now()->year;

        $vesselRows = DB::table('m_vessel')
            ->select('id', 'kode_vessel', 'nama_vessel')
            ->orderBy('kode_vessel')
            ->get();

        $rows = File_upload::query()
            ->whereNotNull('nama_file')
            ->whereRaw('LOWER(nama_file) LIKE ?', ['%.pdf'])
            ->orderByDesc('created_at')
            ->get([
                'id',
                'id_kontrak',
                'id_cable',
                'id_klaim_awal',
                'id_klaim_akhir',
                'id_klaim_detail_awal',
                'id_klaim_detail_akhir',
                'id_doc_cargo',
                'id_off_hire',
                'id_on_hire',
                'id_redelivery',
                'id_delivery',
                'nama_file',
                'created_at',
            ]);

        $maps = $this->buildVesselResolverMaps($rows);
        $bucket = [];

        foreach ($rows as $row) {
            $sectionKey = $this->resolveSectionKey($row);
            if (!isset($sectionMeta[$sectionKey])) continue;
            $vesselId = $this->resolveVesselId($row, $sectionKey, $maps);
            if (!$vesselId) continue;

            $createdAt = $row->created_at ? Carbon::parse($row->created_at) : now();
            $year = (int) $createdAt->format('Y');
            $month = (int) $createdAt->format('n');

            $bucket[$vesselId][$sectionKey][$year][$month][] = [
                'id' => (int) $row->id,
                'name' => basename((string) $row->nama_file),
                'path' => (string) $row->nama_file,
                'created_at' => optional($row->created_at)?->toDateTimeString(),
                'view_url' => url('/api/file_upload/view/' . $row->id),
                'download_url' => url('/api/file_upload/download/' . $row->id),
            ];
        }

        $vessels = [];
        foreach ($vesselRows as $vessel) {
            $sectionItems = [];
            foreach ($sectionMeta as $sectionKey => $meta) {
                $yearBuckets = $bucket[$vessel->id][$sectionKey] ?? [];
                $yearList = array_keys($yearBuckets);
                if (!in_array($currentYear, $yearList, true)) $yearList[] = $currentYear;
                rsort($yearList);

                $years = [];
                $sectionTotal = 0;
                foreach ($yearList as $year) {
                    $monthBuckets = $yearBuckets[$year] ?? [];
                    $months = [];
                    $yearTotal = 0;
                    for ($m = 1; $m <= 12; $m++) {
                        $files = $monthBuckets[$m] ?? [];
                        $count = count($files);
                        $yearTotal += $count;
                        $months[] = [
                            'month' => $m,
                            'month_label' => Carbon::create()->month($m)->format('F'),
                            'file_count' => $count,
                            'files' => $files,
                        ];
                    }
                    $sectionTotal += $yearTotal;
                    $years[] = [
                        'year' => (int) $year,
                        'file_count' => $yearTotal,
                        'months' => $months,
                    ];
                }

                $sectionItems[] = [
                    'section_key' => $sectionKey,
                    'section_label' => $meta['label'],
                    'file_count' => $sectionTotal,
                    'years' => $years,
                ];
            }

            $vessels[] = [
                'id' => (int) $vessel->id,
                'kode_vessel' => (string) ($vessel->kode_vessel ?? '-'),
                'nama_vessel' => (string) ($vessel->nama_vessel ?? '-'),
                'sections' => $sectionItems,
            ];
        }

        return $vessels;
    }

    private function resolvePublicStoragePath(string $relativePath): string
    {
        return public_path('storage/' . ltrim($relativePath, '/'));
    }

    public function pdfBySection()
    {
        return response()->json([
            'success' => true,
            'data' => $this->buildPdfHierarchy(),
        ]);
    }

    public function bulkDownload(Request $request)
    {
        $vesselId = (int) $request->input('vessel_id', 0);
        $sectionKey = (string) $request->input('section_key', '');
        $year = (int) $request->input('year', 0);
        $month = $request->input('month');
        $month = is_null($month) || $month === '' ? null : (int) $month;

        if ($vesselId <= 0 || $sectionKey === '' || $year <= 0) {
            return response()->json([
                'success' => false,
                'message' => 'Parameter vessel_id, section_key, dan year wajib diisi.'
            ], 422);
        }

        $vessels = $this->buildPdfHierarchy();
        $targetVessel = collect($vessels)->firstWhere('id', $vesselId);
        if (!$targetVessel) {
            return response()->json([
                'success' => false,
                'message' => 'Vessel tidak ditemukan.'
            ], 404);
        }

        $targetSection = collect($targetVessel['sections'] ?? [])->firstWhere('section_key', $sectionKey);
        if (!$targetSection) {
            return response()->json([
                'success' => false,
                'message' => 'Section tidak ditemukan.'
            ], 404);
        }

        $targetYear = collect($targetSection['years'] ?? [])->firstWhere('year', $year);
        if (!$targetYear) {
            return response()->json([
                'success' => false,
                'message' => 'Tahun tidak ditemukan.'
            ], 404);
        }

        $files = [];
        if (is_null($month)) {
            foreach (($targetYear['months'] ?? []) as $m) {
                foreach (($m['files'] ?? []) as $f) $files[] = $f;
            }
        } else {
            $targetMonth = collect($targetYear['months'] ?? [])->firstWhere('month', $month);
            if ($targetMonth) {
                $files = $targetMonth['files'] ?? [];
            }
        }

        if (!count($files)) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak ada file PDF untuk filter yang dipilih.'
            ], 404);
        }

        $zipFileName = 'pdf_upload_' . preg_replace('/[^a-z0-9]+/i', '_', strtolower($targetVessel['kode_vessel'] ?? 'vessel'))
            . '_' . $sectionKey . '_' . $year . (is_null($month) ? '' : ('_' . str_pad((string) $month, 2, '0', STR_PAD_LEFT)))
            . '.zip';
        $zipPath = storage_path('app/tmp_' . uniqid('pdf_zip_', true) . '.zip');

        $zip = new ZipArchive();
        if ($zip->open($zipPath, ZipArchive::CREATE | ZipArchive::OVERWRITE) !== true) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal membuat file ZIP.'
            ], 500);
        }

        foreach ($files as $file) {
            $path = $this->resolvePublicStoragePath((string) ($file['path'] ?? ''));
            if (!file_exists($path)) continue;
            $zip->addFile($path, (string) ($file['name'] ?? basename($path)));
        }
        $zip->close();

        return response()->download($zipPath, $zipFileName, [
            'Content-Type' => 'application/zip'
        ])->deleteFileAfterSend(true);
    }

    public function view(Request $request)
    {
        $id = $request->route('id');
        $file = File_upload::where('id', $id)->first();
        if (!$file || !$file->nama_file) {
            return response()->json([
                'success' => false,
                'message' => 'File tidak ditemukan'
            ], 404);
        }

        $path = $this->resolvePublicStoragePath((string) $file->nama_file);
        if (!file_exists($path)) {
            return response()->json([
                'success' => false,
                'message' => 'File tidak ditemukan'
            ], 404);
        }

        $ext = strtolower(pathinfo((string) $file->nama_file, PATHINFO_EXTENSION));
        $mimeMap = [
            'pdf' => 'application/pdf',
            'jpg' => 'image/jpeg',
            'jpeg' => 'image/jpeg',
            'png' => 'image/png',
            'gif' => 'image/gif',
            'webp' => 'image/webp',
            'bmp' => 'image/bmp',
            'svg' => 'image/svg+xml',
        ];
        $mime = $mimeMap[$ext] ?? 'application/octet-stream';
        $isImage = str_starts_with($mime, 'image/');
        $isPdf = $mime === 'application/pdf';

        if ($isImage || $isPdf) {
            return response()->file($path, [
                'Content-Type' => $mime,
                'Content-Disposition' => 'inline'
            ]);
        }

        return response()->download($path);
    }

    public function download(Request $request)
    {
        $id = $request->route('id');
        $file = File_upload::where('id', $id)->first();
        if (!$file || !$file->nama_file) {
            return response()->json([
                'success' => false,
                'message' => 'File tidak ditemukan'
            ], 404);
        }

        $path = $this->resolvePublicStoragePath((string) $file->nama_file);
        if (!file_exists($path)) {
            return response()->json([
                'success' => false,
                'message' => 'File tidak ditemukan'
            ], 404);
        }

        return response()->download($path);
    }

    public function delete(Request $request)
    {
        $id = $request->route('id');
        $file = File_upload::where('id', $id)->first();
        if (!$file) {
            return response()->json([
                'success' => false,
                'message' => 'File tidak ditemukan'
            ], 404);
        }

        if ($file->nama_file) {
            $path = $this->resolvePublicStoragePath((string) $file->nama_file);
            if (file_exists($path)) {
                @unlink($path);
            }
        }

        $file->delete();

        return response()->json([
            'success' => true,
            'message' => 'File berhasil dihapus'
        ]);
    }
}
