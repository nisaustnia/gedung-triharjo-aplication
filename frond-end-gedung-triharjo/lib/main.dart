import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:penyewaan_gedung_triharjo/screen/accountlist/account_list_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/bottom_bar/bottom_bar.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/list_event_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/notification_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_list_order/detail_list_order_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/history/history_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_jadwal/list_jadwal2_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_order/list_order_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/login/login_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/notification/notification_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/onboarding/onboarding_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/profil/provil_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/register/register_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(
    Phoenix(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProfilViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => EventViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => PemesananViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => HistoryViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => ListOrderViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => DetailListOrderViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => ListJadwal2ViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => AccountListViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => NotificationViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => NotificationListViewModel(),
          ),
        ],
        child: const GedungTriharjo(),
      ),
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
}

class GedungTriharjo extends StatelessWidget {
  const GedungTriharjo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/bottom_bar': (context) => const BottomBar(indexPage: 0),
      },
    );
  }
}
