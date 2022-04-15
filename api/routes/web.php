<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::view('/', 'index');

Route::view('/upload', 'upload');
Route::view('/files', 'files');

Route::post('/upload', function (Request $request) {
    $request->validate([
        'file' => ['required', 'file']
    ]);

    $request->file('file')->storeAs('files', 'photo.jpg', 'local');
    $request->file('file')->storeAs('files', 'photo.jpg', 'public');

    return back();
})->name('upload.store');

Route::get('/image', function () {
    return Storage::disk('local')->response('files/photo.jpg');
})->name('image');

Route::get('/info', function () {
    return phpinfo();
});

Route::get('/version', function () {
    return ['Laravel' => app()->version()];
});

Route::get('/fail', function () {
    throw new DomainException("Testing exception logging");
});

require __DIR__.'/auth.php';
