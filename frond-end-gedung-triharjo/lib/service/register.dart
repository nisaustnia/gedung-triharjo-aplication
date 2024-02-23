import 'dart:convert';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:dio/dio.dart';

class RegisterService {
  Future postRegister({
    required String name,
    required String noKTP,
    required String dukuh,
    required String kelurahan,
    required String kecamatan,
    required String rt,
    required String rw,
    required String email,
    required String gender,
    required String password,
    required String noTelp,
  }) async {
    try {
      Response response = await Dio().post(
        '$triharjoAPI/register',
        options: Options(headers: {
          "Content-Type": 'application/json',
        }),
        data: json.encode({
          "nama": name,
          "noKTP": noKTP,
          "dukuh": dukuh,
          "kelurahan": kelurahan,
          "kecamatan": kecamatan,
          "rt": rt,
          "rw": rw,
          "email": email,
          "password": password,
          "gender": gender,
          "noTelp": noTelp
        }),
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
