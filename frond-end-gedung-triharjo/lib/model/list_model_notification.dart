class NotificationModel {
  final int idNotif;
  final String notif;
  final String idUser;
  final int isRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String bookingCode;

  NotificationModel({
    required this.idNotif,
    required this.notif,
    required this.idUser,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingCode,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      idNotif: json['idNotif'],
      notif: json['notif'],
      idUser: json['idUser'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      bookingCode: json['bookingCode'],
    );
  }
}
