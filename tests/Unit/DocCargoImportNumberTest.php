<?php

namespace Tests\Unit;

use App\Http\Controllers\T_doc_cargoController;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;
use ReflectionMethod;

class DocCargoImportNumberTest extends TestCase
{
    #[DataProvider('importedNumbers')]
    public function test_preserves_imported_numbers(string $input, string $expected): void
    {
        $method = new ReflectionMethod(T_doc_cargoController::class, 'formatImportedNumber');

        $this->assertSame($expected, $method->invoke(new T_doc_cargoController, $input));
    }

    /**
     * @return array<string, array{string, string}>
     */
    public static function importedNumbers(): array
    {
        return [
            'cargo H2 regression' => ['-9.5000000000000001E-2', '-0.095000'],
            'negative exponent' => ['-7.25E-04', '-0.000725'],
            'positive exponent' => ['1.234E+05', '123400.000000'],
            'explicit positive sign' => ['+7.25e-4', '0.000725'],
            'Indonesian separators' => ['1.234,56', '1234.560000'],
            'English separators' => ['1,234.56', '1234.560000'],
            'decimal comma' => ['-0,07', '-0.070000'],
        ];
    }

    #[DataProvider('importedPercentages')]
    public function test_preserves_percentage_points(string $input, string $expected): void
    {
        $method = new ReflectionMethod(T_doc_cargoController::class, 'formatImportedPercent');

        $this->assertSame($expected, $method->invoke(new T_doc_cargoController, $input));
    }

    /**
     * @return array<string, array{string, string}>
     */
    public static function importedPercentages(): array
    {
        return [
            'scientific percentage' => ['-7.25E-04', '-0.000725'],
            'text percentage' => ['-0.07%', '-0.070000'],
            'localized percentage' => ['-0,07%', '-0.070000'],
            'zero percentage' => ['0%', '0.000000'],
        ];
    }
}
