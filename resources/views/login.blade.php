<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Import</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f7fb; color: #1f2937; margin: 0; padding: 32px 16px; }
        main { max-width: 420px; margin: 0 auto; padding: 24px; background: white; border-radius: 12px; }
        label { display: block; margin-top: 16px; }
        input { box-sizing: border-box; width: 100%; padding: 10px; margin-top: 6px; border: 1px solid #94a3b8; border-radius: 6px; }
        button { margin-top: 20px; padding: 10px 16px; background: #334155; color: white; border: 0; border-radius: 6px; cursor: pointer; }
        .error { color: #b91c1c; }
    </style>
</head>
<body>
    <main>
        <h1>Login Import</h1>
        <p>Gunakan email dan password akun aplikasi Anda untuk melanjutkan import.</p>
        @if ($errors->any())
            <div class="error" role="alert">
                @foreach ($errors->all() as $error)
                    <p>{{ $error }}</p>
                @endforeach
            </div>
        @endif
        <form method="POST" action="{{ route('login.store') }}">
            @csrf
            <label for="email">Email</label>
            <input id="email" name="email" type="email" value="{{ old('email') }}" autocomplete="username" required autofocus>
            <label for="password">Password</label>
            <input id="password" name="password" type="password" autocomplete="current-password" required>
            <button type="submit">Masuk</button>
        </form>
    </main>
</body>
</html>
