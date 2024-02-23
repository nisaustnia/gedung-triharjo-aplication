class UserModel {
  // Attributes
  String id;
  DateTime createdAt;
  String namaLengkap;
  String email;
  String password;
  String dukuh;
  String kelurahan;
  String kecamatan;
  int? rt;
  int? rw;
  int? noKTP;
  String jenisKelamin;
  String noWhatsapp;
  String typeUser;
  DateTime updatedAt;

  // Constructor
  UserModel({
    required this.id,
    required this.createdAt,
    required this.namaLengkap,
    required this.email,
    required this.password,
    required this.dukuh,
    required this.kelurahan,
    required this.kecamatan,
    required this.rt,
    required this.rw,
    required this.noKTP,
    required this.jenisKelamin,
    required this.noWhatsapp,
    required this.typeUser,
    required this.updatedAt,
  });

  // Factory method to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      namaLengkap: json['namaLengkap'],
      email: json['email'],
      password: json['password'],
      dukuh: json['dukuh'],
      kelurahan: json['kelurahan'],
      kecamatan: json['kecamatan'],
      rt: json['rt'],
      rw: json['rw'],
      noKTP: json['noKTP'],
      jenisKelamin: json['jenisKelamin'],
      noWhatsapp: json['noWhatsapp'],
      typeUser: json['typeUser'],
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toUtc().toIso8601String(),
      'namaLengkap': namaLengkap,
      'email': email,
      'password': password,
      'dukuh': dukuh,
      'kelurahan': kelurahan,
      'kecamatan': kecamatan,
      'rt': rt,
      'rw': rw,
      'noKTP': noKTP,
      'jenisKelamin': jenisKelamin,
      'noWhatsapp': noWhatsapp,
      'typeUser': typeUser,
      'updateAt': updatedAt.toUtc().toIso8601String(),
    };
  }
}
