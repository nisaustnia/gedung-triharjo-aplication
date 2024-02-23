import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class ChangeAdminService {
  Future adminAdd({
    required String email,
    required String type,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().put(
        '$triharjoAPI/admin/user/change?email=$email&role=$type',
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
