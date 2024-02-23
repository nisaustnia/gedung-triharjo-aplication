class JadwalModel {
  final String token;
  final String type;
  final List<String> result;

  JadwalModel({
    required this.token,
    required this.type,
    required this.result,
  });

  factory JadwalModel.fromJson(Map<String, dynamic> json) {
    List<String> resultList = List<String>.from(json['result']);
    return JadwalModel(
      token: json['token'],
      type: json['type'],
      result: resultList,
    );
  }
}
