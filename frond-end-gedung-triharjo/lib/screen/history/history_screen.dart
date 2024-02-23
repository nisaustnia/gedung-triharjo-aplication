// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_pemesanan_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_pemesanan_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/history/history_view_model.dart';
import 'package:penyewaan_gedung_triharjo/service/delete_pemesanan.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoading = false;

  bool _isFiltring = false;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<HistoryViewModel>(context, listen: false).streamHistoryData();
  }

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'History Order',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF3E70F2),
        ),
        body: Consumer<HistoryViewModel>(builder: (context, provider, _) {
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
                        Provider.of<HistoryViewModel>(context, listen: false)
                            .streamHistoryData();
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
                          Provider.of<HistoryViewModel>(context, listen: false)
                              .cancelTimer();
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              _isLoading = false;
                            });
                            if (_searchController.text.isEmpty) {
                              setState(() {
                                _isFiltring = false;
                              });
                              Provider.of<HistoryViewModel>(context,
                                      listen: false)
                                  .streamHistoryData();
                            }
                            Provider.of<HistoryViewModel>(context,
                                    listen: false)
                                .filterHistoryData(_searchController.text);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: Provider.of<HistoryViewModel>(context, listen: false)
                      .historyStream,
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
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: historyData.length,
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
                                                  'assets/icon/history/purchase.png',
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
                                                      const Color(0xFF3E70F2),
                                                  elevation: 0,
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CheckingPemesanan(
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
                                                    Provider.of<HistoryViewModel>(
                                                            context,
                                                            listen: false)
                                                        .streamHistoryData();
                                                  }
                                                },
                                                child:
                                                    const Text('Lihat Detail'),
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
                                                                                await DeleteService().deletePemesanan(
                                                                              bookingCode: int.parse(detailHistory.bookingCode),
                                                                            );
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
                                                    'Cancel',
                                                    style: TextStyle(
                                                      color: Color(0xFFCE1818),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
