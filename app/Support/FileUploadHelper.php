<?php

namespace App\Support;

use Illuminate\Http\UploadedFile;

class FileUploadHelper
{
    public static function storeWithOriginalName(UploadedFile $file, string $directory, string $disk = 'public'): string
    {
        $originalName = trim((string) $file->getClientOriginalName());
        $extension = $file->getClientOriginalExtension();

        $baseName = pathinfo($originalName, PATHINFO_FILENAME);
        $baseName = trim((string) $baseName);
        $baseName = preg_replace('/[\\\\\\/]+/', '_', $baseName) ?? '';
        $baseName = preg_replace('/\s+/', ' ', $baseName) ?? '';
        if ($baseName === '') {
            $baseName = 'file';
        }

        $dotExt = $extension !== '' ? '.' . $extension : '';
        $candidate = $baseName . $dotExt;
        $counter = 1;
        $normalizedDir = trim($directory, '/');
        $targetDir = public_path('storage/' . $normalizedDir);
        if (!is_dir($targetDir)) {
            @mkdir($targetDir, 0775, true);
        }

        while (file_exists($targetDir . DIRECTORY_SEPARATOR . $candidate)) {
            $candidate = $baseName . '_' . $counter . $dotExt;
            $counter++;
        }

        $file->move($targetDir, $candidate);
        return $normalizedDir . '/' . $candidate;
    }
}
