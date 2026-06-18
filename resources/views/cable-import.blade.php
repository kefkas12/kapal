<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Import Master Cable</title>
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
        .button {
            display: inline-block;
            background: #334155;
            color: #fff;
            border-radius: 8px;
            padding: 10px 16px;
            text-decoration: none;
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Import Master Cable</h1>
        <p>Halaman ini dipakai untuk import <code>t_master_cable</code> dari file Excel/CSV. Minimal file cukup punya dua kolom: <code>No Kontrak</code> dan <code>No Voyage Gab</code>. Header file mengikuti label frontend, bukan nama kolom database. Sistem akan lookup <code>No Kontrak</code> ke DB untuk mendapatkan <code>id_kontrak</code>, lalu membuat atau mengupdate data cable berdasarkan <code>No Voyage Gab</code>. Saat import, data dari file dianggap sebagai sumber yang paling benar.</p>

        <div class="card">
            <strong>Format minimal file</strong>
            <ul>
                <li>Header wajib: <code>No Kontrak</code> dan <code>No Voyage Gab</code>.</li>
                <li>Kolom lain opsional. Kalau tidak ada, import tetap jalan.</li>
                <li>Kolom turunan seperti <code>speed</code> s.d. <code>excess_bunker</code> dan <code>est_claim_bunker</code> tidak perlu ada di file karena dihitung otomatis saat import.</li>
                <li>Jika <code>No Voyage Gab</code> sudah ada, sistem akan update record yang sama dan menyesuaikan <code>id_kontrak</code> dari file import.</li>
                <li>Setiap row hasil import akan langsung disimpan dengan status <strong>APPROVE</strong>.</li>
                <li>Saat import, sistem tidak membandingkan dengan kontrak <strong>ACTIVE</strong>. Acuan utamanya adalah <code>No Kontrak</code> dari file.</li>
                <li>Jika <code>No Voyage Gab</code> duplikat di database, semua row yang cocok akan ikut diupdate.</li>
            </ul>
            <div class="actions">
                <a class="button" href="{{ route('cable.import.template') }}">Download Template</a>
                <a class="button" href="{{ route('cable.import.source') }}">Download Semua No Kontrak + Master Cable</a>
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
            <form method="POST" action="{{ route('cable.import.submit') }}" enctype="multipart/form-data" style="margin-top: 16px;">
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
                            <th>Cable ID</th>
                            <th>No Kontrak</th>
                            <th>No Voyage Gab</th>
                            <th>Catatan</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($result['updated_rows'] as $item)
                            <tr>
                                <td>{{ $item['row_number'] }}</td>
                                <td>{{ $item['cable_id'] }}</td>
                                <td>{{ $item['no_kontrak'] }}</td>
                                <td>{{ $item['no_voyage_gab'] }}</td>
                                <td>
                                    @if (!empty($item['kontrak_changed']))
                                        id_kontrak diubah dari {{ $item['previous_no_kontrak'] ?? '-' }} ke {{ $item['no_kontrak'] }}
                                    @else
                                        Update data existing
                                    @endif
                                    @if (($item['duplicate_group_count'] ?? 1) > 1)
                                        (duplikat DB: {{ $item['duplicate_group_count'] }} row)
                                    @endif
                                    @if (!empty($item['previous_status']))
                                        (status sebelumnya: {{ $item['previous_status'] }})
                                    @endif
                                </td>
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
                            <th>Cable ID</th>
                            <th>No Kontrak</th>
                            <th>No Voyage Gab</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($result['created_rows'] as $item)
                            <tr>
                                <td>{{ $item['row_number'] }}</td>
                                <td>{{ $item['cable_id'] }}</td>
                                <td>{{ $item['no_kontrak'] }}</td>
                                <td>{{ $item['no_voyage_gab'] }}</td>
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

        <div class="card {{ ($checkResult['issue_count'] ?? 0) > 0 ? 'warning' : 'success' }}">
            <strong>Check DB saat ini</strong>
            <div class="meta">
                <div>Total Cable Dicek<strong>{{ $checkResult['checked_count'] ?? 0 }}</strong></div>
                <div>Total Issue<strong>{{ $checkResult['issue_count'] ?? 0 }}</strong></div>
            </div>
        </div>

        @if (!empty($checkResult['issues']))
            <div class="card warning">
                <strong>Daftar issue DB</strong>
                <table>
                    <thead>
                        <tr>
                            <th>Cable ID</th>
                            <th>No Voyage Gab</th>
                            <th>No Kontrak Sekarang</th>
                            <th>Keterangan Kontrak</th>
                            <th>Issue</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($checkResult['issues'] as $item)
                            <tr>
                                <td>{{ $item['cable_id'] }}</td>
                                <td>{{ $item['no_voyage_gab'] ?? '-' }}</td>
                                <td>{{ $item['current_no_kontrak'] ?? '-' }}</td>
                                <td>{{ $item['expected_no_kontrak'] ?? '-' }}</td>
                                <td>
                                    <ul>
                                        @foreach ($item['reasons'] as $reason)
                                            <li>{{ $reason }}</li>
                                        @endforeach
                                    </ul>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        @else
            <div class="card success">
                <strong>Tidak ada issue DB</strong>
                <p>Semua data cable yang dicek saat ini lulus pengecekan konsistensi dasar.</p>
            </div>
        @endif
    </div>
</body>
</html>
