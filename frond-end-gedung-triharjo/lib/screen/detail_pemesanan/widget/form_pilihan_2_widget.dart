// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:penyewaan_gedung_triharjo/model/event_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_pemesanan_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/list_event_view_model.dart';
import 'package:penyewaan_gedung_triharjo/service/pesan.dart';
import 'package:penyewaan_gedung_triharjo/service/pesan_sesi.dart';
import 'package:provider/provider.dart';

class FormPilihan2Widget extends StatefulWidget {
  const FormPilihan2Widget({super.key});

  @override
  State<FormPilihan2Widget> createState() => _FormPilihan2WidgetState();
}

class _FormPilihan2WidgetState extends State<FormPilihan2Widget> {
  late Event eventData;
  List<String> chipValues = [
    '06:00 - 08:00',
    '08:00 - 10:00',
    '10:00 - 12:00',
    '12:00 - 14:00',
    '14:00 - 16:00',
    '16:00 - 18:00',
    '18:00 - 20:00',
    '20:00 - 22:00',
    '22:00 - 24:00',
  ];

  String chipValuesTime(index) {
    String selectedValue = chipValues[index];
    List<String> parts = selectedValue.split(' - ');
    String startTime = parts.isNotEmpty ? parts[0] : selectedValue;
    return startTime;
  }

  List<String> selectedChips = [];
  final TextEditingController _dateController = TextEditingController();
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  final currentDate = DateTime.now();
  String? selectedValue;
  String? selectedLangganan = 'Berlangganan';
  String? selectedKeperluan;
  String? selectedTipe;
  String? selectedTipe2;
  String? selectedTipeBerlangganan;
  List<String> optionsLangganan = [
    'Berlangganan',
    'Non Berlangganan',
  ];
  List<String> optionsKeperluan = [
    'Hajatan / pernikahan',
    'Pameran/Expo',
    'Turnamen/Pertandingan',
    'Rapat/Pertemuan',
  ];
  List<String> optionsBerlangganan = [
    'Line Badminton Bulanan',
    'Line Badminton Sesi',
    'Unit 1 Gedung Sesi',
  ];
  List<String> optionsTipe = [
    'Organisasi',
    'Perorangan',
  ];

  List<String> optionsTipe2 = [
    'Organisasi',
    'Perorangan',
  ];

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  List<String> optionsBank = [
    'BRI',
    'BNI',
    'BCA',
  ];

  String selectedBank = 'BRI';

  int selectedChipIndex = -1;

  Future<void> makePemesanan(int value) async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await AddPemesananService().pemesananAdd(
        idEvent: value,
        dateMulai: _dateController.text,
        jumlahHari: "1",
        tipeHarga: selectedTipe!.toLowerCase(),
        paymentType: selectedBank.toLowerCase(),
      );

      if (res.containsKey('result') && res != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CheckingPemesanan(codeBooking: res["result"]["bookingCode"]),
          ),
        );

        setState(() {
          isLoading = false;
        });
      } else if (res.containsKey('error') && res != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          res['error'],
          style: const TextStyle(color: Colors.white),
        )));

        log('Error during pemesanan: ${res['error']}');
        setState(() {
          isLoading = false;
        });
      }
      log('Pemesanan berhasil dilakukan!');
      log('Response: $res');
      log('Jumlah Hari');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "$e",
        style: const TextStyle(color: Colors.white),
      )));
      log('Error during pemesanan: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> makePemesananBulanan(int value) async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await AddPemesananService().pemesananAdd(
        idEvent: value,
        dateMulai: _dateController.text,
        jumlahHari: "1",
        tipeHarga: 'perorangan',
        paymentType: selectedBank.toLowerCase(),
      );

      if (res.containsKey('result') && res != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CheckingPemesanan(codeBooking: res["result"]["bookingCode"]),
          ),
        );

        setState(() {
          isLoading = false;
        });
      } else if (res.containsKey('error') && res != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          res['error'],
          style: const TextStyle(color: Colors.white),
        )));

        log('Error during pemesanan: ${res['error']}');
        setState(() {
          isLoading = false;
        });
      }
      log('Pemesanan berhasil dilakukan!');
      log('Response: $res');
      log('Jumlah Hari');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "$e",
        style: const TextStyle(color: Colors.white),
      )));
      log('Error during pemesanan: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> makePemesananSesi(int value, String event) async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await AddPemesananSesiService().pemesananAdd(
        idEvent: value,
        dateMulai: _dateController.text,
        jumlahHari: "1",
        tipeHarga: event == 'Line Badminton Sesi'
            ? 'organisasi'
            : selectedTipe2!.toLowerCase(),
        paymentType: selectedBank.toLowerCase(),
        sesi: chipValuesTime(selectedChipIndex),
      );

      if (res.containsKey('result') && res != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CheckingPemesanan(codeBooking: res["result"]["bookingCode"]),
          ),
        );

        setState(() {
          isLoading = false;
        });
      } else if (res.containsKey('error') && res != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          res['error'],
          style: const TextStyle(color: Colors.white),
        )));

        log('Error during pemesanan: ${res['error']}');
        setState(() {
          isLoading = false;
        });
      }
      log('Pemesanan berhasil dilakukan!');
      log('Response: $res');
      log('Jumlah Hari');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "$e",
        style: const TextStyle(color: Colors.white),
      )));
      log('Error during pemesanan: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          value: selectedLangganan,
          items: optionsLangganan.map((String option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue == 'Berlangganan') {
              eventViewModel.gantiHargaGedung(0);
              eventViewModel.gantiTipeSesi('');
              setState(() {
                selectedTipeBerlangganan = null;
                selectedTipe2 = null;
                selectedChipIndex = -1;
              });
            } else if (newValue == 'Non Berlangganan') {
              eventViewModel.gantiHargaGedung(0);
              eventViewModel.gantiTipeSesi('');
              setState(() {
                selectedKeperluan = null;
                selectedTipe = null;
              });
            }
            setState(() {
              selectedLangganan = newValue!;
            });
          },
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.access_time),
            hintText: 'Pilih Langganan',
            filled: true,
            fillColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Non Berlangganan',
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Non Berlangganan',
          child: DropdownButtonFormField(
            value: selectedKeperluan,
            items: optionsKeperluan.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (newValue) {
              if (selectedTipe == 'Organisasi' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  newValue == 'Hajatan / pernikahan') {
                setState(() {
                  eventData = eventViewModel.getEventById(1);
                });
                eventViewModel.gantiHargaGedung(eventData.organisasi);
                eventViewModel.gantiTipeSesi('/ Hari');
              } else if (selectedTipe == 'Perorangan' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  newValue == 'Hajatan / pernikahan') {
                setState(() {
                  eventData = eventViewModel.getEventById(1);
                });
                eventViewModel.gantiHargaGedung(eventData.perorangan);
                eventViewModel.gantiTipeSesi('/ Hari');
              }
              if (selectedTipe == 'Organisasi' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  newValue == 'Pameran/Expo') {
                setState(() {
                  eventData = eventViewModel.getEventById(2);
                });
                eventViewModel.gantiHargaGedung(eventData.organisasi);
                eventViewModel.gantiTipeSesi('/ Hari');
              } else if (selectedTipe == 'Perorangan' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  newValue == 'Pameran/Expo') {
                setState(() {
                  eventData = eventViewModel.getEventById(2);
                });
                eventViewModel.gantiHargaGedung(eventData.perorangan);
                eventViewModel.gantiTipeSesi('/ Hari');
              }
              if (selectedTipe == 'Organisasi' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  newValue == 'Turnamen/Pertandingan') {
                setState(() {
                  eventData = eventViewModel.getEventById(3);
                });
                eventViewModel.gantiHargaGedung(eventData.organisasi);
                eventViewModel.gantiTipeSesi('/ Hari');
              } else if (selectedTipe == 'Perorangan' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  newValue == 'Turnamen/Pertandingan') {
                setState(() {
                  eventData = eventViewModel.getEventById(3);
                });
                eventViewModel.gantiHargaGedung(eventData.perorangan);
                eventViewModel.gantiTipeSesi('/ Hari');
              }
              if (selectedTipe == 'Organisasi' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  newValue == 'Rapat/Pertemuan') {
                setState(() {
                  eventData = eventViewModel.getEventById(4);
                });
                eventViewModel.gantiHargaGedung(eventData.organisasi);
                eventViewModel.gantiTipeSesi('/ Hari');
              } else if (selectedTipe == 'Perorangan' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  newValue == 'Rapat/Pertemuan') {
                setState(() {
                  eventData = eventViewModel.getEventById(4);
                });
                eventViewModel.gantiHargaGedung(eventData.perorangan);
                eventViewModel.gantiTipeSesi('/ Hari');
              }
              setState(() {
                selectedKeperluan = newValue!;
              });
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.dataset),
              hintText: 'Pilih Keperluan',
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan',
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan',
          child: DropdownButtonFormField(
            value: selectedTipeBerlangganan,
            items: optionsBerlangganan.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                if (newValue == 'Line Badminton Bulanan' &&
                    selectedLangganan == 'Berlangganan') {
                  setState(() {
                    eventData = eventViewModel.getEventById(5);
                  });
                  eventViewModel.gantiHargaGedung(eventData.perorangan);
                  eventViewModel.gantiTipeSesi('/ Bulan');
                } else if (newValue == 'Line Badminton Sesi' &&
                    selectedLangganan == 'Berlangganan') {
                  setState(() {
                    eventData = eventViewModel.getEventById(6);
                  });
                  eventViewModel.gantiHargaGedung(eventData.organisasi);
                  eventViewModel.gantiTipeSesi('/ Sesi');
                } else if (newValue == 'Unit 1 Gedung Sesi' &&
                    selectedLangganan == 'Berlangganan') {
                  eventViewModel.gantiHargaGedung(0);
                  eventViewModel.gantiTipeSesi('');
                }
                selectedTipeBerlangganan = newValue!;
              });
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.dataset),
              hintText: 'Pilih Tipe Berlangganan',
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Non Berlangganan' &&
              selectedKeperluan != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'List Fitur $selectedKeperluan',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              selectedKeperluan == 'Hajatan / pernikahan'
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Sound System'),
                        Text('- Meja dan Kursi untuk tamu dan pengantin'),
                        Text('- Tenda atau dekorasi khusus pernikahan'),
                      ],
                    )
                  : selectedKeperluan == 'Pameran/Expo'
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('- Sound System'),
                            Text('- Stan pameran atau booth'),
                            Text('- Meja dan kursi pameran'),
                            Text('- Peralatan Presentasi'),
                          ],
                        )
                      : selectedKeperluan == 'Turnamen/Pertandingan'
                          ? const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('- Sound System'),
                                Text(
                                    '- Peralatan olahraga khusus untuk turnamen tertentu'),
                                Text('- Kursi atau tribun untuk penonton'),
                                Text('- Papan skor dan sistem pengumuman'),
                              ],
                            )
                          : selectedKeperluan == 'Rapat/Pertemuan'
                              ? const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('- Sound System'),
                                    Text('- Proyektor dan layar proyeksi'),
                                    Text('- Papan tulis atau flip chart'),
                                    Text('- Meja dan Kursi'),
                                  ],
                                )
                              : Container(),
            ],
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Non Berlangganan',
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Non Berlangganan',
          child: DropdownButtonFormField(
            value: selectedTipe,
            items: optionsTipe.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue == 'Organisasi' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  selectedKeperluan == 'Hajatan / pernikahan') {
                setState(() {
                  eventData = eventViewModel.getEventById(1);
                });
                eventViewModel.gantiHargaGedung(eventData.organisasi);
                eventViewModel.gantiTipeSesi('/ Hari');
              } else if (newValue == 'Perorangan' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  selectedKeperluan == 'Hajatan / pernikahan') {
                setState(() {
                  eventData = eventViewModel.getEventById(1);
                });
                eventViewModel.gantiHargaGedung(eventData.perorangan);
                eventViewModel.gantiTipeSesi('/ Hari');
              }
              if (newValue == 'Organisasi' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  selectedKeperluan == 'Pameran/Expo') {
                setState(() {
                  eventData = eventViewModel.getEventById(2);
                });
                eventViewModel.gantiHargaGedung(eventData.organisasi);
                eventViewModel.gantiTipeSesi('/ Hari');
              } else if (newValue == 'Perorangan' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  selectedKeperluan == 'Pameran/Expo') {
                setState(() {
                  eventData = eventViewModel.getEventById(2);
                });
                eventViewModel.gantiHargaGedung(eventData.perorangan);
                eventViewModel.gantiTipeSesi('/ Hari');
              }
              if (newValue == 'Organisasi' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  selectedKeperluan == 'Turnamen/Pertandingan') {
                setState(() {
                  eventData = eventViewModel.getEventById(3);
                });
                eventViewModel.gantiHargaGedung(eventData.organisasi);
                eventViewModel.gantiTipeSesi('/ Hari');
              } else if (newValue == 'Perorangan' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  selectedKeperluan == 'Turnamen/Pertandingan') {
                setState(() {
                  eventData = eventViewModel.getEventById(3);
                });
                eventViewModel.gantiHargaGedung(eventData.perorangan);
                eventViewModel.gantiTipeSesi('/ Hari');
              }
              if (newValue == 'Organisasi' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  selectedKeperluan == 'Rapat/Pertemuan') {
                setState(() {
                  eventData = eventViewModel.getEventById(4);
                });
                eventViewModel.gantiHargaGedung(eventData.organisasi);
                eventViewModel.gantiTipeSesi('/ Hari');
              } else if (newValue == 'Perorangan' &&
                  selectedLangganan == 'Non Berlangganan' &&
                  selectedKeperluan == 'Rapat/Pertemuan') {
                setState(() {
                  eventData = eventViewModel.getEventById(4);
                });
                eventViewModel.gantiHargaGedung(eventData.perorangan);
                eventViewModel.gantiTipeSesi('/ Hari');
              }
              setState(() {
                selectedTipe = newValue!;
              });
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.list),
              hintText: 'Pilih Tipe',
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan' &&
              selectedTipeBerlangganan != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'List Fitur $selectedTipeBerlangganan',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              selectedTipeBerlangganan == 'Line Badminton Bulanan'
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Sound System'),
                        Text('- Raket dan bulu tangkis'),
                        Text('- Papan skor dan pemantau waktu'),
                        Text('- Kursi untuk penonton'),
                        Text('- Lapangan badminton dan net'),
                      ],
                    )
                  : selectedTipeBerlangganan == 'Line Badminton Sesi'
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('- Sound System'),
                            Text('- Raket dan bulu tangkis'),
                            Text('- Papan skor dan pemantau waktu'),
                            Text('- Kursi untuk penonton'),
                            Text('- Lapangan badminton dan net'),
                          ],
                        )
                      : selectedTipeBerlangganan == 'Unit 1 Gedung Sesi'
                          ? const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('- Sound System'),
                                Text('- Perabotan dasar (meja, kursi)'),
                                Text(
                                    '- Peralatan presentasi (jika digunakan untuk seminar atau pertemuan)'),
                                Text('- Papan skor dan sistem pengumuman'),
                              ],
                            )
                          : Container(),
            ],
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan' &&
              selectedTipeBerlangganan == 'Unit 1 Gedung Sesi',
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan' &&
              selectedTipeBerlangganan == 'Unit 1 Gedung Sesi',
          child: DropdownButtonFormField(
            value: selectedTipe2,
            items: optionsTipe2.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue == 'Organisasi' &&
                  selectedLangganan == 'Berlangganan') {
                setState(() {
                  eventData = eventViewModel.getEventById(7);
                });
                eventViewModel.gantiHargaGedung(eventData.organisasi);
                eventViewModel.gantiTipeSesi('/ Sesi');
              } else if (newValue == 'Perorangan' &&
                  selectedLangganan == 'Berlangganan') {
                setState(() {
                  eventData = eventViewModel.getEventById(7);
                });
                eventViewModel.gantiHargaGedung(eventData.perorangan);
                eventViewModel.gantiTipeSesi('/ Sesi');
              }
              setState(() {
                selectedTipe2 = newValue!;
              });
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.list),
              hintText: 'Pilih Tipe',
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _dateController,
          readOnly: true,
          autofocus: true,
          onTap: () async {
            showDialog(
              context: context,
              builder: (BuildContext contet) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        firstDate: DateTime(1990),
                        lastDate: DateTime(currentDate.year + 5),
                        currentDate: DateTime.now(),
                      ),
                      value: _singleDatePickerValueWithDefaultValue,
                      onValueChanged: (value) {
                        DateTime? dateBirth = value[0];
                        if (dateBirth != null) {
                          setState(() {
                            _singleDatePickerValueWithDefaultValue = value;
                            _dateController.text =
                                DateFormat('yyyy-MM-dd').format(dateBirth);
                          });
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            );
          },
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.date_range),
            hintText: 'Pilih Tanggal',
            filled: true,
            fillColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        DropdownButtonFormField(
          value: selectedBank,
          items: optionsBank.map((String option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedBank = newValue!;
            });
          },
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.comment_bank),
            hintText: 'Pilih Bank',
            filled: true,
            fillColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: (selectedLangganan == 'Berlangganan' &&
                  selectedTipeBerlangganan == 'Line Badminton Sesi') ||
              (selectedLangganan == 'Berlangganan' &&
                  selectedTipeBerlangganan == 'Unit 1 Gedung Sesi'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pilih Sesi',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Visibility(
                visible: selectedChipIndex != -1,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedChipIndex = -1;
                    });
                  },
                  child: const Text(
                    'Batalkan Sesi',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: (selectedLangganan == 'Berlangganan' &&
                  selectedTipeBerlangganan == 'Line Badminton Sesi') ||
              (selectedLangganan == 'Berlangganan' &&
                  selectedTipeBerlangganan == 'Unit 1 Gedung Sesi'),
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: (selectedLangganan == 'Berlangganan' &&
                  selectedTipeBerlangganan == 'Line Badminton Sesi') ||
              (selectedLangganan == 'Berlangganan' &&
                  selectedTipeBerlangganan == 'Unit 1 Gedung Sesi'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 3.0,
                ),
                itemCount: chipValues.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChoiceChip(
                    label: Text(chipValues[index]),
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: selectedChipIndex == index
                          ? Colors.white
                          : Colors.black,
                    ),
                    selected: selectedChipIndex == index,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedChipIndex = index;
                        } else {
                          selectedChipIndex = -1;
                        }
                      });
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              selectedChipIndex == -1
                  ? Container()
                  : Text('Anda Memilih Sesi: ${chipValues[selectedChipIndex]}'),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 1.0,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (selectedLangganan == 'Berlangganan') {
                  if (selectedTipeBerlangganan == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Tipe Berlangganan Harus Diisi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (selectedTipe2 == null &&
                      selectedTipeBerlangganan != 'Line Badminton Bulanan' &&
                      selectedTipeBerlangganan != 'Line Badminton Sesi') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Pilih Tipe Harus diisi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (_dateController.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Tanggal Harus diisi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    if (selectedTipeBerlangganan == 'Unit 1 Gedung Sesi') {
                      if (selectedChipIndex == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Pilih Sesi Harus diisi',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        makePemesananSesi(7, 'Unit 1 Gedung Sesi');
                      }
                    }
                    if (selectedTipeBerlangganan == 'Line Badminton Sesi') {
                      if (selectedChipIndex == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Pilih Sesi Harus diisi',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        makePemesananSesi(6, 'Line Badminton Sesi');
                      }
                    }
                    if (selectedTipeBerlangganan == 'Line Badminton Bulanan') {
                      makePemesananBulanan(5);
                    }
                  }
                } else if (selectedLangganan == 'Non Berlangganan') {
                  if (selectedKeperluan == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Pilih Keperluan Harus diisi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (selectedTipe == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Pilih Tipe Harus diisi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (_dateController.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Tanggal Harus diisi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    if (selectedKeperluan == 'Hajatan / pernikahan') {
                      makePemesanan(1);
                    } else if (selectedKeperluan == 'Pameran/Expo') {
                      makePemesanan(2);
                    } else if (selectedKeperluan == 'Turnamen/Pertandingan') {
                      makePemesanan(3);
                    } else if (selectedKeperluan == 'Rapat/Pertemuan') {
                      makePemesanan(4);
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Pesan Sekarang',
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
