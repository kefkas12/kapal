<?php

namespace Tests\Unit;

use App\Http\Controllers\T_doc_cargoController;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;
use ReflectionMethod;

class DocCargoImportVoyageCodeTest extends TestCase
{
    #[DataProvider('voyageCodes')]
    public function test_uses_effective_voyage_code_for_import_and_export(?string $status, ?string $adjusted, string $expected): void
    {
        $method = new ReflectionMethod(T_doc_cargoController::class, 'docCargoImportVoyageCode');
        $cable = (object) [
            'no_voyage_gab' => ' AB5FL9/24002/L ',
            'no_voyage_gab_penyesuaian' => $adjusted,
            'status_voyage' => $status,
        ];

        $this->assertSame($expected, $method->invoke(new T_doc_cargoController, $cable));
    }

    /**
     * @return array<string, array{?string, ?string, string}>
     */
    public static function voyageCodes(): array
    {
        return [
            'normal' => [null, null, 'AB5FL9/24002/L'],
            'none' => ['none', '', 'AB5FL9/24002/L'],
            'deviation' => ['deviasi', null, 'AB5FL9/24002/L-D'],
            'bunker' => ['bunker', '', 'AB5FL9/24002/L-B'],
            'status whitespace and case' => [' DEVIASI ', ' ', 'AB5FL9/24002/L-D'],
            'explicit adjustment' => ['deviasi', ' CUSTOM/24002/L-D ', 'CUSTOM/24002/L-D'],
            'normal with explicit adjustment' => [null, 'CUSTOM/24002/L', 'CUSTOM/24002/L'],
        ];
    }

    public function test_parser_keeps_same_grade_separate_by_normal_and_special_voyage_codes(): void
    {
        $parser = new ReflectionMethod(T_doc_cargoController::class, 'parseDocCargoImportRows');
        $parsed = $parser->invoke(new T_doc_cargoController, [
            ['No Voyage', 'Grade', 'Bill of Lading'],
            ['AB5FL9/24002/L', 'PERTALITE', '100'],
            ['AB5FL9/24002/L-D', 'PERTALITE', '200'],
            ['AB5FL9/24002/L-B', 'PERTALITE', '300'],
        ]);

        $this->assertCount(3, $parsed['groups']);
        $this->assertSame(['100', '200', '300'], array_column(array_column($parsed['groups'], 'fields'), 'bill_of_lading'));
    }
}
