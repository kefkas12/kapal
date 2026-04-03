<?php

namespace App\Http\Controllers;

use App\Models\File_upload;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class File_uploadController extends Controller
{
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

        $disk = Storage::disk('public');
        if (!$disk->exists($file->nama_file)) {
            return response()->json([
                'success' => false,
                'message' => 'File tidak ditemukan'
            ], 404);
        }

        $path = $disk->path($file->nama_file);
        $mime = $disk->mimeType($file->nama_file) ?? 'application/octet-stream';
        $isImage = str_starts_with($mime, 'image/');

        if ($isImage) {
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

        $disk = Storage::disk('public');
        if (!$disk->exists($file->nama_file)) {
            return response()->json([
                'success' => false,
                'message' => 'File tidak ditemukan'
            ], 404);
        }

        $path = $disk->path($file->nama_file);
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
            $disk = Storage::disk('public');
            if ($disk->exists($file->nama_file)) {
                $disk->delete($file->nama_file);
            }
        }

        $file->delete();

        return response()->json([
            'success' => true,
            'message' => 'File berhasil dihapus'
        ]);
    }
}
