import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/onboarding/widget/button_card_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/onboarding/building.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Gedung',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Triharjo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Aplikasi Pemesanan Gedung Triharjo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 50,
              ),
              ButtonCardWidget(
                color: Colors.white,
                colorName: const Color(0xFF162D68),
                iconAsset: 'assets/icon/onboarding/login.png',
                namaButton: 'Login',
              ),
              const SizedBox(
                height: 15,
              ),
              ButtonCardWidget(
                color: Colors.white,
                colorName: Colors.black,
                iconAsset: 'assets/icon/onboarding/google.png',
                namaButton: 'Sign In with Google',
              ),
              const SizedBox(
                height: 120,
              ),
              const Center(
                child: Text(
                  'Belum punya akun?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Center(
                  child: Text(
                    'Register disini',
                    style: TextStyle(
                      color: Color(0xFFF9D16B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Center(
                child: Text(
                  'Created by Nisa Ustnia',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
