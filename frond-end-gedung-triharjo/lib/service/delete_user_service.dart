import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class DeleteUserService {
  Future adminDelete({
    required String email,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().delete(
        '$triharjoAPI/admin/user?email=$email',
        options: Options(
          headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      log('$e');
      return e.response?.data;
    }
  }
}
