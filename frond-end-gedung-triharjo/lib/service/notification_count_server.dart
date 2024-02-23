import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class NotivicationCountService {
  static Dio _dio = Dio();

  static Future<Map<String, dynamic>> fetchNotificationData() async {
    String? token = await getToken();
    try {
      final response = await await Dio().get('$triharjoAPI/admin/notif/count',
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
