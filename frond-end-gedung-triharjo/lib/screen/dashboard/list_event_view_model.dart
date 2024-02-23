import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/event_model.dart';
import 'package:penyewaan_gedung_triharjo/service/event.dart';

class EventViewModel extends ChangeNotifier {
  List<Event> _listEvent = [];
  List<Event> get eventData => _listEvent;

  int hargaAula = 0;

  int hargaLapangan = 0;

  int hargaGedungOlahraga = 0;

  String tipeSesi = '';

  List<String> options = [
    'Organisasi',
    'Warga Triharjo',
    'Warga Luar Triharjo',
  ];
  String selectedOption = 'Perorangan';

  void gantiOptions(dataOptions) {
    options = dataOptions;
    notifyListeners();
  }

  Future getEventData() async {
    try {
      final List<Map<String, dynamic>> eventData =
          await EventService.fetchEventData();

      _listEvent = eventData.map((item) => Event.fromJson(item)).toList();
    } catch (error) {
      throw Exception('Gagal memuat all data event : $error');
    }
    notifyListeners();
  }

  void gantiHargaAula(hargaGedung) {
    hargaAula = hargaGedung;
    Future.microtask(() {
      notifyListeners();
    });
  }

  void gantiHargaLapangan(hargaGedung) {
    hargaLapangan = hargaGedung;
    Future.microtask(() {
      notifyListeners();
    });
  }

  void gantiHargaGedung(hargaGedung) {
    hargaGedungOlahraga = hargaGedung;
    Future.microtask(() {
      notifyListeners();
    });
  }

  void gantiTipeSesi(tipe) {
    tipeSesi = tipe;
    Future.microtask(() {
      notifyListeners();
    });
  }

  void clearAllPost() {
    _listEvent.clear();
  }

  Event getEventById(int idEvent) {
    return _listEvent.firstWhere((event) => event.idEvent == idEvent);
  }
}
