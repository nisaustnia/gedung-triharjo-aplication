import 'dart:convert';
import 'dart:developer';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:dio/dio.dart';

class LoginService {
  Future postLogin({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await Dio().post(
        '$triharjoAPI/login',
        options: Options(headers: {
          "Content-Type": 'application/json',
        }),
        data: json.encode({"email": email, "password": password}),
      );
      return response.data;
    } on DioException catch (e) {
      log('$e');
      return e.response?.data;
    }
  }
}
