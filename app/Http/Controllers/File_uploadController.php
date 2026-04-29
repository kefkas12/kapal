<?php

namespace App\Http\Controllers;

use App\Models\File_upload;
use Illuminate\Http\Request;

class File_uploadController extends Controller
{
    private function resolvePublicStoragePath(string $relativePath): string
    {
        return public_path('storage/' . ltrim($relativePath, '/'));
    }

    public function pdfBySection()
    {
        $sectionColumns = [
            'id_kontrak' => 'Kontrak',
            'id_cable' => 'Cable',
            'id_klaim_awal' => 'Klaim Awal',
            'id_klaim_akhir' => 'Klaim Akhir',
            'id_klaim_detail_awal' => 'Klaim Detail Awal',
            'id_klaim_detail_akhir' => 'Klaim Detail Akhir',
            'id_doc_cargo' => 'Doc Cargo',
            'id_off_hire' => 'Off Hire',
            'id_on_hire' => 'On Hire',
            'id_redelivery' => 'Redelivery',
            'id_delivery' => 'Delivery',
        ];

        $rows = File_upload::query()
            ->whereNotNull('nama_file')
            ->whereRaw('LOWER(nama_file) LIKE ?', ['%.pdf'])
            ->orderByDesc('created_at')
            ->get();

        $grouped = [];
        foreach ($rows as $row) {
            $sectionLabel = 'Lainnya';
            $sectionKey = 'others';

            foreach ($sectionColumns as $column => $label) {
                if (!is_null($row->{$column})) {
                    $sectionLabel = $label;
                    $sectionKey = $column;
                    break;
                }
            }

            if (!isset($grouped[$sectionKey])) {
                $grouped[$sectionKey] = [
                    'section_key' => $sectionKey,
                    'section_label' => $sectionLabel,
                    'files' => [],
                ];
            }

            $grouped[$sectionKey]['files'][] = [
                'id' => (int) $row->id,
                'name' => basename((string) $row->nama_file),
                'path' => $row->nama_file,
                'created_at' => optional($row->created_at)?->toDateTimeString(),
                'view_url' => url('/api/file_upload/view/' . $row->id),
                'download_url' => url('/api/file_upload/download/' . $row->id),
            ];
        }

        return response()->json([
            'success' => true,
            'data' => array_values($grouped),
        ]);
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
