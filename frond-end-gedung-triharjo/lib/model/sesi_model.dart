class SesiModel {
  final String tanggal;
  final List<String> time;

  SesiModel({
    required this.tanggal,
    required this.time,
  });

  factory SesiModel.fromJson(Map<String, dynamic> json) {
    return SesiModel(
      tanggal: json['tanggal'],
      time: List<String>.from(json['time']),
    );
  }
}
