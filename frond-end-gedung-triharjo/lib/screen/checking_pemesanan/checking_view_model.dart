import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/detail_pemesanan_model.dart';
import 'package:penyewaan_gedung_triharjo/service/detail_pesanan.dart';

class PemesananViewModel extends ChangeNotifier {
  BookingModel? _detailPemesanan;
  BookingModel? get detailPemesanan => _detailPemesanan;

  Future getPemesananDetail({
    required String codeBooking,
  }) async {
    try {
      final response = await DetailPemesananService.getDetailPemesanan(
          codeBooking: codeBooking);

      if (response.statusCode == 200) {
        final responseData = response.data['result'];
        _detailPemesanan =
            BookingModel.fromJson(responseData as Map<String, dynamic>);
        notifyListeners();
      } else {
        throw Exception(
            'Gagal memuat detail pemesanan. Error code : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Gagal memuat detail pemesanan : $error');
    }
  }
}
