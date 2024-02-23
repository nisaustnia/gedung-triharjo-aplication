class BookingModel {
  final String bookingCode;
  final String event;
  final String noKTP;
  final String nama;
  final String email;
  final String noTelp;
  final String time;
  final DateTime dateMulai;
  final int jumlahHari;
  final String status;
  final int totalPembayaran;
  final PembayaranModel? pembayaran;
  final DateTime createdAt;
  final String alamat;
  final String rtrw;

  BookingModel({
    required this.bookingCode,
    required this.event,
    required this.noKTP,
    required this.nama,
    required this.email,
    required this.noTelp,
    required this.time,
    required this.dateMulai,
    required this.jumlahHari,
    required this.status,
    required this.totalPembayaran,
    required this.pembayaran,
    required this.createdAt,
    required this.alamat,
    required this.rtrw,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingCode: json['bookingCode'],
      event: json['event'],
      noKTP: json['noKTP'],
      nama: json['nama'],
      email: json['email'],
      noTelp: json['noTelp'],
      time: json['time'] ?? '',
      dateMulai: DateTime.parse(json['dateMulai']),
      jumlahHari: json['jumlahHari'] ?? 1,
      status: json['status'],
      totalPembayaran: json['totalPembayaran'],
      pembayaran: json['pembayaran'] != null
          ? PembayaranModel.fromJson(json['pembayaran'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      alamat: json['alamat'],
      rtrw: json['rtrw'],
    );
  }
}

class PembayaranModel {
  final String vaNumber;
  final DateTime expiryTime;
  final String tipePembayaran;

  PembayaranModel({
    required this.vaNumber,
    required this.expiryTime,
    required this.tipePembayaran,
  });

  factory PembayaranModel.fromJson(Map<String, dynamic> json) {
    return PembayaranModel(
      vaNumber: json['va_number'],
      expiryTime: DateTime.parse(json['expiry_time']),
      tipePembayaran: json['tipePembayaran'],
    );
  }
}
