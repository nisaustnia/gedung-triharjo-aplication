// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_model_notification.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_pemesanan_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/notification_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_list_order/detail_list_order_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_order/list_order_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/notification/notification_view_model.dart';
import 'package:penyewaan_gedung_triharjo/service/notification_admin_read_service.dart';
import 'package:penyewaan_gedung_triharjo/service/notification_count_server.dart';
import 'package:penyewaan_gedung_triharjo/service/notification_count_server_custommer.dart';
import 'package:penyewaan_gedung_triharjo/service/notification_read_service.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  final String typeAccount;
  const NotificationScreen({super.key, required this.typeAccount});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Timer timer2;
  bool _isTimerActive2 = false;

  Future<void> _fetchNotificationData() async {
    try {
      final data = await NotivicationCountService.fetchNotificationData();
      Provider.of<NotificationViewModel>(context, listen: false)
          .setNotificationData(data['token'], data['notReadYet']);
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
    } catch (error) {
      // Handle error, jika diperlukan
      print('Error fetching notification data: $error');
    }
  }

  String formatLine(String input) {
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(' ');
  }

  String tanggalDate(DateTime tanggal) {
    DateTime originalDate = tanggal;
    String formattedDate =
        "${originalDate.day.toString().padLeft(2, '0')} ${_getMonthName(originalDate.month)} ${originalDate.year} - ${originalDate.hour.toString().padLeft(2, '0')}:${originalDate.minute.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  String _getMonthName(int month) {
    List<String> monthNames = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];

    return monthNames[month - 1];
  }

  late Timer timer1;
  bool _isTimerActive = false;
  @override
  void initState() {
    super.initState();

    if (!_isTimerActive) {
      timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (widget.typeAccount == 'admin') {
          Provider.of<NotificationListViewModel>(context, listen: false)
              .getNotificationAdminData();
        } else if (widget.typeAccount == 'customer') {
          Provider.of<NotificationListViewModel>(context, listen: false)
              .getNotificationData();
        }
      });
    }

    if (!_isTimerActive2) {
      timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    super.dispose();
    timer1.cancel();
    timer2.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final notificationModel = Provider.of<NotificationViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF3E70F2),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Stack(
            children: [
              const Icon(Icons.notifications),
              if (notificationModel.notReadYet > 0)
                Positioned(
                  top: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.orange,
                    child: Text(
                      notificationModel.notReadYet.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body:
          Consumer<NotificationListViewModel>(builder: (context, provider, _) {
        return StreamBuilder(
            stream: provider.notificationStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: ErrorWidgetScreen(onRefreshPressed: () {
                    provider.notificationStream;
                  }),
                );
              } else {
                List<NotificationModel> notificationData = snapshot.data ?? [];
                if (notificationData.isEmpty) {
                  return const Center(
                    child: Text('Belum Ada Notifikasi'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: notificationData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      int reversedIndex = notificationData.length - index - 1;
                      return InkWell(
                        onTap: () async {
                          if (widget.typeAccount == 'admin') {
                            try {
                              var res = await NotivicationAdminReadService
                                  .fetchNotificationReadData(
                                      idNotif: notificationData[reversedIndex]
                                          .idNotif);
                              if (res.containsKey('result')) {
                                log('Berhasil');
                              } else {
                                log('Gagal');
                              }
                            } catch (e) {
                              log("$e");
                            }
                          } else if (widget.typeAccount == 'customer') {
                            try {
                              var res = await NotivicationReadService
                                  .fetchNotificationReadData(
                                      idNotif: notificationData[reversedIndex]
                                          .idNotif);
                              if (res.containsKey('result')) {
                                log('Berhasil');
                              } else {
                                log('Gagal');
                              }
                            } catch (e) {
                              log("$e");
                            }
                          }
                          if (widget.typeAccount == 'admin') {
                            if (!notificationData[reversedIndex]
                                .notif
                                .toLowerCase()
                                .contains("cancel")) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailListOrderScreen(
                                      codeBooking:
                                          notificationData[reversedIndex]
                                              .bookingCode),
                                ),
                              );
                            }
                          } else if (widget.typeAccount == 'customer') {
                            if (!notificationData[reversedIndex]
                                .notif
                                .toLowerCase()
                                .contains("cancel")) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckingPemesanan(
                                      codeBooking:
                                          notificationData[reversedIndex]
                                              .bookingCode),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: notificationData[reversedIndex].isRead == 0
                                ? Colors.black12
                                : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          tanggalDate(
                                              notificationData[reversedIndex]
                                                  .createdAt),
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          notificationData[reversedIndex]
                                                      .isRead ==
                                                  0
                                              ? Icons.mark_chat_unread
                                              : Icons.mark_chat_read,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Flexible(
                                          child: Text(
                                            formatLine(
                                                notificationData[reversedIndex]
                                                    .notif),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                thickness: 1,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            });
      }),
    );
  }
}
