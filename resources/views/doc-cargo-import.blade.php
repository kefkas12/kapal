<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doc Cargo Import</title>
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
        .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin: 20px 0 24px;
        }
        .button,
        button {
            background: #0f766e;
            color: #fff;
            border: 0;
            border-radius: 8px;
            padding: 10px 16px;
            text-decoration: none;
            cursor: pointer;
            font-size: 14px;
        }
        .button.secondary {
            background: #334155;
        }
        input[type="file"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            margin-top: 6px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }
        .card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 16px;
            margin-top: 20px;
        }
        .success {
            background: #ecfdf5;
            border-color: #86efac;
        }
        .error {
            background: #fef2f2;
            border-color: #fca5a5;
        }
        ul {
            padding-left: 20px;
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
        code {
            background: #e2e8f0;
            border-radius: 6px;
            padding: 2px 6px;
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
        .inline-form {
            display: flex;
            gap: 12px;
            align-items: end;
            flex-wrap: wrap;
        }
        .inline-form .field {
            flex: 1 1 220px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Import Doc Cargo</h1>
        <p>Halaman ini dipakai untuk import <code>t_doc_cargo</code> dan <code>t_doc_cargo_detail</code> dari file Excel/CSV. Header file mengikuti label di frontend, bukan nama kolom database. Jika satu <code>No Voyage + Grade</code> muncul di beberapa row, sistem akan membuat satu header doc cargo dan semua <code>Start Time Discharge Time</code> / <code>Stop Time Discharge Time</code> akan masuk sebagai detail discharge time.</p>

        <div class="card">
            <strong>Format file import</strong>
            <ul>
                <li>Header wajib: <code>No Voyage</code> dan <code>Grade</code>.</li>
                <li>Header lain mengikuti label FE seperti <code>Price (USD/Bbl)</code>, <code>Bill of Lading (Bbl 60F)</code>, <code>Diff R1 (Bbl 60F)</code>, <code>R1 (%)</code>, sampai <code>Start Time Discharge Time</code> dan <code>Stop Time Discharge Time</code>.</li>
                <li>Jika satu kombinasi <code>No Voyage + Grade</code> muncul di banyak row, semua row itu digabung menjadi satu doc cargo dengan beberapa detail discharge time.</li>
                <li><code>Actual Discharge Time (day)</code> akan dihitung dari total detail discharge time hasil import.</li>
                <li>Import akan create baru atau update data existing berdasarkan <code>No Voyage + Grade</code>, lalu status disimpan sebagai <strong>APPROVE</strong>.</li>
            </ul>
            <div class="actions">
                <a class="button secondary" href="{{ route('doc-cargo.import.template') }}">Download Template</a>
                <a class="button secondary" href="{{ route('doc-cargo.import.source') }}">Download Semua Doc Cargo</a>
            </div>
        </div>

        <div class="card" style="display: none;">
            <strong>Refresh Doc Cargo</strong>
            <p>Refresh massal untuk semua <strong>Doc Cargo user_id = 1</strong> yang statusnya bukan <strong>APPROVE</strong>.</p>
            <form method="POST" action="{{ route('doc-cargo.refresh.submit') }}" class="inline-form">
                @csrf
                <div>
                    <button type="submit">Refresh Semua User 1</button>
                </div>
            </form>
        </div>

        <div class="card" style="display: none;">
            <strong>Buat Klaim Awal</strong>
            <p>Buat klaim awal batch dari <strong>Doc Cargo user_id = 1</strong>. Jenis yang tersedia dari sumber doc cargo: <strong>SSOB</strong>, <strong>SPOB</strong>, dan <strong>TL</strong>.</p>
            <form method="POST" action="{{ route('doc-cargo.klaim-awal.submit') }}" class="inline-form">
                @csrf
                <div class="field">
                    <label for="jenis_klaim">Jenis Klaim</label>
                    <select id="jenis_klaim" name="jenis_klaim" required>
                        <option value="ALL">Semua Jenis Doc Cargo</option>
                        <option value="SSOB">SSOB</option>
                        <option value="SPOB">SPOB</option>
                        <option value="TL">TL</option>
                    </select>
                </div>
                <div>
                    <button type="submit">Buat Klaim Awal</button>
                </div>
            </form>
        </div>

        @if ($errors->any())
            <div class="card error">
                <strong>Validasi gagal</strong>
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        @if ($refreshResult)
            <div class="card success">
                <strong>Refresh berhasil</strong>
                <p>User ID {{ $refreshResult['user_id'] ?? 1 }} berhasil di-refresh untuk {{ $refreshResult['count'] ?? 0 }} doc cargo.</p>
                <div class="meta">
                    <div>User ID<strong>{{ $refreshResult['user_id'] ?? 1 }}</strong></div>
                    <div>Total Refreshed<strong>{{ $refreshResult['count'] ?? 0 }}</strong></div>
                </div>
                @if (!empty($refreshResult['doc_cargo_ids']))
                    <p>Doc Cargo ID: {{ implode(', ', array_slice($refreshResult['doc_cargo_ids'], 0, 30)) }}@if(count($refreshResult['doc_cargo_ids']) > 30) ... @endif</p>
                @endif
            </div>
        @endif

        @if ($klaimAwalResult)
            <div class="card success">
                <strong>Klaim awal berhasil dibuat</strong>
                <p>User ID {{ $klaimAwalResult['user_id'] ?? 1 }} untuk jenis {{ $klaimAwalResult['jenis_klaim'] ?? '-' }}.</p>
                <div class="meta">
                    <div>Header Klaim<strong>{{ $klaimAwalResult['headers_created'] ?? 0 }}</strong></div>
                    <div>Detail Klaim<strong>{{ $klaimAwalResult['details_created'] ?? 0 }}</strong></div>
                </div>
                @if (!empty($klaimAwalResult['groups']))
                    <ul>
                        @foreach ($klaimAwalResult['groups'] as $group)
                            <li>
                                Klaim ID {{ $group['klaim_id'] }} |
                                Jenis {{ $group['jenis_klaim'] }} |
                                Vessel {{ $group['kode_vessel'] ?? $group['id_vessel'] }} |
                                Doc Cargo {{ $group['doc_cargo_count'] }}
                            </li>
                        @endforeach
                    </ul>
                @endif
            </div>
        @endif

        <div class="card">
            <strong>Upload file import</strong>
            <form method="POST" action="{{ route('doc-cargo.import.submit') }}" enctype="multipart/form-data" style="margin-top: 16px;">
                @csrf
                <label for="file">File Import</label>
                <input id="file" type="file" name="file" accept=".xlsx,.xls,.csv,.html,.xml" required>
                <button type="submit">Import Sekarang</button>
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
                            <th>Doc Cargo ID</th>
                            <th>No Voyage</th>
                            <th>Grade</th>
                            <th>Detail Row</th>
                            <th>Status Sebelumnya</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($result['updated_rows'] as $item)
                            <tr>
                                <td>{{ $item['row_number'] }}</td>
                                <td>{{ $item['doc_cargo_id'] }}</td>
                                <td>{{ $item['no_voyage_gab'] ?? '-' }}</td>
                                <td>{{ $item['grade_name'] ?: '-' }}</td>
                                <td>{{ $item['detail_count'] ?? 0 }}</td>
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
                            <th>Doc Cargo ID</th>
                            <th>No Voyage</th>
                            <th>Grade</th>
                            <th>Detail Row</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($result['created_rows'] as $item)
                            <tr>
                                <td>{{ $item['row_number'] }}</td>
                                <td>{{ $item['doc_cargo_id'] }}</td>
                                <td>{{ $item['no_voyage_gab'] ?? '-' }}</td>
                                <td>{{ $item['grade_name'] ?: '-' }}</td>
                                <td>{{ $item['detail_count'] ?? 0 }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        @endif

        @if (!empty($errorsFromImport))
            <div class="card error">
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
