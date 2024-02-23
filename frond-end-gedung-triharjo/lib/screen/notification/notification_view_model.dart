import 'dart:async';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_model_notification.dart';
import 'package:penyewaan_gedung_triharjo/service/notification_service_admin.dart';
import 'package:penyewaan_gedung_triharjo/service/notification_service.dart';
import 'package:rxdart/rxdart.dart';

class NotificationListViewModel extends ChangeNotifier {
  final notificationController = BehaviorSubject<List<NotificationModel>>();
  late Timer timer1;
  Stream<List<NotificationModel>> get notificationStream =>
      notificationController.stream;

  bool _isTimerActive = false;

  StreamSubscription<List<NotificationModel>>? subscription;

  Future<void> getNotificationData() async {
    try {
      final List<NotificationModel> notificationData =
          await NotificationService.fetchListNotificationData();
      notificationController.add(notificationData);
    } catch (error) {
      throw Exception('Error loading history data: $error');
    }
  }

  Future<void> getNotificationAdminData() async {
    try {
      final List<NotificationModel> notificationData =
          await NotificationAdminService.fetchListNotificationData();
      notificationController.add(notificationData);
    } catch (error) {
      throw Exception('Error loading notification data: $error');
    }
  }

  void cancelTimer() {
    if (_isTimerActive) {
      timer1.cancel();
      _isTimerActive = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }
}
