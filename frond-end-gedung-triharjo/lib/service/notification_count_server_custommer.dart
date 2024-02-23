import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class NotivicationCountServiceCustommer {
  static Dio _dio = Dio();

  static Future<Map<String, dynamic>> fetchNotificationData() async {
    String? token = await getToken();
    try {
      final response = await Dio().get('$triharjoAPI/notif/count',
          options: Options(headers: {
            "Content-Type": 'text/plain',
            "Authorization": "Bearer $token",
          }));
      log('Berhasil : ${response.data}');
      return response.data;
    } catch (error) {
      log('Gagal : ${error}');
      throw Exception('Failed to load notification data: $error');
    }
  }
}
