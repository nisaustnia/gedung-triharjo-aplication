// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_view_model.dart';
import 'package:penyewaan_gedung_triharjo/service/delete_pemesanan.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPembayaranScreen extends StatefulWidget {
  final String vaNumber;
  final String expiryTime;
  final String bookingCode;
  final String totalPembayaran;
  final String event;
  final String noKTP;
  final String nama;
  final String email;
  final String noTelp;
  final String dateMulai;
  final String alamat;
  final String time;
  final int jumHar;
  final String tipePembayaran;
  const DetailPembayaranScreen({
    super.key,
    required this.vaNumber,
    required this.expiryTime,
    required this.bookingCode,
    required this.totalPembayaran,
    required this.event,
    required this.noKTP,
    required this.nama,
    required this.email,
    required this.noTelp,
    required this.dateMulai,
    required this.alamat,
    required this.time,
    required this.jumHar,
    required this.tipePembayaran,
  });

  @override
  State<DetailPembayaranScreen> createState() => _DetailPembayaranScreenState();
}

class _DetailPembayaranScreenState extends State<DetailPembayaranScreen> {
  bool isLoading = false;
  late DateTime expiredDateTime;
  late Duration countdownDuration;
  late String countdownText;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    expiredDateTime = DateTime.parse(widget.expiryTime);
    countdownDuration = expiredDateTime.difference(DateTime.now());
    countdownText = formatCountdown(countdownDuration);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTimer();
    });
    log(widget.dateMulai);
  }

  List<String> generateDateList() {
    List<String> dateList = [];
    DateTime currentDate = DateTime.parse(widget.dateMulai);

    for (int i = 0; i < widget.jumHar; i++) {
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

  String tanggalBooking(value) {
    DateTime dateTime = DateTime.parse(value);
    dateTime = dateTime.toLocal();
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdownDuration = countdownDuration - const Duration(seconds: 1);
      setState(() {
        countdownText = formatCountdown(countdownDuration);
      });
      if (countdownDuration.isNegative) {
        timer.cancel();
        Navigator.pop(context);
      }
    });
  }

  String formatCountdown(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatAmount(int amount) {
    final NumberFormat formatter = NumberFormat.decimalPattern('id');
    return formatter.format(amount);
  }

  bool detailPemesanan = true;
  @override
  Widget build(BuildContext context) {
    List<String> dateList = generateDateList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pembayaran"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF3E70F2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.timer_sharp,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Menunggu Pembayaran $countdownText",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: widget.tipePembayaran == 'bri'
                          ? const Color(0xFF00529C)
                          : widget.tipePembayaran == 'bca'
                              ? Colors.blue
                              : Colors.orange,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 16),
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Image.asset(
                          widget.tipePembayaran == 'bri'
                              ? 'assets/icon/detail_pemesanan/BRI.png'
                              : widget.tipePembayaran == 'bca'
                                  ? 'assets/icon/detail_pemesanan/BCA.png'
                                  : 'assets/icon/detail_pemesanan/BNI.png',
                        ),
                      ),
                      const Text(
                        "Virtual Account Number",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.vaNumber,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  100.0,
                                ),
                              ),
                              side: const BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.vaNumber));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Virtual Account Number telah disalin'),
                                ),
                              );
                            },
                            child: const Text("Salin"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Jumlah Transfer",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Rp ${formatAmount(int.parse(widget.totalPembayaran))},-",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2BA34C)),
                    onPressed: () {
                      String message = '''
Saya ingin konfirmasi pesanan saya dengan data berikut:

Nama = ${widget.nama},
Email = ${widget.email},
Code Booking = ${widget.bookingCode},
No Whatsapp = ${widget.noTelp},
Tanggal Booking = ${widget.dateMulai},
Tipe Pembayaran = bri,

Terima kasih...''';

                      String whatsappLink =
                          'https://wa.me/+6283836455945?text=${Uri.encodeFull(message)}';
                      launchUrl(Uri.parse(whatsappLink));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icon/detail_pemesanan/whatsapp.png',
                          width: 20,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text('Konfirmasi Whatsapp'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
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
                          padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Detail Pemesanan',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Center(
                                        child: Text(
                                          formatLine(widget.event),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'No KTP',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          widget.noKTP,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Nama',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.nama),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Email',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.email),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'No Whatsapp',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(widget.noTelp),
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
                                          MainAxisAlignment.spaceBetween,
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
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Icon(Icons.date_range),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    Visibility(
                                      visible: widget.time == '' &&
                                          widget.event == "line badminton",
                                      child: const SizedBox(
                                        height: 10,
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.time == '' &&
                                          widget.event == "line badminton",
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Type"),
                                          Text("Bulanan"),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.time != '',
                                      child: const SizedBox(
                                        height: 10,
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.time != '',
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Sesi',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  widget.time,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Icon(Icons.date_range),
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
                                  widget.alamat,
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
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        var res = await Provider.of<PemesananViewModel>(context,
                                listen: false)
                            .getPemesananDetail(
                                codeBooking: widget.bookingCode);
                        if (Provider.of<PemesananViewModel>(context,
                                    listen: false)
                                .detailPemesanan!
                                .status ==
                            "pending") {
                          try {
                            var res2 = await DeleteService().deletePemesanan(
                              bookingCode: int.parse(widget.bookingCode),
                            );
                            if (res2.containsKey("result") && res2 != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Berhasil hapus data Pemesanan"),
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
