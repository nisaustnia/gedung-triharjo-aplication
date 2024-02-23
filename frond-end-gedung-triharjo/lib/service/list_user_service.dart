import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';
import 'package:penyewaan_gedung_triharjo/model/list_user_model.dart';

class ListUserService {
  static Future<List<ListUserModel>> fetchListUserData() async {
    String? token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$triharjoAPI/admin/user",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["result"];
        return data.map((item) => ListUserModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load List User Data');
      }
    } catch (error) {
      log("$error");
      throw Exception('Error: $error');
    }
  }
}
