import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class EventService {
  static Future<List<Map<String, dynamic>>> fetchEventData() async {
    String? token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$triharjoAPI/event",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["result"];
        return data
            .map<Map<String, dynamic>>(
                (item) => Map<String, dynamic>.from(item))
            .toList();
      } else {
        throw Exception('Failed to load Event Data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
