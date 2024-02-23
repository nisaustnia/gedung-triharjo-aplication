import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';
import 'package:penyewaan_gedung_triharjo/model/bulanan_model.dart';

class BulananService {
  static Future<List<BulananModel>> fetchListBulananData() async {
    String? token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$triharjoAPI/event/5/check",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["result"];
        return data.map((item) => BulananModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Bulanan Pemesanan Data');
      }
    } catch (error) {
      log("$error");
      throw Exception('Error: $error');
    }
  }
}
