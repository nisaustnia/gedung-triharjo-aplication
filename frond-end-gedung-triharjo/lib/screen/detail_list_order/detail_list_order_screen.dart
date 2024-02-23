// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_list_order/detail_list_order_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:penyewaan_gedung_triharjo/service/delete_pemesanan.dart';
import 'package:provider/provider.dart';
import 'package:penyewaan_gedung_triharjo/service/admin_confirmation_order_service.dart';

class DetailListOrderScreen extends StatefulWidget {
  final String codeBooking;
  const DetailListOrderScreen({
    super.key,
    required this.codeBooking,
  });

  @override
  State<DetailListOrderScreen> createState() => _DetailListOrderScreenState();
}

class _DetailListOrderScreenState extends State<DetailListOrderScreen> {
  bool detailPemesanan = true;
  bool isLoading = false;
  late Future detailPemesananFuture;
  late List<String> dateList;

  List<String> generateDateList(dateMulai, jumHar) {
    List<String> dateList = [];
    DateTime currentDate = DateTime.parse("$dateMulai");

    for (int i = 0; i < jumHar; i++) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      dateList.add(formattedDate);

      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dateList;
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

  @override
  void initState() {
    super.initState();
    final detailViewModel =
        Provider.of<DetailListOrderViewModel>(context, listen: false);
    detailPemesananFuture =
        detailViewModel.getPemesananDetail(codeBooking: widget.codeBooking);
  }

  String tanggalBooking(value) {
    DateTime dateTime = DateTime.parse(value);
    dateTime = dateTime.toLocal();
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Pemesanan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3E70F2),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<DetailListOrderViewModel>(builder: (context, provider, _) {
        return FutureBuilder(
            future: detailPemesananFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: ErrorWidgetScreen(onRefreshPressed: () {
                    provider.getPemesananDetail(
                        codeBooking: widget.codeBooking);
                  }),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                dateList = generateDateList(provider.detailPemesanan!.dateMulai,
                    provider.detailPemesanan!.jumlahHari);
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(100)),
                                padding: const EdgeInsets.all(25),
                                child: Image.asset(
                                  'assets/icon/bottom_bar/user_white.png',
                                  fit: BoxFit.fill,
                                  height: 35,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.detailPemesanan!.nama,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('ID : ${widget.codeBooking}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: provider.detailPemesanan!.status ==
                                              "success"
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      provider.detailPemesanan!.status ==
                                              "success"
                                          ? 'Sudah Lunas'
                                          : 'Belum Dibayar',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              detailPemesanan = !detailPemesanan;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 0),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Detail Pemesanan',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 40,
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: detailPemesanan,
                                        child: Column(
                                          children: [
                                            const Divider(
                                              thickness: 1,
                                              height: 1,
                                              color: Color(0xFFA9A9A9),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: Center(
                                                child: Text(
                                                  formatLine(provider
                                                      .detailPemesanan!.event),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'No KTP',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  provider
                                                      .detailPemesanan!.noKTP,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Nama',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(provider
                                                    .detailPemesanan!.nama),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Email',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(provider
                                                    .detailPemesanan!.email),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'No Whatsapp',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(provider
                                                    .detailPemesanan!.noTelp),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              height: 1,
                                              color: Color(0xFFA9A9A9),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Tanggal Booking',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ListView.builder(
                                              itemCount: dateList.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          dateList[index],
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Icon(
                                                            Icons.date_range),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            Visibility(
                                              visible: provider.detailPemesanan!
                                                          .time ==
                                                      "00:01:00" &&
                                                  provider.detailPemesanan!
                                                          .event ==
                                                      "line badminton",
                                              child: const SizedBox(
                                                height: 10,
                                              ),
                                            ),
                                            Visibility(
                                              visible: provider.detailPemesanan!
                                                          .time ==
                                                      "00:01:00" &&
                                                  provider.detailPemesanan!
                                                          .event ==
                                                      "line badminton",
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Type"),
                                                  Text("Bulanan"),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: provider
                                                      .detailPemesanan!.time !=
                                                  "00:01:00",
                                              child: const SizedBox(
                                                height: 10,
                                              ),
                                            ),
                                            Visibility(
                                              visible: provider
                                                      .detailPemesanan!.time !=
                                                  "00:01:00",
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Sesi',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          provider
                                                              .detailPemesanan!
                                                              .time,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Icon(
                                                            Icons.date_range),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: detailPemesanan,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF3E70F2),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Alamat',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          provider.detailPemesanan!.alamat,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible:
                              provider.detailPemesanan!.status != "success",
                          child: FractionallySizedBox(
                            widthFactor: 1.0,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor: const Color(0xFF3972C8),
                                      title: const Text(
                                        'Konfirmasi Pemesanan',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      content: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          children: <TextSpan>[
                                            const TextSpan(
                                              text:
                                                  'Apakah Anda yakin ingin konformasi pesanan : \n \n',
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Booking Code : ${provider.detailPemesanan!.bookingCode} \n',
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Event : ${provider.detailPemesanan!.event}',
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Total Pembayaran : ${provider.detailPemesanan!.totalPembayaran} \n \n',
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            const TextSpan(
                                              text:
                                                  'Anda tidak bisa hapus pesanan setelah konformasi',
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: isLoading
                                              ? null
                                              : () async {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  log('$isLoading');
                                                  try {
                                                    var res =
                                                        await AdminConfirmationService()
                                                            .confirmationPemesanan(
                                                      bookingCode: int.parse(
                                                          provider
                                                              .detailPemesanan!
                                                              .bookingCode),
                                                    );
                                                    if (res.containsKey(
                                                            "result") &&
                                                        res != null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Berhasil Konfirmasi Pemesanan ${provider.detailPemesanan!.bookingCode}"),
                                                        ),
                                                      );

                                                      Navigator.pop(context);

                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    } else if (res
                                                        .containsKey("error")) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "${res["error"]}"),
                                                        ),
                                                      );
                                                      Navigator.pop(context);

                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    }
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text("$e"),
                                                      ),
                                                    );

                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                                },
                                          child: isLoading
                                              ? const Text(
                                                  'Loading',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : const Text(
                                                  'Ya',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Tidak',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[100],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Konfirmasi Pembayaran'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible:
                              provider.detailPemesanan!.status != "success",
                          child: FractionallySizedBox(
                            widthFactor: 1.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  var res = await Provider.of<
                                              DetailListOrderViewModel>(context,
                                          listen: false)
                                      .getPemesananDetail(
                                          codeBooking: widget.codeBooking);
                                  if (Provider.of<DetailListOrderViewModel>(
                                              context,
                                              listen: false)
                                          .detailPemesanan!
                                          .status ==
                                      "pending") {
                                    try {
                                      var res2 =
                                          await DeleteService().deletePemesanan(
                                        bookingCode:
                                            int.parse(widget.codeBooking),
                                      );
                                      if (res2.containsKey("result") &&
                                          res2 != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Berhasil hapus data Pemesanan"),
                                          ),
                                        );

                                        Navigator.pop(context);

                                        setState(() {
                                          isLoading = false;
                                        });
                                      } else if (res.containsKey("error")) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("${res["error"]}"),
                                          ),
                                        );
                                        Navigator.pop(context);

                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("$e"),
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Pembayaran sudah berhasil dilakukan, tidak bisa dihapus"),
                                      ),
                                    );
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              child: isLoading == true
                                  ? const CircularProgressIndicator()
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text('Hapus Pemesanan'),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: ErrorWidgetScreen(onRefreshPressed: () {
                    provider.getPemesananDetail(
                        codeBooking: widget.codeBooking);
                  }),
                );
              }
            });
      }),
    );
  }
}
