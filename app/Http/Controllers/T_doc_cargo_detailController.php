<?php

namespace App\Http\Controllers;

use App\Models\T_doc_cargo_detail;
use App\Models\File_upload;
use App\Models\T_master_cable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class T_doc_cargo_detailController extends Controller
{
    public function index(Request $request)
    {
        $query = T_doc_cargo_detail::query()
            ->select('t_klaim_detail.*');

        $idKlaim = $request->input('id_doc_cargo');
        if (!is_null($idKlaim) && $idKlaim !== '') {
            $query->where('t_doc_cargo_detail.id_doc_cargo', $idKlaim);
        }

        $data = $query->get();

        return response()->json([
            'success' => true,
            'message' => 'Data T_doc_cargo_detail berhasil diambil',
            'data'    => $data
        ]);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = T_doc_cargo_detail::query()
            ->where('t_doc_cargo_detail.id', $id)
            ->select('t_doc_cargo_detail.*')
            ->first();
        $files = File_upload::where('id_doc_cargo_detail', $id)
            ->orderBy('id', 'asc')
            ->get();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details T_doc_cargo_detail berhasil diambil',
            'data'    => [
                'detail' => $data,
                'files' => $files,
            ]
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_doc_cargo_detail = new T_doc_cargo_detail();
            $t_doc_cargo_detail->id_doc_cargo = $request->input('id_doc_cargo');
            $t_doc_cargo_detail->id_cable = $request->input('id_cable');
            $t_doc_cargo_detail->no_urut = $request->input('no_urut');
            $t_doc_cargo_detail->no_voyage_gab = $request->input('no_voyage_gab');
            $t_doc_cargo_detail->no_kontrak = $request->input('no_kontrak');
            $t_doc_cargo_detail->val_potensi = $request->input('val_potensi');
            $t_doc_cargo_detail->val_doc_cargo_awal = $request->input('val_doc_cargo_awal');
            $t_doc_cargo_detail->val_doc_cargo_akhir = $request->input('val_doc_cargo_akhir');
            $t_doc_cargo_detail->kurs = $request->input('kurs');
            $t_doc_cargo_detail->val_doc_cargo_akhir_idr = $request->input('val_doc_cargo_akhir_idr');
            $t_doc_cargo_detail->keterangan = $request->input('keterangan');
            $t_doc_cargo_detail->no_tagihan_doc_cargo = $request->input('no_tagihan_doc_cargo');
            $t_doc_cargo_detail->no_tagihan_dipotong = $request->input('no_tagihan_dipotong');
            $t_doc_cargo_detail->status = $request->input('status');
            $t_doc_cargo_detail->user_id = Auth::id();
            $t_doc_cargo_detail->save();

            if ($t_doc_cargo_detail->status === 'CLOSE' && $t_doc_cargo_detail->id_cable) {
                T_master_cable::where('id', $t_doc_cargo_detail->id_cable)
                    ->update(['status' => 'CLOSE']);
            }

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/doc_cargo_detail', 'public');
                    $upload = new File_upload();
                    $upload->id_doc_cargo_detail = $t_doc_cargo_detail->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_doc_cargo_detail berhasil ditambah'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function edit(Request $request)
    {
        $id = $request->route('id');

        try {
            DB::beginTransaction();
            $t_doc_cargo_detail = T_doc_cargo_detail::where('id', $id)->firstOrFail();
            $t_doc_cargo_detail->id_doc_cargo = $request->input('id_doc_cargo');
            $t_doc_cargo_detail->id_cable = $request->input('id_cable');
            $t_doc_cargo_detail->no_urut = $request->input('no_urut');
            $t_doc_cargo_detail->no_voyage_gab = $request->input('no_voyage_gab');
            $t_doc_cargo_detail->no_kontrak = $request->input('no_kontrak');
            $t_doc_cargo_detail->val_potensi = $request->input('val_potensi');
            $t_doc_cargo_detail->val_doc_cargo_awal = $request->input('val_doc_cargo_awal');
            $t_doc_cargo_detail->val_doc_cargo_akhir = $request->input('val_doc_cargo_akhir');
            $t_doc_cargo_detail->kurs = $request->input('kurs');
            $t_doc_cargo_detail->val_doc_cargo_akhir_idr = $request->input('val_doc_cargo_akhir_idr');
            $t_doc_cargo_detail->keterangan = $request->input('keterangan');
            $t_doc_cargo_detail->no_tagihan_doc_cargo = $request->input('no_tagihan_doc_cargo');
            $t_doc_cargo_detail->no_tagihan_dipotong = $request->input('no_tagihan_dipotong');
            $t_doc_cargo_detail->status = $request->input('status');
            $t_doc_cargo_detail->user_id = Auth::id();
            $t_doc_cargo_detail->save();

            if ($t_doc_cargo_detail->status === 'CLOSE' && $t_doc_cargo_detail->id_cable) {
                T_master_cable::where('id', $t_doc_cargo_detail->id_cable)
                    ->update(['status' => 'CLOSE']);
            }

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/doc_cargo_detail', 'public');
                    $upload = new File_upload();
                    $upload->id_doc_cargo_detail = $t_doc_cargo_detail->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_doc_cargo_detail berhasil diubah'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function delete(Request $request)
    {
        $id = $request->route('id');

        try {
            DB::beginTransaction();
            $t_doc_cargo_detail = T_doc_cargo_detail::where('id', $id)->firstOrFail();

            $files = File_upload::where('id_klaim_detail', $id)->get();
            foreach ($files as $file) {
                if ($file->nama_file) {
                    $disk = Storage::disk('public');
                    if ($disk->exists($file->nama_file)) {
                        $disk->delete($file->nama_file);
                    }
                }
                $file->delete();
            }

            $t_doc_cargo_detail->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim_detail berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
