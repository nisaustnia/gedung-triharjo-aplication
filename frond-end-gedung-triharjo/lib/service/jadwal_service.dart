import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class JadwalService {
  static Future<List<dynamic>> fetchListJadwalData({
    required index,
  }) async {
    String? token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$triharjoAPI/event/$index/check",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["result"];
        return data;
      } else {
        throw Exception('Failed to load Jadwal Pemesanan Data');
      }
    } catch (error) {
      log("$error");
      throw Exception('Error: $error');
    }
  }
}
