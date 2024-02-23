class ListUserModel {
  final int idUser;
  final String nama;
  final String noKTP;
  final String dukuh;
  final String kelurahan;
  final String kecamatan;
  final String rt;
  final String rw;
  final String email;
  final String password;
  final String gender;
  final String noTelp;
  final String typeUser;
  final String createdAt;
  final String updatedAt;
  final int wargaTriharjo;

  ListUserModel({
    required this.idUser,
    required this.nama,
    required this.noKTP,
    required this.dukuh,
    required this.kelurahan,
    required this.kecamatan,
    required this.rt,
    required this.rw,
    required this.email,
    required this.password,
    required this.gender,
    required this.noTelp,
    required this.typeUser,
    required this.createdAt,
    required this.updatedAt,
    required this.wargaTriharjo,
  });
  factory ListUserModel.fromJson(Map<String, dynamic> json) {
    return ListUserModel(
      idUser: json['idUser'],
      nama: json['nama'],
      noKTP: json['noKTP'],
      dukuh: json['dukuh'],
      kelurahan: json['kelurahan'],
      kecamatan: json['kecamatan'],
      rt: json['rt'],
      rw: json['rw'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      noTelp: json['noTelp'],
      typeUser: json['typeUser'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      wargaTriharjo: json['wargaTriharjo'],
    );
  }
}
