import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/bulanan_model.dart';
import 'package:penyewaan_gedung_triharjo/model/sesi_model.dart';
import 'package:penyewaan_gedung_triharjo/service/bulanan_service.dart';
import 'package:penyewaan_gedung_triharjo/service/sesi_service.dart';

class ListJadwal2ViewModel extends ChangeNotifier {
  List<SesiModel?> _listSesi = [];
  List<SesiModel?> get allSesi => _listSesi;

  Future getAllSesi({idIndex}) async {
    try {
      final List<SesiModel> allSesiData =
          await SesiService.fetchListSesiData(index: idIndex);

      _listSesi = allSesiData;
      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat all data sesi : $error');
    }
  }

  List<SesiModel?> _listSesiGedung = [];
  List<SesiModel?> get allSesiGedung => _listSesiGedung;

  Future getAllSesiGedung({idIndex}) async {
    try {
      final List<SesiModel> allSesiGedungData =
          await SesiService.fetchListSesiData(index: idIndex);

      _listSesiGedung = allSesiGedungData;
      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat all data sesi : $error');
    }
  }

  @override
  notifyListeners();

  List<BulananModel?> _listBulananGedung = [];
  List<BulananModel?> get allBulananGedung => _listBulananGedung;

  Future getAllBulananGedung() async {
    try {
      final List<BulananModel> allBulananGedungData =
          await BulananService.fetchListBulananData();

      _listBulananGedung = allBulananGedungData;
      notifyListeners();
    } catch (error) {
      throw Exception('Gagal memuat all data bulanan : $error');
    }
  }
}
