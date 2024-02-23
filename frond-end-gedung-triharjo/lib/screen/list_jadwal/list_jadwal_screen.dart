import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:penyewaan_gedung_triharjo/service/jadwal_service.dart';

class ListJadwalScreen extends StatefulWidget {
  final String title;
  const ListJadwalScreen({
    super.key,
    required this.title,
  });

  @override
  State<ListJadwalScreen> createState() => _ListJadwalScreenState();
}

class _ListJadwalScreenState extends State<ListJadwalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F6),
      appBar: AppBar(
        title: const Text('Tanggal Order'),
      ),
      body: FutureBuilder(
        future: widget.title == 'Aula Balai Kelurahan'
            ? JadwalService.fetchListJadwalData(index: 8)
            : JadwalService.fetchListJadwalData(index: 9),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return ErrorWidgetScreen(onRefreshPressed: () {
              widget.title == 'Aula Balai Kelurahan'
                  ? JadwalService.fetchListJadwalData(index: 8)
                  : JadwalService.fetchListJadwalData(index: 9);
            });
          } else {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text('Belum ada pemesanan'),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
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
                            Text(
                              widget.title == 'Aula Balai Kelurahan'
                                  ? 'Aula'
                                  : 'Lapangan',
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
    );
  }
}
