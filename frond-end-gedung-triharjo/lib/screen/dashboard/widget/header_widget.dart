// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/bottom_bar/bottom_bar.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/notification_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/notification/notification_screen.dart';
import 'package:penyewaan_gedung_triharjo/service/notification_count_server.dart';
import 'package:penyewaan_gedung_triharjo/service/notification_count_server_custommer.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  final String typeAccount;
  const HeaderWidget({
    super.key,
    required this.typeAccount,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  void initState() {
    super.initState();
    log('type user = ${widget.typeAccount}');
    if (!_isTimerActive) {
      timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (widget.typeAccount == 'admin') {
          _fetchNotificationData();
        } else if (widget.typeAccount == 'customer') {
          _fetchNotificationCustommerData();
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer1.cancel();
  }

  late Timer timer1;
  bool _isTimerActive = false;

  Future<void> _fetchNotificationData() async {
    try {
      final data = await NotivicationCountService.fetchNotificationData();
      Provider.of<NotificationViewModel>(context, listen: false)
          .setNotificationData(data['token'], data['notReadYet']);
      log('${Provider.of<NotificationViewModel>(context).notReadYet}');
    } catch (error) {
      // Handle error, jika diperlukan
      print('Error fetching notification data: $error');
    }
  }

  Future<void> _fetchNotificationCustommerData() async {
    try {
      final data =
          await NotivicationCountServiceCustommer.fetchNotificationData();
      Provider.of<NotificationViewModel>(context, listen: false)
          .setNotificationData(data['token'], data['notReadYet']);
      log('${Provider.of<NotificationViewModel>(context).notReadYet}');
    } catch (error) {
      // Handle error, jika diperlukan
      print('Error fetching notification data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationModel = Provider.of<NotificationViewModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'GTR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(
                      typeAccount: widget.typeAccount,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  const SizedBox(
                    child: Icon(
                      Icons.notifications_active,
                      weight: 25,
                      color: Colors.white,
                    ),
                  ),
                  if (notificationModel.notReadYet > 0)
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.orange,
                        child: Text(
                          notificationModel.notReadYet.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomBar(indexPage: 2),
                    ));
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.person,
                  weight: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
