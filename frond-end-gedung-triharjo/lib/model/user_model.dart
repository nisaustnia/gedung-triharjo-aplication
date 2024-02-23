class UserDataModel {
  final String token;
  final String type;
  final UserResult result;

  UserDataModel({
    required this.token,
    required this.type,
    required this.result,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      token: json['token'],
      type: json['type'],
      result: UserResult.fromJson(json['result']),
    );
  }
}

class UserResult {
  final String nama;
  final String email;
  final String noTelp;
  final String noKTP;
  final String gender;
  final String alamatLengkap;
  final int wargaTriharjo;

  UserResult({
    required this.nama,
    required this.email,
    required this.noTelp,
    required this.noKTP,
    required this.gender,
    required this.alamatLengkap,
    required this.wargaTriharjo,
  });

  factory UserResult.fromJson(Map<String, dynamic> json) {
    return UserResult(
      nama: json['nama'],
      email: json['email'],
      noTelp: json['noTelp'],
      noKTP: json['noKTP'],
      gender: json['gender'],
      alamatLengkap: json['alamatLengkap'],
      wargaTriharjo: json['wargaTriharjo'],
    );
  }
}
