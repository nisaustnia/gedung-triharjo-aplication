import 'dart:async';

import 'package:flutter/foundation.dart';

class NotificationViewModel with ChangeNotifier {
  String _token = "";
  int _notReadYet = 0;

  String get token => _token;
  int get notReadYet => _notReadYet;

  final _notificationController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get notificationStream =>
      _notificationController.stream;

  setNotificationData(String token, int notReadYet) {
    _token = token;
    _notReadYet = notReadYet;
    _notificationController.add({'token': token, 'notReadYet': notReadYet});
    notifyListeners();
  }

  void dispose() {
    _notificationController.close();
    super.dispose();
  }
}
