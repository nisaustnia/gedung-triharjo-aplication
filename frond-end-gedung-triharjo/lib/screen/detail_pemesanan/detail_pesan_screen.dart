import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/list_event_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pemesanan/widget/form_pilihan_1_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pemesanan/widget/form_pilihan_2_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_harga/list_harga_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_jadwal/list_jadwal2_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_jadwal/list_jadwal_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';

class DetailPemesananScreen extends StatefulWidget {
  final String imageAssets;
  final String title;
  final List listSyarat;
  const DetailPemesananScreen({
    super.key,
    required this.imageAssets,
    required this.listSyarat,
    required this.title,
  });

  @override
  State<DetailPemesananScreen> createState() => _DetailPemesananScreenState();
}

class _DetailPemesananScreenState extends State<DetailPemesananScreen> {
  bool isVisible = false;

  //Bikin int jadi Currency
  String formatAmount(int amount) {
    final NumberFormat formatter = NumberFormat.decimalPattern('id');
    return formatter.format(amount);
  }

  late EventViewModel _eventViewModel;

  @override
  void initState() {
    super.initState();
    _eventViewModel = Provider.of<EventViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    _eventViewModel.gantiHargaAula(0);
    _eventViewModel.gantiHargaLapangan(0);
    _eventViewModel.gantiHargaGedung(0);
    _eventViewModel.gantiTipeSesi('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    widget.imageAssets,
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: Colors.black38,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Share.share(
                                    "'Dapatkan pengalaman yang tak terlupakan dengan menyewa gedung kami di Triharjo! Penawaran spesial menanti Anda. Segera pesan sekarang untuk merayakan momen istimewa Anda'");
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: Colors.black38,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 270,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFF0F2F6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        )),
                    height: 30,
                  ),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F2F6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ListHargaScreen()));
                          },
                          child: const Row(
                            children: [
                              Text(
                                "List Harga",
                                style: TextStyle(
                                  color: Color(0xFF3E70F2),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Color(0xFF3E70F2),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                          'Pemesanan seluruh Aula Balai Kelurahan gedung Triharjo. Jangka waktu pemesanan 1 hari.'),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
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
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Syarat dan Kententuan Pemesanan',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                ),
                              ],
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.listSyarat.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Visibility(
                                  visible: isVisible,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.arrow_right, size: 16),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(widget.listSyarat[index]
                                              ['listSyarat']),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<EventViewModel>(
                          builder: (context, eventViewModel, child) {
                            if (widget.title == 'Aula Balai Kelurahan') {
                              return eventViewModel.hargaAula != 0
                                  ? Text(
                                      'Rp ${formatAmount(eventViewModel.hargaAula)} / Hari',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : const Text('Pilih Tipe Dahulu');
                            } else if (widget.title == 'Lapangan Olahraga') {
                              return eventViewModel.hargaLapangan != 0
                                  ? Text(
                                      'Rp ${formatAmount(eventViewModel.hargaLapangan)} / Hari',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : const Text('Pilih Tipe Dahulu');
                            } else {
                              return eventViewModel.hargaGedungOlahraga != 0
                                  ? Text(
                                      'Rp ${formatAmount(eventViewModel.hargaGedungOlahraga)} ${eventViewModel.tipeSesi}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : const Text('Pilih Tipe Dahulu');
                            }
                          },
                        ),
                        const Text(
                          'Warga Triharjo',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        widget.title != 'Gedung Olahraga'
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListJadwalScreen(
                                    title: widget.title,
                                  ),
                                ),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ListJadwal2Screen(),
                                ),
                              );
                      },
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tanggal yang sudah dipesan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.date_range),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFA9A9A9),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    widget.title == 'Gedung Olahraga'
                        ? const FormPilihan2Widget()
                        : FormPilihan1Widget(
                            title: widget.title,
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
