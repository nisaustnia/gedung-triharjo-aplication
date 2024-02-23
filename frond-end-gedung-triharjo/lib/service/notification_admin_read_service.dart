import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class NotivicationAdminReadService {
  static Dio _dio = Dio();

  static Future<Map<String, dynamic>> fetchNotificationReadData({
    required int idNotif,
  }) async {
    String? token = await getToken();
    try {
      final response =
          await await Dio().get('$triharjoAPI/admin/notif/$idNotif',
              options: Options(headers: {
                "Content-Type": 'text/plain',
                "Authorization": "Bearer $token",
              }));
      return response.data;
    } catch (error) {
      throw Exception('Failed to load notification data: $error');
    }
  }
}
