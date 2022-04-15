<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Files</title>
</head>
<body>
    <img src="{{ \Illuminate\Support\Facades\Storage::disk('public')->url('files/photo.jpg') }}" alt="Photo">
    <img src="{{ route('image') }}" alt="Photo">
</body>
</html>
