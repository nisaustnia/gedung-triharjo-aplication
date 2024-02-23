// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/accountlist/account_list_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/article_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/header_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/pesan_gedung_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/profil_gedung_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  final String typeAccount;
  const DashboardScreen({
    super.key,
    required this.typeAccount,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Tidak bisa launch url',
        style: TextStyle(color: Colors.white),
      )));
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F6),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 160,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3E70F2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: HeaderWidget(
                        typeAccount: widget.typeAccount,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ProfilGedungWidget(),
                    ),
                    widget.typeAccount == 'admin'
                        ? Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        height: 3,
                                        thickness: 3,
                                        color: Color(0xFF3E70F2),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Admin',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Divider(
                                        height: 3,
                                        thickness: 3,
                                        color: Color(0xFF3E70F2),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchURL(
                                        'https://docs.google.com/spreadsheets/d/1fdEj1EfeQFhpi2QVGo7LGLa6ZhHextwrmjBAml_cMeU/edit?usp=sharing');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 5.0,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      border: const Border(
                                        top: BorderSide(
                                          color: Colors.green,
                                          width: 10.0,
                                        ),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Google SpreadSheet',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.table_chart,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AccountListScreen(),
                                        ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 5.0,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      border: const Border(
                                        top: BorderSide(
                                          color: Color(0xFF3E70F2),
                                          width: 10.0,
                                        ),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'List Account',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.person,
                                          color: Color(0xFF3E70F2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        : const PesanGedungWidget(),
                    const ArticleWidget(),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
