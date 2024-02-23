import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class AdminDeleteService {
  Future deletePemesanan({
    required int bookingCode,
  }) async {
    String? token = await getToken();
    try {
      Response response = await Dio().delete(
        '$triharjoAPI/admin/payment/$bookingCode',
        options: Options(
          headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
