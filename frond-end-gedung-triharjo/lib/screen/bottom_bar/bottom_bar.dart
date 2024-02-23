import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/dashboard_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/history/history_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_order/list_order_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/profil/profil_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/profil/provil_view_model.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  final int indexPage;
  const BottomBar({
    super.key,
    required this.indexPage,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late Future detailProfilFuture;
  @override
  void initState() {
    final detailViewModel =
        Provider.of<ProfilViewModel>(context, listen: false);
    detailProfilFuture = detailViewModel.getProfilDetail();
    currentIndex = widget.indexPage;
    super.initState();
  }

  late int currentIndex;

  // List<Widget> children = [
  //   const DashboardScreen(),
  //   const HistoryScreen(),
  //   const ProfilScreen(),
  // ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<String> listAssets = [
    "assets/icon/bottom_bar/home.png",
    "assets/icon/bottom_bar/history.png",
    "assets/icon/bottom_bar/user.png",
    "assets/icon/bottom_bar/home_selected.png",
    "assets/icon/bottom_bar/history_selected.png",
    "assets/icon/bottom_bar/user_selected.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilViewModel>(builder: (context, provider, _) {
      return FutureBuilder(
          future: detailProfilFuture,
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
                  child: ErrorWidgetScreen(
                    onRefreshPressed: () {
                      Provider.of<ProfilViewModel>(context, listen: false)
                          .getProfilDetail();
                    },
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<ProfilViewModel>(builder: (context, provider, _) {
                return Scaffold(
                  appBar: null,
                  backgroundColor: Colors.white,
                  body: IndexedStack(
                    index: currentIndex,
                    children: [
                      DashboardScreen(
                        typeAccount: provider.typeAccount,
                      ),
                      provider.typeAccount == 'admin'
                          ? const ListOrderScreen()
                          : const HistoryScreen(),
                      ProfilScreen(
                        typeUser: provider.typeAccount,
                      ),
                    ],
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    elevation: 10,
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: Colors.black,
                    selectedItemColor: const Color(0xFF3E70F2),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFC7C6CA),
                    ),
                    selectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3E70F2),
                    ),
                    currentIndex: currentIndex,
                    onTap: onTabTapped,
                    items: [
                      BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                currentIndex == 0
                                    ? listAssets[3]
                                    : listAssets[0],
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                currentIndex == 1
                                    ? listAssets[4]
                                    : listAssets[1],
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        label: "History",
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                currentIndex == 2
                                    ? listAssets[5]
                                    : listAssets[2],
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        label: "Profile",
                      ),
                    ],
                  ),
                );
              });
            } else {
              return Scaffold(
                body: Center(
                  child: ErrorWidgetScreen(
                    onRefreshPressed: () {
                      provider.getProfilDetail();
                    },
                  ),
                ),
              );
            }
          });
    });
  }
}
