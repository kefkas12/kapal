<?php

namespace App\Http\Controllers;

use App\Models\T_off_hire_detail;
use App\Models\T_master_cable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class T_off_hire_detailController extends Controller
{
    private function detailColumns(): array
    {
        return Schema::getColumnListing('t_off_hire_detail');
    }

    private function calcDischargeTime($startTime, $stopTime): ?string
    {
        if ($startTime === null || $stopTime === null || $startTime === '' || $stopTime === '') {
            return null;
        }

        $startTs = strtotime((string) $startTime);
        $stopTs = strtotime((string) $stopTime);
        if ($startTs === false || $stopTs === false) {
            return null;
        }

        $hours = ($stopTs - $startTs) / 3600;
        $days = $hours / 24;

        return number_format($days, 6, '.', '');
    }

    private function buildPayload(Request $request, ?int $id = null): array
    {
        $idDocCargo = $request->input('id_off_hire');

        $noUrut = $request->input('no_urut');
        if (($noUrut === null || $noUrut === '') && $idDocCargo) {
            $maxNoUrut = DB::table('t_off_hire_detail')
                ->where('id_off_hire', $idDocCargo)
                ->when($id, fn ($q) => $q->where('id', '!=', $id))
                ->get()
                ->reduce(function ($carry, $row) {
                    $raw = $row->no_urut ?? '';
                    $num = (int) preg_replace('/\D/', '', (string) $raw);
                    return max($carry, $num);
                }, 0);
            $noUrut = str_pad((string) ($maxNoUrut + 1), 2, '0', STR_PAD_LEFT);
        }

        $idCable = $request->input('id_cable');
        $noVoyageGab = $request->input('no_voyage_gab');
        if (($noVoyageGab === null || $noVoyageGab === '') && $idCable) {
            $cable = T_master_cable::where('id', $idCable)->first();
            $noVoyageGab = $cable?->no_voyage_gab;
        }

        $startTime = $request->input('start_time');
        $stopTime = $request->input('stop_time');
        $dischargeTime = $request->input('discharge_time');
        if ($dischargeTime === null || $dischargeTime === '') {
            $dischargeTime = $this->calcDischargeTime($startTime, $stopTime);
        }

        $payload = [
            'id_off_hire' => $idDocCargo,
            'id_cable' => $idCable,
            'no_voyage_gab' => $noVoyageGab,
            'no_urut' => $noUrut,
            'start_time' => $startTime,
            'stop_time' => $stopTime,
            'discharge_time' => $dischargeTime,
            'user_id' => Auth::id(),
            'updated_at' => now(),
        ];

        if (!$id) {
            $payload['created_at'] = now();
        }

        $allowed = array_flip($this->detailColumns());
        return array_intersect_key($payload, $allowed);
    }

    public function index(Request $request)
    {
        $query = DB::table('t_off_hire_detail')->select('t_off_hire_detail.*');

        $idDocCargo = $request->input('id_off_hire');
        if (!is_null($idDocCargo) && $idDocCargo !== '') {
            $query->where('t_off_hire_detail.id_off_hire', $idDocCargo);
        }

        $data = $query->orderBy('id', 'asc')->get();

        return response()->json([
            'success' => true,
            'message' => 'Data T_off_hire_detail berhasil diambil',
            'data' => $data,
        ]);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = DB::table('t_off_hire_detail')
            ->where('id', $id)
            ->first();

        return response()->json([
            'success' => true,
            'message' => 'Data details T_off_hire_detail berhasil diambil',
            'data' => [
                'detail' => $data,
                'files' => [],
            ],
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();

            $payload = $this->buildPayload($request);
            $id = DB::table('t_off_hire_detail')->insertGetId($payload);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_off_hire_detail berhasil ditambah',
                'data' => [
                    'id' => $id,
                ],
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function edit(Request $request)
    {
        $id = (int) $request->route('id');

        try {
            DB::beginTransaction();
            T_off_hire_detail::where('id', $id)->firstOrFail();

            $payload = $this->buildPayload($request, $id);
            DB::table('t_off_hire_detail')->where('id', $id)->update($payload);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_off_hire_detail berhasil diubah',
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
            $detail = T_off_hire_detail::where('id', $id)->firstOrFail();
            $detail->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_off_hire_detail berhasil dihapus',
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}
