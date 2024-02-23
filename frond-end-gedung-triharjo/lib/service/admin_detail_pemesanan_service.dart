import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class AdminDetailPemesananService {
  static Future<Response> getAdminDetailPemesanan({
    required String codeBooking,
  }) async {
    String token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$triharjoAPI/admin/payment/$codeBooking",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load Pemesanan Detail');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
