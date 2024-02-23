class DetailPemesananModel {
  final String bookingCode;
  final String event;
  final String status;
  final int totalPembayaran;

  DetailPemesananModel({
    required this.bookingCode,
    required this.event,
    required this.status,
    required this.totalPembayaran,
  });

  factory DetailPemesananModel.fromJson(Map<String, dynamic> json) {
    return DetailPemesananModel(
      bookingCode: json['bookingCode'],
      event: json['event'],
      status: json['status'],
      totalPembayaran: json['totalPembayaran'],
    );
  }
}
