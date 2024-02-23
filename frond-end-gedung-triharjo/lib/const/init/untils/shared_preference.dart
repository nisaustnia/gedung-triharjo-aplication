import 'package:shared_preferences/shared_preferences.dart';

const String token = "token";

saveToken({
  required String valueToken,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString(token, valueToken);
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // ignore: unnecessary_nullable_for_final_variable_declarations
  final String dataToken = prefs.getString(token).toString();
  return dataToken;
}

removeToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove(token);
}
