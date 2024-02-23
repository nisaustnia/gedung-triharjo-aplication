import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/list_event_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pemesanan/detail_pesan_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:provider/provider.dart';

class PesanCarauselWidget extends StatefulWidget {
  const PesanCarauselWidget({super.key});

  @override
  State<PesanCarauselWidget> createState() => _PesanCarauselWidgetState();
}

class _PesanCarauselWidgetState extends State<PesanCarauselWidget> {
  late Future<void> eventDataViewModel;
  @override
  void initState() {
    super.initState();
    super.initState();
    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    eventDataViewModel = eventViewModel.getEventData();
  }

  Map<String, dynamic> carouselList = {
    'carousel': [
      {
        'title': 'Aula Balai Kelurahan',
        'image': 'assets/image/dashboard/aula.png',
        'syarat': [
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
        ]
      },
      {
        'title': 'Gedung Olahraga',
        'image': 'assets/image/dashboard/gedung.png',
        'syarat': [
          {
            'listSyarat': ' Berlangganan Maksimal 10 sesi dalam 1 bulan',
          },
          {
            'listSyarat': 'Waktu 1 sesi adalah 2 jam',
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
        ]
      },
      {
        'title': 'Lapangan Olahraga',
        'image': 'assets/image/dashboard/lapangan.png',
        'syarat': [
          {
            'listSyarat':
                'Penggunaan hari kedua dan seterusnya dipungut sebesar 50% pungutan awal',
          },
          {
            'listSyarat':
                'Kegiatan yang dihadiri 200 orang lebih wajib menambah layanan kebersihan dan keamanan/parkir',
          },
        ]
      },
    ]
  };
  @override
  Widget build(BuildContext context) {
    var list = carouselList['carousel'];
    return Consumer<EventViewModel>(builder: (context, provider, _) {
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
              return SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: 16,
                        right: index == list?.length - 1 ? 16 : 0,
                        top: 5,
                        bottom: 5,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('${list?[index]['image']}'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      width: 190,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list?[index]['title'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FractionallySizedBox(
                            widthFactor: 1.0,
                            child: SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPemesananScreen(
                                          title: list?[index]['title'],
                                          imageAssets: list?[index]['image'],
                                          listSyarat: list?[index]['syarat'],
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Pesan Sekarang',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
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
          });
    });
  }
}
