// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_pemesanan_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_list_order/detail_list_order_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_order/list_order_view_model.dart';
import 'package:penyewaan_gedung_triharjo/service/admin_confirmation_order_service.dart';
import 'package:penyewaan_gedung_triharjo/service/admin_delete_pesanan.dart';
import 'package:provider/provider.dart';

class ListOrderScreen extends StatefulWidget {
  const ListOrderScreen({super.key});

  @override
  State<ListOrderScreen> createState() => _ListOrderScreenState();
}

class _ListOrderScreenState extends State<ListOrderScreen> {
  bool _isLoading = false;

  bool _isFiltring = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ListOrderViewModel>(context, listen: false).streamHistoryData();
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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'List Order',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF3E70F2),
        ),
        body: Consumer<ListOrderViewModel>(builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _isLoading = false;
                          _isFiltring = false;
                        });
                        provider.streamHistoryData();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari Berdasarkan ID...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(15, 1, 1, 1),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          setState(() {
                            _isLoading = true;
                            _isFiltring = true;
                          });
                          provider.cancelTimer();
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              _isLoading = false;
                            });
                            if (_searchController.text.isEmpty) {
                              setState(() {
                                _isFiltring = false;
                              });
                              provider.streamHistoryData();
                            }
                            provider.filterHistoryData(_searchController.text);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: provider.historyStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: ErrorWidgetScreen(onRefreshPressed: () {
                          provider.historyStream;
                        }),
                      );
                    } else {
                      List<DetailPemesananModel> historyData =
                          snapshot.data ?? [];
                      if (historyData.isEmpty) {
                        return const Center(
                          child: Text('Belum ada Pemesanan'),
                        );
                      } else {
                        return _isLoading == true
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: historyData.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var detailHistory = historyData[index];
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(
                                        16,
                                        16,
                                        16,
                                        index == historyData.length - 1
                                            ? 16
                                            : 0),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 0),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  'assets/icon/bottom_bar/user.png',
                                                  fit: BoxFit.fill,
                                                  height: 50,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      formatLine(
                                                          detailHistory.event),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        'ID : ${detailHistory.bookingCode}')
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                color: detailHistory.status ==
                                                        "success"
                                                    ? Colors.green
                                                    : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Text(
                                                detailHistory.status ==
                                                        "success"
                                                    ? 'Lunas'
                                                    : 'Belum',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: const BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailListOrderScreen(
                                                              codeBooking:
                                                                  detailHistory
                                                                      .bookingCode),
                                                    ),
                                                  );
                                                  _searchController.clear();
                                                  if (_isFiltring == true) {
                                                    setState(() {
                                                      _isLoading = false;
                                                      _isFiltring = false;
                                                    });
                                                    provider
                                                        .streamHistoryData();
                                                  }
                                                },
                                                child: const Text(
                                                  'Lihat Detail',
                                                  style: TextStyle(
                                                      color: Color(0xFF3E70F2)),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: detailHistory.status !=
                                                      "success" &&
                                                  _isFiltring == false,
                                              child: const SizedBox(
                                                width: 15,
                                              ),
                                            ),
                                            Visibility(
                                              visible: detailHistory.status !=
                                                      "success" &&
                                                  _isFiltring == false,
                                              child: Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                    side: const BorderSide(
                                                      color: Color(0xFFCE1818),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          title: const Text(
                                                            'Konfirmasi Hapus',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          content: const Text(
                                                              'Data tidak akan bisa dikembalikan. Apakah Anda yakin ingin menghapus?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed:
                                                                  isLoading
                                                                      ? null
                                                                      : () async {
                                                                          setState(
                                                                              () {
                                                                            isLoading =
                                                                                true;
                                                                          });
                                                                          log('${isLoading}');
                                                                          try {
                                                                            var res =
                                                                                await AdminDeleteService().deletePemesanan(bookingCode: int.parse(detailHistory.bookingCode));
                                                                            if (res.containsKey("result") &&
                                                                                res != null) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                const SnackBar(
                                                                                  content: Text("Berhasil hapus data Pemesanan"),
                                                                                ),
                                                                              );

                                                                              Navigator.pop(context);

                                                                              setState(() {
                                                                                isLoading = false;
                                                                              });
                                                                            } else if (res.containsKey("error")) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
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
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text("${e}"),
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
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    )
                                                                  : const Text(
                                                                      'Ya',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                'Tidak',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Hapus Pesanan',
                                                    style: TextStyle(
                                                      color: Color(0xFFCE1818),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible: detailHistory.status !=
                                                  "success" &&
                                              _isFiltring == false,
                                          child: const SizedBox(
                                            height: 5,
                                          ),
                                        ),
                                        Visibility(
                                          visible: detailHistory.status !=
                                                  "success" &&
                                              _isFiltring == false,
                                          child: FractionallySizedBox(
                                            widthFactor: 1.0,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF3972C8),
                                                      title: const Text(
                                                        'Konfirmasi Pemesanan',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      content: RichText(
                                                        text: TextSpan(
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          children: <TextSpan>[
                                                            const TextSpan(
                                                              text:
                                                                  'Apakah Anda yakin ingin konformasi pesanan : \n \n',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.0),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  'Booking Code : ${detailHistory.bookingCode} \n',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16.0),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  'Event : ${detailHistory.event}',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16.0),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  'Total Pembayaran : ${detailHistory.totalPembayaran} \n \n',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16.0),
                                                            ),
                                                            const TextSpan(
                                                              text:
                                                                  'Anda tidak bisa hapus pesanan setelah konformasi',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.0),
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
                                                                    isLoading =
                                                                        true;
                                                                  });
                                                                  log('${isLoading}');
                                                                  try {
                                                                    var res =
                                                                        await AdminConfirmationService()
                                                                            .confirmationPemesanan(
                                                                      bookingCode:
                                                                          int.parse(
                                                                              detailHistory.bookingCode),
                                                                    );
                                                                    if (res.containsKey(
                                                                            "result") &&
                                                                        res !=
                                                                            null) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text("Berhasil Konfirmasi Pemesanan ${detailHistory.bookingCode}"),
                                                                        ),
                                                                      );

                                                                      Navigator.pop(
                                                                          context);

                                                                      setState(
                                                                          () {
                                                                        isLoading =
                                                                            false;
                                                                      });
                                                                    } else if (res
                                                                        .containsKey(
                                                                            "error")) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text("${res["error"]}"),
                                                                        ),
                                                                      );
                                                                      Navigator.pop(
                                                                          context);

                                                                      setState(
                                                                          () {
                                                                        isLoading =
                                                                            false;
                                                                      });
                                                                    }
                                                                  } catch (e) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text("${e}"),
                                                                      ),
                                                                    );

                                                                    setState(
                                                                        () {
                                                                      isLoading =
                                                                          false;
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                          child: isLoading
                                                              ? const Text(
                                                                  'Loading',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                )
                                                              : const Text(
                                                                  'Ya',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Tidak',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .red[100],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Text(
                                                  'Konfirmasi Pembayaran'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                      }
                    }
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
