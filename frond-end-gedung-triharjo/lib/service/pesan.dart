import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class AddPemesananService {
  Future pemesananAdd({
    required int idEvent,
    required String dateMulai,
    required String jumlahHari,
    required String tipeHarga,
    required String paymentType,
  }) async {
    log('id: $idEvent, dateMulai: $dateMulai, jumlah hari: $jumlahHari, Tipe Harga: $tipeHarga, payment Type : $paymentType');
    String? token = await getToken();
    try {
      Response response = await Dio().post(
        '$triharjoAPI/event/$idEvent',
        options: Options(headers: {
          "Content-Type": 'text/plain',
          "Authorization": "Bearer $token",
        }),
        data: json.encode({
          "dateMulai": dateMulai,
          "jumlahHari": jumlahHari,
          "tipeHarga": tipeHarga,
          "paymentType": paymentType
        }),
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
