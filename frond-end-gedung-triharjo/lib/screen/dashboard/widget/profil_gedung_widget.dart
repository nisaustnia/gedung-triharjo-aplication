import 'dart:async';

import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/profil_triharjo/profil_triharjo_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProfilGedungWidget extends StatefulWidget {
  const ProfilGedungWidget({super.key});

  @override
  State<ProfilGedungWidget> createState() => _ProfilGedungWidgetState();
}

class _ProfilGedungWidgetState extends State<ProfilGedungWidget> {
  final _pageController = PageController();
  List<String> imageProfil = [
    "assets/image/dashboard/dashboard1.png",
    "assets/image/dashboard/dashboard2.png",
    "assets/image/dashboard/dashboard3.png",
  ];
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < imageProfil.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilTriharjoScreen(),
            ));
      },
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: PageView(
              controller: _pageController,
              children: imageProfil.map(
                (imageProfil) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      imageProfil,
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Aplikasi Gedung Triharjo",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: imageProfil.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.white,
                        dotColor: Colors.white,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
