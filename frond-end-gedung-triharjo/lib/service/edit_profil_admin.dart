import 'dart:convert';
import 'dart:developer';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class EditProfilAdminService {
  Future postEditAdminProfil({
    required String name,
    required String email,
    required String password,
    required String noTelp,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().put(
        '$triharjoAPI/user',
        options: Options(headers: {
          "accept": "application/json",
          "Content-Type": 'application/json',
          "Authorization": "Bearer $token",
        }),
        data: json.encode({
          "nama": name,
          "email": email,
          "noTelp": noTelp,
          "password": password
        }),
      );
      return response.data;
    } on DioException catch (e) {
      log("$e");
      return e.response?.data;
    }
  }
}
