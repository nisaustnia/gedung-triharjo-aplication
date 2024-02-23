class Notification {
  final int idNotif;
  final String notif;
  final String idUser;
  final int isRead;
  final String createdAt;
  final String updatedAt;
  final String bookingCode;

  Notification({
    required this.idNotif,
    required this.notif,
    required this.idUser,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingCode,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      idNotif: json['idNotif'],
      notif: json['notif'],
      idUser: json['idUser'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      bookingCode: json['bookingCode'],
    );
  }
}
