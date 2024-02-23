import 'package:flutter/material.dart';

class ProfilTriharjoScreen extends StatefulWidget {
  const ProfilTriharjoScreen({super.key});

  @override
  State<ProfilTriharjoScreen> createState() => _ProfilTriharjoScreenState();
}

class _ProfilTriharjoScreenState extends State<ProfilTriharjoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Triharjo',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF3E70F2),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    "assets/image/dashboard/dashboard1.png",
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Profil Aplikasi Gedung Triharjo",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Aplikasi Penyewaaan Gedung Triharjo adalah aplikasi yang menyediakan layanan penyewaan gedung untuk berbagai acara di Triharjo. Dengan aplikasi ini, Anda dapat dengan mudah menemukan dan menyewa gedung untuk acara pernikahan, pesta ulang tahun, seminar, dan berbagai acara lainnya. Kami menyediakan pilihan gedung yang luas dan beragam sesuai dengan kebutuhan Anda.',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF3E70F2),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fitur Utama :",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "1. Pemesanan Online: Lakukan pemesanan gedung secara online dengan mudah dan cepat.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "2. Harga dan Paket: Dapatkan informasi lengkap tentang harga sewa gedung dan paket-paket yang tersedia.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Visi",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Menjadi platform penyewaan gedung terkemuka di Triharjo dengan menyediakan pilihan gedung berkualitas dan layanan yang memuaskan pelanggan.",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Misi",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "1. Menyediakan pilihan gedung yang bervariasi dan sesuai dengan kebutuhan pengguna.",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "2. Menjamin keamanan dan kenyamanan pengguna selama acara berlangsung.",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.facebook),
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.web),
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.mail),
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.phone),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
