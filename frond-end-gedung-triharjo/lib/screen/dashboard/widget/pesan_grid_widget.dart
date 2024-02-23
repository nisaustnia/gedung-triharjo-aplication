import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/list_event_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pemesanan/detail_pesan_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:provider/provider.dart';

class PesanGridWidget extends StatefulWidget {
  const PesanGridWidget({super.key});

  @override
  State<PesanGridWidget> createState() => _PesanGridWidgetState();
}

class _PesanGridWidgetState extends State<PesanGridWidget> {
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
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: carouselList['carousel'].length,
              itemBuilder: (BuildContext context, int index) {
                final carouselItem = carouselList['carousel'][index];
                return GridItem(
                  title: carouselItem['title'],
                  image: carouselItem['image'],
                  syarat: carouselItem['syarat'],
                );
              },
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
    });
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final String image;
  final List syarat;

  const GridItem({
    super.key,
    required this.title,
    required this.image,
    required this.syarat,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPemesananScreen(
                title: title, imageAssets: image, listSyarat: syarat),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 80.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
                        builder: (context) => DetailPemesananScreen(
                            title: title,
                            imageAssets: image,
                            listSyarat: syarat),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      backgroundColor: Colors.black),
                  child: const Text(
                    'Pesan Sekarang',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
