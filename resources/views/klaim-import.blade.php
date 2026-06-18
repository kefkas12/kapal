<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Import Klaim</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #1f2937;
            margin: 0;
            padding: 32px 16px;
        }
        .container {
            max-width: 980px;
            margin: 0 auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.08);
            padding: 24px;
        }
        h1 {
            margin-top: 0;
            font-size: 28px;
        }
        p {
            line-height: 1.6;
        }
        .card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 16px;
            margin-top: 20px;
        }
        .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 16px;
        }
        .button, button {
            display: inline-block;
            background: #334155;
            color: #fff;
            border-radius: 8px;
            padding: 10px 16px;
            text-decoration: none;
            border: 0;
            cursor: pointer;
        }
        .success {
            background: #ecfdf5;
            border-color: #86efac;
        }
        .warning {
            background: #fff7ed;
            border-color: #fdba74;
        }
        .meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 12px;
            margin-top: 12px;
        }
        .meta div {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px;
        }
        .meta strong {
            display: block;
            font-size: 20px;
            margin-top: 4px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 16px;
        }
        th, td {
            border: 1px solid #e2e8f0;
            padding: 10px;
            text-align: left;
            vertical-align: top;
        }
        th {
            background: #f8fafc;
        }
        ul {
            margin: 0;
            padding-left: 20px;
        }
        code {
            background: #e2e8f0;
            border-radius: 6px;
            padding: 2px 6px;
        }
        input[type="file"] {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            margin-top: 6px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Import Klaim</h1>
        <p>Halaman ini dipakai untuk import header <code>t_klaim</code> dari file Excel/CSV. Header file mengikuti label frontend, bukan nama kolom database.</p>

        <div class="card">
            <strong>Format file import</strong>
            <ul>
                <li>Header wajib: <code>No Klaim Awal</code>, <code>Tgl Klaim Awal</code>, <code>Jenis Klaim</code>, dan <code>Vessel</code>.</li>
                <li>Header opsional: <code>Periode Klaim</code>, <code>No Klaim Akhir</code>, dan <code>Tgl Klaim Akhir</code>.</li>
                <li><code>Vessel</code> bisa diisi kode vessel atau nama vessel.</li>
                <li><code>Jenis Klaim</code> yang didukung: <code>SSOB</code>, <code>SPOB</code>, <code>TL</code>, dan <code>BOD</code>.</li>
                <li>Import akan create baru atau update data existing berdasarkan <code>No Klaim Awal</code>.</li>
                <li>Status hasil import disimpan sebagai <strong>OPEN</strong>.</li>
            </ul>
            <div class="actions">
                <a class="button" href="{{ route('klaim.import.template') }}">Download Template</a>
                <a class="button" href="{{ route('klaim.import.source') }}">Download Semua Klaim</a>
            </div>
        </div>

        @if ($errors->any())
            <div class="card warning">
                <strong>Validasi gagal</strong>
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <div class="card">
            <strong>Upload file import</strong>
            <form method="POST" action="{{ route('klaim.import.submit') }}" enctype="multipart/form-data" style="margin-top: 16px;">
                @csrf
                <label for="file">File Import</label>
                <input id="file" type="file" name="file" accept=".xlsx,.xls,.csv,.html,.xml" required>
                <div class="actions">
                    <button type="submit">Import Sekarang</button>
                </div>
            </form>
        </div>

        @if ($result)
            <div class="card success">
                <strong>Import selesai</strong>
                <div class="meta">
                    <div>Created<strong>{{ $result['created'] ?? 0 }}</strong></div>
                    <div>Updated<strong>{{ $result['updated'] ?? 0 }}</strong></div>
                    <div>Skipped<strong>{{ $result['skipped'] ?? 0 }}</strong></div>
                </div>
            </div>
        @endif

        @if (!empty($result['updated_rows']))
            <div class="card">
                <strong>Trace Updated</strong>
                <table>
                    <thead>
                        <tr>
                            <th>Baris</th>
                            <th>Klaim ID</th>
                            <th>No Klaim Awal</th>
                            <th>Jenis Klaim</th>
                            <th>Vessel</th>
                            <th>Status Sebelumnya</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($result['updated_rows'] as $item)
                            <tr>
                                <td>{{ $item['row_number'] }}</td>
                                <td>{{ $item['klaim_id'] }}</td>
                                <td>{{ $item['no_klaim_awal'] }}</td>
                                <td>{{ $item['jenis_klaim'] }}</td>
                                <td>{{ $item['vessel'] ?? '-' }}</td>
                                <td>{{ $item['previous_status'] ?? '-' }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        @endif

        @if (!empty($result['created_rows']))
            <div class="card">
                <strong>Trace Created</strong>
                <table>
                    <thead>
                        <tr>
                            <th>Baris</th>
                            <th>Klaim ID</th>
                            <th>No Klaim Awal</th>
                            <th>Jenis Klaim</th>
                            <th>Vessel</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($result['created_rows'] as $item)
                            <tr>
                                <td>{{ $item['row_number'] }}</td>
                                <td>{{ $item['klaim_id'] }}</td>
                                <td>{{ $item['no_klaim_awal'] }}</td>
                                <td>{{ $item['jenis_klaim'] }}</td>
                                <td>{{ $item['vessel'] ?? '-' }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        @endif

        @if (!empty($errorsFromImport))
            <div class="card warning">
                <strong>Catatan import</strong>
                <ul>
                    @foreach ($errorsFromImport as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif
    </div>
</body>
</html>
