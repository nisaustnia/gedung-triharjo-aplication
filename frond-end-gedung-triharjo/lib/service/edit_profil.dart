import 'dart:convert';
import 'dart:developer';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class EditProfilService {
  Future postEditProfil({
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
      log("$e");
      return e.response?.data;
    }
  }
}
