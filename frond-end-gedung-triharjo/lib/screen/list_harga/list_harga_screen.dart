import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/list_event_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pemesanan/detail_pesan_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:provider/provider.dart';

class ListHargaScreen extends StatefulWidget {
  const ListHargaScreen({super.key});

  @override
  State<ListHargaScreen> createState() => _ListHargaScreenState();
}

class _ListHargaScreenState extends State<ListHargaScreen> {
  late Future<void> eventDataViewModel;
  @override
  void initState() {
    super.initState();
    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    eventDataViewModel = eventViewModel.getEventData();
  }

  void navigationToGedung() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DetailPemesananScreen(
          title: 'Lapangan Olahraga',
          imageAssets: 'assets/image/dashboard/lapangan.png',
          listSyarat: [
            {
              'listSyarat':
                  'Penggunaan hari kedua dan seterusnya dipungut sebesar 50% pungutan awal',
            },
            {
              'listSyarat':
                  'Kegiatan yang dihadiri 200 orang lebih wajib menambah layanan kebersihan dan keamanan/parkir',
            },
          ],
        ),
      ),
    );
  }

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return currencyFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Harga Penyewaan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF3E70F2),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<EventViewModel>(
        builder: (context, provider, _) {
          return FutureBuilder(
            future: eventDataViewModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: ErrorWidgetScreen(
                    onRefreshPressed: () {
                      provider.getEventData();
                    },
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 95),
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3E70F2),
                          ),
                          child: const Column(
                            children: [
                              SizedBox(
                                height: 85,
                              ),
                              Text(
                                'Dengan lokasi strategis di pusat kota, Gedung Triharjo menawarkan fasilitas eksklusif untuk berbagai acara, mulai dari pernikahan, acara bisnis, hingga perayaan pribadi.',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    "assets/image/dashboard/dashboard1.png",
                                    fit: BoxFit.cover,
                                    height: 150,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(15),
                                height: 150,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Selamat datang di Aplikasi Gedung Triharjo",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Text(
                        'Paket Penyewaan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/image/dashboard/aula.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Balai Aula Kelurahan',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Organisasi',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          formatCurrency(provider
                                              .eventData[7].organisasi
                                              .toDouble()),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Perorangan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          formatCurrency(provider
                                              .eventData[7].perorangan
                                              .toDouble()),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailPemesananScreen(
                                          title: 'Aula Balai Kelurahan',
                                          imageAssets:
                                              'assets/image/dashboard/aula.png',
                                          listSyarat: [
                                            {
                                              'listSyarat':
                                                  'Sudah termasuk kursi 100 buah, meja 4 buah, 1 unit sound system',
                                            },
                                            {
                                              'listSyarat':
                                                  'Penggunaan hari kedua dipungut sebesar 50% pungutan awal, hari ketiga dan seterusnya dipungut sebesar 25% dari pungutan awal',
                                            },
                                            {
                                              'listSyarat':
                                                  'Kegiatan yang dihadiri 50 orang lebih wajib menambah layanan kebersihan',
                                            },
                                            {
                                              'listSyarat':
                                                  'Kegiatan yang dihadiri 100 orang lebih wajib menambah layanan kebersihan dan keamanan/parkir',
                                            },
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Icon(Icons.chevron_right),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image:
                              AssetImage('assets/image/dashboard/lapangan.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Lapangan Olahraga',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Organisasi',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          formatCurrency(provider
                                              .eventData[8].perorangan
                                              .toDouble()),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailPemesananScreen(
                                          title: 'Gedung Olahraga',
                                          imageAssets:
                                              'assets/image/dashboard/gedung.png',
                                          listSyarat: [
                                            {
                                              'listSyarat':
                                                  ' Berlangganan Maksimal 10 sesi dalam 1 bulan',
                                            },
                                            {
                                              'listSyarat':
                                                  'Waktu 1 sesi adalah 2 jam',
                                            },
                                            {
                                              'listSyarat':
                                                  '1 unit gedung maksimal penggunaan 60 sesi setiap pengguna (apabila masih ada sesi kosong, pengguna dapat melibihi batasan sesi)',
                                            },
                                            {
                                              'listSyarat':
                                                  'Kegiatan yang dihadiri 25 orang lebih wajib menambah layanan kebersihan',
                                            },
                                            {
                                              'listSyarat':
                                                  'Kegiatan yang dihadiri 100 orang lebih wajib menambah layanan kebersihan dan keamanan/parkir',
                                            },
                                            {
                                              'listSyarat':
                                                  '	Penggunaan hari kedua dipungut 50% dari pungutan awal, Pungutan hari ketiga dan seterusnya dipungut sebesar 25% pungutan awal',
                                            },
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Icon(Icons.chevron_right),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Color(0xFF3E70F2)),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Berlangganan',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    navigationToGedung();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Line Badminton Sesi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${formatCurrency(provider.eventData[5].organisasi.toDouble())} / Sesi',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    navigationToGedung();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Line Badminton Bulanan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${formatCurrency(provider.eventData[4].perorangan.toDouble())} / Bulan',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    navigationToGedung();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Unit Gedung Sesi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${formatCurrency(provider.eventData[6].organisasi.toDouble())} / Organisasi Sesi',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    navigationToGedung();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Unit Gedung Sesi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${formatCurrency(provider.eventData[6].perorangan.toDouble())} / Perorangan Sesi',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Color(0xFF3E70F2)),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Gedung',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    navigationToGedung();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Hajatan / Pernikahan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatCurrency(provider
                                                  .eventData[0].perorangan
                                                  .toDouble()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              'Perorangan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatCurrency(provider
                                                  .eventData[0].organisasi
                                                  .toDouble()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              'Organisasi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    navigationToGedung();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Pameran / Expo',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatCurrency(provider
                                                  .eventData[1].perorangan
                                                  .toDouble()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              'Perorangan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatCurrency(provider
                                                  .eventData[1].organisasi
                                                  .toDouble()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              'Organisasi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    navigationToGedung();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Turnamen / Pertandingan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatCurrency(provider
                                                  .eventData[2].perorangan
                                                  .toDouble()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              'Perorangan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatCurrency(provider
                                                  .eventData[2].organisasi
                                                  .toDouble()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              'Organisasi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    navigationToGedung();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Rapat / Pertemuan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatCurrency(provider
                                                  .eventData[3].perorangan
                                                  .toDouble()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              'Perorangan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatCurrency(provider
                                                  .eventData[3].organisasi
                                                  .toDouble()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            const Text(
                                              'Organisasi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: ErrorWidgetScreen(
                    onRefreshPressed: () {
                      provider.getEventData();
                    },
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
