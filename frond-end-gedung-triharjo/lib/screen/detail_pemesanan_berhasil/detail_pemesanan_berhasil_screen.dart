import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPemesananBerhasil extends StatefulWidget {
  final String totalPembayaran;
  final String event;
  final String noKTP;
  final String nama;
  final String email;
  final String noTelp;
  final String dateMulai;
  final String alamat;
  final String bookingCode;
  final String time;
  final int jumHar;
  const DetailPemesananBerhasil({
    super.key,
    required this.totalPembayaran,
    required this.event,
    required this.noKTP,
    required this.nama,
    required this.email,
    required this.noTelp,
    required this.dateMulai,
    required this.alamat,
    required this.bookingCode,
    required this.time,
    required this.jumHar,
  });

  @override
  State<DetailPemesananBerhasil> createState() =>
      _DetailPemesananBerhasilState();
}

String tanggalBooking(value) {
  DateTime dateTime = DateTime.parse(value);
  dateTime = dateTime.toLocal();
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}

class _DetailPemesananBerhasilState extends State<DetailPemesananBerhasil> {
  bool detailPemesanan = true;

  //Bikin int jadi Currency
  String formatAmount(int amount) {
    final NumberFormat formatter = NumberFormat.decimalPattern('id');
    return formatter.format(amount);
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

  @override
  Widget build(BuildContext context) {
    List<String> dateList = generateDateList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pemesanan"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          Image.asset(
            'assets/image/success/succes.png',
            height: 180,
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Text(
              "Rp ${formatAmount(int.parse(widget.totalPembayaran))},-",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'ID Pemesanan : ${widget.bookingCode}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'Pemesanan Telah Berhasil Dilakukan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Detail Pemesanan',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                      const EdgeInsets.symmetric(vertical: 15),
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
                                    Text(widget.noKTP),
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                    width: MediaQuery.of(context).size.width,
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
                                              MainAxisAlignment.spaceBetween,
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
          ),
        ],
      ),
    );
  }
}
