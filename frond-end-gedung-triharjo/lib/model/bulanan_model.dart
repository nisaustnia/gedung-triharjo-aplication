class BulananModel {
  final String dateMulai;
  final String dateAkhir;
  final String type;
  final String jumlahHari;

  BulananModel({
    required this.dateMulai,
    required this.dateAkhir,
    required this.type,
    required this.jumlahHari,
  });

  factory BulananModel.fromJson(Map<String, dynamic> json) {
    return BulananModel(
      dateMulai: json['dateMulai'],
      dateAkhir: json['dateAkhir'],
      type: json['type'],
      jumlahHari: json['jumlahHari'],
    );
  }
}