import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_jadwal/list_jadwal2_view_model.dart';
import 'package:penyewaan_gedung_triharjo/service/jadwal_service.dart';
import 'package:provider/provider.dart';

class ListJadwal2Screen extends StatefulWidget {
  const ListJadwal2Screen({
    super.key,
  });

  @override
  State<ListJadwal2Screen> createState() => _ListJadwal2ScreenState();
}

class _ListJadwal2ScreenState extends State<ListJadwal2Screen> {
  late Future<void> sesiDataViewModel;
  late Future<void> sesiGedungDataViewModel;
  late Future<void> bulananDataViewModel;
  @override
  void initState() {
    super.initState();
    final jadwalViewModel =
        Provider.of<ListJadwal2ViewModel>(context, listen: false);
    sesiDataViewModel = jadwalViewModel.getAllSesi(idIndex: 6);
    sesiGedungDataViewModel = jadwalViewModel.getAllSesiGedung(idIndex: 7);
    bulananDataViewModel = jadwalViewModel.getAllBulananGedung();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F6),
      appBar: AppBar(
        title: const Text('Tanggal Gedung Order'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tipe Gedung',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: JadwalService.fetchListJadwalData(index: 1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return ErrorWidgetScreen(onRefreshPressed: () {
                  JadwalService.fetchListJadwalData(index: 1);
                });
              } else {
                return snapshot.data!.isEmpty
                    ? const Center(
                        child: Text('Belum ada pemesanan'),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                left: BorderSide(
                                  color: Colors.blue,
                                  width: 5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Gedung',
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 1,
                                  height: 20,
                                  color: const Color(0xFFA9A9A9),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text("${snapshot.data![index]}"),
                              ],
                            ),
                          );
                        },
                      );
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tipe Berlangganan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFA9A9A9),
                ),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        Icons.sports_score,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Line Badminton Sesi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFA9A9A9),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFA9A9A9),
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<ListJadwal2ViewModel>(
                  builder: (context, provider, _) {
                    return FutureBuilder(
                      future: sesiDataViewModel,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return ErrorWidgetScreen(onRefreshPressed: () {
                            provider.getAllSesi(idIndex: 6);
                          });
                        } else {
                          return ListView.builder(
                              itemCount: provider.allSesi.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  margin: index + 1 == provider.allSesi.length
                                      ? const EdgeInsets.all(0)
                                      : provider.allSesi.length == 1
                                          ? const EdgeInsets.all(0)
                                          : const EdgeInsets.only(bottom: 10),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      left: BorderSide(
                                        color: Colors.blue,
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Tanggal'),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                              provider.allSesi[index]!.tanggal),
                                        ],
                                      ),
                                      const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 5, 0, 5),
                                            child: Text('Sesi'),
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                        itemCount: provider
                                            .allSesi[index]!.time.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index2) {
                                          return Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: index2 + 1 ==
                                                    provider.allSesi[index]!
                                                        .time.length
                                                ? const EdgeInsets.all(0)
                                                : provider.allSesi[index]!.time
                                                            .length ==
                                                        1
                                                    ? const EdgeInsets.all(0)
                                                    : const EdgeInsets.only(
                                                        bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              provider
                                                  .allSesi[index]!.time[index2],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFA9A9A9),
                ),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.orange,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        Icons.location_city,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Unit Gedung Sesi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFA9A9A9),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFA9A9A9),
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<ListJadwal2ViewModel>(
                  builder: (context, provider, _) {
                    return FutureBuilder(
                      future: sesiGedungDataViewModel,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return ErrorWidgetScreen(onRefreshPressed: () {
                            provider.getAllSesiGedung(idIndex: 7);
                          });
                        } else {
                          return ListView.builder(
                            itemCount: provider.allSesiGedung.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                margin:
                                    index + 1 == provider.allSesiGedung.length
                                        ? const EdgeInsets.all(0)
                                        : provider.allSesiGedung.length == 1
                                            ? const EdgeInsets.all(0)
                                            : const EdgeInsets.only(bottom: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    left: BorderSide(
                                      color: Colors.blue,
                                      width: 5,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Tanggal'),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text(provider
                                            .allSesiGedung[index]!.tanggal),
                                      ],
                                    ),
                                    const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Text('Sesi'),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                      itemCount: provider
                                          .allSesiGedung[index]!.time.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index2) {
                                        return Container(
                                          padding: const EdgeInsets.all(5),
                                          margin: index2 + 1 ==
                                                  provider.allSesiGedung[index]!
                                                      .time.length
                                              ? const EdgeInsets.all(0)
                                              : provider.allSesiGedung[index]!
                                                          .time.length ==
                                                      1
                                                  ? const EdgeInsets.all(0)
                                                  : const EdgeInsets.only(
                                                      bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            provider.allSesiGedung[index]!
                                                .time[index2],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFA9A9A9),
                ),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.deepOrange,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        Icons.sports_score,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Line Badminton Bulanan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFA9A9A9),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFA9A9A9),
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<ListJadwal2ViewModel>(
                  builder: (context, provider, _) {
                    return FutureBuilder(
                      future: bulananDataViewModel,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return ErrorWidgetScreen(onRefreshPressed: () {
                            provider.getAllBulananGedung();
                          });
                        } else {
                          return ListView.builder(
                            itemCount: provider.allBulananGedung.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                margin: index + 1 ==
                                        provider.allBulananGedung.length
                                    ? const EdgeInsets.all(0)
                                    : provider.allBulananGedung.length == 1
                                        ? const EdgeInsets.all(0)
                                        : const EdgeInsets.only(bottom: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    left: BorderSide(
                                      color: Colors.blue,
                                      width: 5,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Mulai'),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(provider.allBulananGedung[index]!
                                            .dateMulai),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Akhir'),
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        Text(provider.allBulananGedung[index]!
                                            .dateAkhir),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Jumlah'),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        Text(provider.allBulananGedung[index]!
                                            .jumlahHari),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Type'),
                                        const SizedBox(
                                          width: 35,
                                        ),
                                        Text(provider
                                            .allBulananGedung[index]!.type),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
