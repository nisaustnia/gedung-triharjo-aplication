import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pembayaran/detail_pembayaran_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pemesanan_berhasil/detail_pemesanan_berhasil_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class CheckingPemesanan extends StatefulWidget {
  final String codeBooking;
  const CheckingPemesanan({super.key, required this.codeBooking});

  @override
  State<CheckingPemesanan> createState() => _CheckingPemesananState();
}

class _CheckingPemesananState extends State<CheckingPemesanan> {
  late Future detailPemesananFuture;
  @override
  void initState() {
    super.initState();
    final detailViewModel =
        Provider.of<PemesananViewModel>(context, listen: false);
    detailPemesananFuture =
        detailViewModel.getPemesananDetail(codeBooking: widget.codeBooking);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PemesananViewModel>(builder: (context, provider, _) {
      return FutureBuilder(
        future: detailPemesananFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: ErrorWidgetScreen(onRefreshPressed: () {
                  provider.getPemesananDetail(codeBooking: widget.codeBooking);
                }),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<PemesananViewModel>(
              builder: (context, provider, child) {
                if (provider.detailPemesanan?.status == "pending" &&
                    provider.detailPemesanan!.pembayaran != null) {
                  return DetailPembayaranScreen(
                    vaNumber: provider.detailPemesanan!.pembayaran!.vaNumber,
                    expiryTime:
                        "${provider.detailPemesanan!.pembayaran!.expiryTime}",
                    bookingCode: provider.detailPemesanan!.bookingCode,
                    totalPembayaran:
                        "${provider.detailPemesanan!.totalPembayaran}",
                    event: provider.detailPemesanan!.event,
                    noKTP: provider.detailPemesanan!.noKTP,
                    nama: provider.detailPemesanan!.nama,
                    email: provider.detailPemesanan!.email,
                    noTelp: provider.detailPemesanan!.noTelp,
                    dateMulai: "${provider.detailPemesanan!.dateMulai}",
                    alamat: provider.detailPemesanan!.alamat,
                    time: provider.detailPemesanan!.time == "00:01:00"
                        ? ''
                        : provider.detailPemesanan!.time,
                    jumHar: provider.detailPemesanan!.jumlahHari,
                    tipePembayaran:
                        provider.detailPemesanan!.pembayaran!.tipePembayaran,
                  );
                } else if (provider.detailPemesanan!.status == "success") {
                  log(provider.detailPemesanan!.status);
                  return DetailPemesananBerhasil(
                    bookingCode: provider.detailPemesanan!.bookingCode,
                    totalPembayaran:
                        "${provider.detailPemesanan!.totalPembayaran}",
                    event: provider.detailPemesanan!.event,
                    noKTP: provider.detailPemesanan!.noKTP,
                    nama: provider.detailPemesanan!.nama,
                    email: provider.detailPemesanan!.email,
                    noTelp: provider.detailPemesanan!.noTelp,
                    dateMulai: "${provider.detailPemesanan!.dateMulai}",
                    alamat: provider.detailPemesanan!.alamat,
                    time: provider.detailPemesanan!.time == "00:01:00"
                        ? ''
                        : provider.detailPemesanan!.time,
                    jumHar: provider.detailPemesanan!.jumlahHari,
                  );
                } else {
                  return Scaffold(
                    body: Center(
                      child: ErrorWidgetScreen(
                        onRefreshPressed: () {
                          provider.getPemesananDetail(
                              codeBooking: widget.codeBooking);
                        },
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return Scaffold(
              body: Center(
                child: ErrorWidgetScreen(onRefreshPressed: () {
                  provider.getPemesananDetail(codeBooking: widget.codeBooking);
                }),
              ),
            );
          }
        },
      );
    });
  }
}
