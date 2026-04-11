<?php

namespace App\Support;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

class FileUploadHelper
{
    public static function storeWithOriginalName(UploadedFile $file, string $directory, string $disk = 'public'): string
    {
        $diskInstance = Storage::disk($disk);

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

        while ($diskInstance->exists(trim($directory, '/') . '/' . $candidate)) {
            $candidate = $baseName . '_' . $counter . $dotExt;
            $counter++;
        }

        return $file->storeAs($directory, $candidate, $disk);
    }
}
