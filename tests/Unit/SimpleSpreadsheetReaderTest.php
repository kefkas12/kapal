<?php

namespace Tests\Unit;

use App\Http\Controllers\T_doc_cargoController;
use App\Http\Controllers\T_master_cableController;
use App\Support\SimpleSpreadsheetReader;
use PHPUnit\Framework\TestCase;
use ReflectionMethod;
use RuntimeException;
use ZipArchive;

class SimpleSpreadsheetReaderTest extends TestCase
{
    private string $path;

    protected function setUp(): void
    {
        parent::setUp();
        $this->path = tempnam(sys_get_temp_dir(), 'cable-xlsx-');
    }

    protected function tearDown(): void
    {
        unlink($this->path);
        parent::tearDown();
    }

    public function test_reads_visible_sheet_and_accepts_cable_headers_from_uploaded_format(): void
    {
        $this->writeWorkbook('<sheet name="Hidden" sheetId="1" state="hidden" r:id="rId1"/><sheet name="Data" sheetId="2" r:id="rId2"/>');

        $rows = SimpleSpreadsheetReader::readRows($this->path, 'xlsx');
        $parser = new ReflectionMethod(T_master_cableController::class, 'parseCableImportRows');
        [$parsed] = $parser->invoke(new T_master_cableController, $rows);

        $this->assertCount(1, $parsed);
        $this->assertSame('004/TCP/1/2024', $parsed[0]['no_kontrak']);
        $this->assertSame('AB5FL9/24002/L', $parsed[0]['no_voyage_gab']);
        $this->assertSame(2, $parsed[0]['row_number']);
    }

    public function test_uses_workbook_order_and_absolute_relationship_targets(): void
    {
        $this->writeWorkbook('<sheet name="Data" sheetId="2" r:id="rId2"/><sheet name="Other" sheetId="1" r:id="rId1"/>', '/xl/worksheets/sheet2.xml');

        $rows = SimpleSpreadsheetReader::readRows($this->path, 'xlsx');

        $this->assertSame('AB5FL9/24002/L', $rows[1][1]);
    }

    public function test_keeps_first_visible_sheet_when_multiple_sheets_are_visible(): void
    {
        $this->writeWorkbook('<sheet name="First" sheetId="1" r:id="rId1"/><sheet name="Second" sheetId="2" r:id="rId2"/>');

        $this->assertSame([['Existing sheet']], SimpleSpreadsheetReader::readRows($this->path, 'xlsx'));
    }

    public function test_rejects_workbooks_without_visible_worksheets(): void
    {
        $this->writeWorkbook('<sheet name="Hidden" sheetId="1" state="hidden" r:id="rId1"/><sheet name="Very hidden" sheetId="2" state="veryHidden" r:id="rId2"/>');

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Tidak ada worksheet terlihat');

        SimpleSpreadsheetReader::readRows($this->path, 'xlsx');
    }

    public function test_falls_back_to_sheet_one_for_legacy_files_without_workbook_metadata(): void
    {
        $zip = new ZipArchive;
        $zip->open($this->path, ZipArchive::OVERWRITE);
        $zip->addFromString('xl/worksheets/sheet1.xml', $this->sheetXml('<row r="1"><c r="A1" t="inlineStr"><is><t>Legacy</t></is></c></row>'));
        $zip->close();

        $this->assertSame([['Legacy']], SimpleSpreadsheetReader::readRows($this->path, 'xlsx'));
    }

    private function writeWorkbook(string $sheets, string $target = 'worksheets/sheet2.xml'): void
    {
        $zip = new ZipArchive;
        $zip->open($this->path, ZipArchive::OVERWRITE);
        $zip->addFromString('xl/workbook.xml', '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets>'.$sheets.'</sheets></workbook>');
        $zip->addFromString('xl/_rels/workbook.xml.rels', '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="'.$target.'"/></Relationships>');
        $zip->addFromString('xl/worksheets/sheet1.xml', $this->sheetXml('<row r="1"><c r="A1" t="inlineStr"><is><t>Existing sheet</t></is></c></row>'));
        $zip->addFromString('xl/worksheets/sheet2.xml', $this->sheetXml('<row r="1"><c r="A1" t="inlineStr"><is><t>No kontrak</t></is></c><c r="B1" t="inlineStr"><is><t>No. Voyage Gabungan</t></is></c></row><row r="2"><c r="A2" t="inlineStr"><is><t>004/TCP/1/2024</t></is></c><c r="B2" t="inlineStr"><is><t>AB5FL9/24002/L</t></is></c></row>'));
        $zip->close();
    }

    public function test_percentage_points_are_opt_in_and_only_apply_to_numeric_percentage_formats(): void
    {
        $this->writePercentageWorkbook();

        $rawRows = SimpleSpreadsheetReader::readRows($this->path, 'xlsx');
        $convertedRows = SimpleSpreadsheetReader::readRows($this->path, 'xlsx', percentagePoints: true);

        $this->assertSame('-7E-04', $rawRows[1][2]);
        $this->assertEqualsWithDelta(-0.07, (float) $convertedRows[1][2], 0.00000001);
        $this->assertEqualsWithDelta(1.25, (float) $convertedRows[1][3], 0.00000001);
        $this->assertEqualsWithDelta(-0.125, (float) $convertedRows[1][4], 0.00000001);
        $this->assertSame('0.25', $convertedRows[1][5]);
        $this->assertSame('0.5', $convertedRows[1][6]);
        $this->assertSame('-0.07%', $convertedRows[1][7]);
        $this->assertSame('0.002', $convertedRows[1][8]);
        $this->assertSame('', $convertedRows[1][9]);
    }

    public function test_converted_percentage_reaches_doc_cargo_payload_without_changing_its_scale(): void
    {
        $this->writePercentageWorkbook();
        $controller = new T_doc_cargoController;
        $parser = new ReflectionMethod(T_doc_cargoController::class, 'parseDocCargoImportRows');
        $builder = new ReflectionMethod(T_doc_cargoController::class, 'buildDocCargoImportPayload');

        $parsed = $parser->invoke($controller, SimpleSpreadsheetReader::readRows($this->path, 'xlsx', percentagePoints: true));
        $payload = $builder->invoke($controller, $parsed['groups'][0]['fields'], (object) ['id' => 12], ['id' => 34, 'price_bbl' => '80']);

        $this->assertSame('-0.070000', $payload['ratio_r2']);
        $this->assertSame('1.250000', $payload['ratio_r1']);
        $this->assertSame('-0.125000', $payload['ratio_r3']);
    }

    public function test_percentage_option_accepts_workbook_without_styles(): void
    {
        $zip = new ZipArchive;
        $zip->open($this->path, ZipArchive::OVERWRITE);
        $zip->addFromString('xl/worksheets/sheet1.xml', $this->sheetXml('<row r="1"><c r="A1" s="1"><v>0.125</v></c></row>'));
        $zip->close();

        $this->assertSame([['0.125']], SimpleSpreadsheetReader::readRows($this->path, 'xlsx', percentagePoints: true));
    }

    private function writePercentageWorkbook(): void
    {
        $zip = new ZipArchive;
        $zip->open($this->path, ZipArchive::OVERWRITE);
        $zip->addFromString('xl/styles.xml', '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><numFmts count="3"><numFmt numFmtId="164" formatCode="0.000%;[Red]-0.000%"/><numFmt numFmtId="165" formatCode="0.00&quot;%&quot;"/><numFmt numFmtId="166" formatCode="0.00\\%"/></numFmts><cellXfs count="6"><xf numFmtId="0"/><xf numFmtId="9"/><xf numFmtId="10"/><xf numFmtId="164"/><xf numFmtId="165"/><xf numFmtId="166"/></cellXfs></styleSheet>');
        $zip->addFromString('xl/worksheets/sheet1.xml', $this->sheetXml('<row r="1"><c r="A1" t="inlineStr"><is><t>No Voyage</t></is></c><c r="B1" t="inlineStr"><is><t>Grade</t></is></c><c r="C1" t="inlineStr"><is><t>R2 (%)</t></is></c><c r="D1" t="inlineStr"><is><t>R1 (%)</t></is></c><c r="E1" t="inlineStr"><is><t>R3 (%)</t></is></c></row><row r="2"><c r="A2" t="inlineStr"><is><t>AB5FL9/24002/L</t></is></c><c r="B2" t="inlineStr"><is><t>PERTALITE</t></is></c><c r="C2" s="1"><v>-7E-04</v></c><c r="D2" s="2"><v>0.0125</v></c><c r="E2" s="3"><f>-0.00125</f><v>-0.00125</v></c><c r="F2" s="4"><v>0.25</v></c><c r="G2" s="5"><v>0.5</v></c><c r="H2" s="1" t="inlineStr"><is><t>-0.07%</t></is></c><c r="I2"><v>0.002</v></c><c r="J2" s="1"><f>1/100</f></c></row>'));
        $zip->close();
    }

    private function sheetXml(string $rows): string
    {
        return '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetData>'.$rows.'</sheetData></worksheet>';
    }
}
