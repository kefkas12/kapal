<?php

namespace App\Support;

use DOMDocument;
use DOMXPath;
use RuntimeException;
use ZipArchive;

class SimpleSpreadsheetReader
{
    public static function readRows(string $path, ?string $extension = null, bool $percentagePoints = false): array
    {
        $ext = strtolower((string) ($extension ?: pathinfo($path, PATHINFO_EXTENSION)));
        $signature = self::detectSignature($path);

        if ($signature === 'xlsx') {
            return self::readXlsx($path, $percentagePoints);
        }

        if ($signature === 'xls-binary') {
            throw new RuntimeException('File XLS format lama Excel belum didukung. Simpan ulang sebagai XLSX atau CSV lalu upload lagi.');
        }

        return match ($ext) {
            'csv' => self::readCsv($path),
            'xlsx' => self::readXlsx($path, $percentagePoints),
            'xls', 'html', 'htm', 'xml' => self::readHtmlTable($path),
            default => throw new RuntimeException('Format file tidak didukung untuk import.'),
        };
    }

    private static function detectSignature(string $path): ?string
    {
        $handle = fopen($path, 'rb');
        if ($handle === false) {
            return null;
        }

        $bytes = fread($handle, 8);
        fclose($handle);

        if ($bytes === false || $bytes === '') {
            return null;
        }

        if (str_starts_with($bytes, "PK\x03\x04")) {
            return 'xlsx';
        }

        if ($bytes === "\xD0\xCF\x11\xE0\xA1\xB1\x1A\xE1") {
            return 'xls-binary';
        }

        return null;
    }

    private static function readCsv(string $path): array
    {
        $rows = [];
        $handle = fopen($path, 'rb');
        if ($handle === false) {
            throw new RuntimeException('Gagal membaca file CSV.');
        }

        while (($row = fgetcsv($handle)) !== false) {
            $rows[] = array_map(fn ($value) => self::cleanCellValue($value), $row);
        }

        fclose($handle);

        return $rows;
    }

    private static function readHtmlTable(string $path): array
    {
        $html = file_get_contents($path);
        if ($html === false) {
            throw new RuntimeException('Gagal membaca file template/import.');
        }

        $dom = new DOMDocument;
        @$dom->loadHTML($html);
        $xpath = new DOMXPath($dom);

        $rows = [];
        foreach ($xpath->query('//table//tr') as $tr) {
            $row = [];
            foreach ($xpath->query('./th|./td', $tr) as $cell) {
                $colspan = max(1, (int) $cell->getAttribute('colspan'));
                $value = self::cleanCellValue($cell->textContent ?? '');
                for ($i = 0; $i < $colspan; $i++) {
                    $row[] = $value;
                }
            }
            if ($row !== []) {
                $rows[] = $row;
            }
        }

        return $rows;
    }

    private static function readXlsx(string $path, bool $percentagePoints): array
    {
        $zip = new ZipArchive;
        if ($zip->open($path) !== true) {
            throw new RuntimeException('Gagal membuka file XLSX.');
        }

        try {
            $sheetXml = $zip->getFromName(self::firstVisibleWorksheetPath($zip));
            if ($sheetXml === false) {
                throw new RuntimeException('Worksheet pada XLSX tidak ditemukan.');
            }

            $sharedStrings = self::readSharedStrings($zip);
            $percentageStyles = $percentagePoints ? self::readPercentageStyles($zip) : [];
        } finally {
            $zip->close();
        }

        $xml = simplexml_load_string($sheetXml);
        if ($xml === false) {
            throw new RuntimeException('Gagal membaca isi worksheet XLSX.');
        }

        $rows = [];
        $namespaces = $xml->getDocNamespaces();
        $mainNs = $namespaces[''] ?? null;
        if ($mainNs) {
            $xml->registerXPathNamespace('x', $mainNs);
            $rowNodes = $xml->xpath('//x:sheetData/x:row') ?: [];
        } else {
            $rowNodes = $xml->sheetData?->row ?? [];
        }

        foreach ($rowNodes as $rowNode) {
            $row = [];
            foreach ($rowNode->c as $cell) {
                $ref = (string) ($cell['r'] ?? '');
                $colIndex = self::columnReferenceToIndex($ref);
                while (count($row) < $colIndex) {
                    $row[] = '';
                }

                $type = (string) ($cell['t'] ?? '');
                $value = '';
                if ($type === 'inlineStr') {
                    $value = (string) ($cell->is->t ?? '');
                } elseif ($type === 's') {
                    $sharedIndex = (int) ($cell->v ?? 0);
                    $value = $sharedStrings[$sharedIndex] ?? '';
                } else {
                    $value = (string) ($cell->v ?? '');
                }

                if (in_array($type, ['', 'n'], true) && isset($percentageStyles[(int) ($cell['s'] ?? 0)]) && is_numeric($value)) {
                    $value = (string) ((float) $value * 100);
                }

                $row[$colIndex] = self::cleanCellValue($value);
            }

            if ($row !== []) {
                ksort($row);
                $rows[] = array_values($row);
            }
        }

        return $rows;
    }

    /**
     * @return array<int, true>
     */
    private static function readPercentageStyles(ZipArchive $zip): array
    {
        $stylesXml = $zip->getFromName('xl/styles.xml');
        if ($stylesXml === false) {
            return [];
        }

        $styles = simplexml_load_string($stylesXml);
        if ($styles === false) {
            throw new RuntimeException('Gagal membaca format angka XLSX.');
        }

        $percentageFormats = [9 => true, 10 => true];
        foreach ($styles->numFmts->numFmt ?? [] as $format) {
            $formatCode = (string) $format['formatCode'];
            $formatCode = preg_replace('/"[^"]*"|\\\\.|\[[^\]]*\]|[\*_]./u', '', $formatCode) ?? '';
            if (str_contains($formatCode, '%')) {
                $percentageFormats[(int) $format['numFmtId']] = true;
            }
        }

        $percentageStyles = [];
        $index = 0;
        foreach ($styles->cellXfs->xf ?? [] as $style) {
            if (isset($percentageFormats[(int) $style['numFmtId']])) {
                $percentageStyles[$index] = true;
            }
            $index++;
        }

        return $percentageStyles;
    }

    private static function firstVisibleWorksheetPath(ZipArchive $zip): string
    {
        $workbookXml = $zip->getFromName('xl/workbook.xml');
        $relationshipsXml = $zip->getFromName('xl/_rels/workbook.xml.rels');
        if ($workbookXml === false || $relationshipsXml === false) {
            return 'xl/worksheets/sheet1.xml';
        }

        $workbook = simplexml_load_string($workbookXml);
        $relationships = simplexml_load_string($relationshipsXml);
        if ($workbook === false || $relationships === false) {
            throw new RuntimeException('Gagal membaca daftar worksheet XLSX.');
        }

        $targets = [];
        foreach ($relationships->children('http://schemas.openxmlformats.org/package/2006/relationships') as $relationship) {
            $attributes = $relationship->attributes();
            if (str_ends_with((string) $attributes['Type'], '/worksheet')) {
                $targets[(string) $attributes['Id']] = (string) $attributes['Target'];
            }
        }

        $sheets = $workbook->children('http://schemas.openxmlformats.org/spreadsheetml/2006/main')->sheets;
        foreach ($sheets->sheet as $sheet) {
            if (in_array((string) $sheet->attributes()['state'], ['hidden', 'veryHidden'], true)) {
                continue;
            }

            $relationshipId = (string) $sheet->attributes('http://schemas.openxmlformats.org/officeDocument/2006/relationships')['id'];
            $target = $targets[$relationshipId] ?? null;
            if ($target !== null) {
                return str_starts_with($target, '/') ? ltrim($target, '/') : 'xl/'.$target;
            }
        }

        throw new RuntimeException('Tidak ada worksheet terlihat yang dapat dibaca pada XLSX.');
    }

    private static function readSharedStrings(ZipArchive $zip): array
    {
        $xmlString = $zip->getFromName('xl/sharedStrings.xml');
        if ($xmlString === false) {
            return [];
        }

        $xml = simplexml_load_string($xmlString);
        if ($xml === false) {
            return [];
        }

        $strings = [];
        foreach ($xml->si as $item) {
            if (isset($item->t)) {
                $strings[] = self::cleanCellValue((string) $item->t);

                continue;
            }

            $parts = [];
            foreach ($item->r as $run) {
                $parts[] = (string) ($run->t ?? '');
            }
            $strings[] = self::cleanCellValue(implode('', $parts));
        }

        return $strings;
    }

    private static function columnReferenceToIndex(string $reference): int
    {
        if (! preg_match('/^([A-Z]+)/i', $reference, $matches)) {
            return 0;
        }

        $letters = strtoupper($matches[1]);
        $index = 0;
        for ($i = 0; $i < strlen($letters); $i++) {
            $index = ($index * 26) + (ord($letters[$i]) - 64);
        }

        return max(0, $index - 1);
    }

    private static function cleanCellValue($value): string
    {
        $string = trim((string) $value);
        $string = str_replace("\xc2\xa0", ' ', $string);

        return preg_replace('/\s+/u', ' ', $string) ?? $string;
    }
}
