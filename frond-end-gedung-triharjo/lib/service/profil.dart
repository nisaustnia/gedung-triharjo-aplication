import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class ProfilService {
  static Future<Response> getDetailUser() async {
    String? token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$triharjoAPI/user",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load User Detail');
      }
    } catch (error) {
      log("$error");
      throw Exception('Error: $error');
    }
  }
}
