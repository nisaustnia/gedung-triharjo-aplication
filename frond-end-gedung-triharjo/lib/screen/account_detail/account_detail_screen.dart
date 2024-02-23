// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/service/change_admin_service.dart';
import 'package:penyewaan_gedung_triharjo/service/delete_user_service.dart';

class AccountDetailScreen extends StatefulWidget {
  final String nama;
  final String email;
  final String noKTP;
  final String gender;
  final String noTelp;
  final String warga;
  final String alamat;
  final String typeUser;
  const AccountDetailScreen({
    super.key,
    required this.nama,
    required this.email,
    required this.noKTP,
    required this.gender,
    required this.noTelp,
    required this.warga,
    required this.alamat,
    required this.typeUser,
  });

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  String formatLine(String input) {
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(' ');
  }

  bool isLoadingChange = false;

  bool isLoadingDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Account',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF3E70F2),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 5.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Text(
                                widget.typeUser == 'admin'
                                    ? 'Admin'
                                    : 'Customer',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Nama',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(formatLine(widget.nama)),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Email',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.email),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'No KTP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.noKTP),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Gender',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.gender == 'l'
                                    ? "Laki-Laki"
                                    : "Perempuan",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'WhatsApp',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.noTelp),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tipe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.warga == '1'
                                  ? 'Warga Triharjo'
                                  : 'Luar Warga Triharjo'),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Alamat',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  formatLine(widget.alamat),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      widget.gender == 'l' ? Icons.person : Icons.person_2,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: widget.typeUser == 'admin',
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E70F2)),
                    onPressed: () async {
                      setState(() {
                        isLoadingChange = true;
                      });
                      try {
                        var res = await ChangeAdminService()
                            .adminAdd(email: widget.email, type: 'customer');

                        if (res.containsKey('result')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Berhasil ")));
                        }
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/bottom_bar', (route) => false);
                        setState(() {
                          isLoadingChange = false;
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Gagal Ubah User Jadi Customer")));
                        setState(() {
                          isLoadingChange = false;
                        });
                      }
                    },
                    child: isLoadingChange == true
                        ? const CircularProgressIndicator()
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_off),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Jadikan Custommer'),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.typeUser != 'admin',
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E70F2)),
                    onPressed: () async {
                      setState(() {
                        isLoadingChange = true;
                      });
                      try {
                        var res = await ChangeAdminService()
                            .adminAdd(email: widget.email, type: 'admin');

                        if (res.containsKey('result')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Berhasil ")));
                        }
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/bottom_bar', (route) => false);
                        setState(() {
                          isLoadingChange = false;
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Gagal Ubah User Jadi Admin")));
                        setState(() {
                          isLoadingChange = false;
                        });
                      }
                    },
                    child: isLoadingChange == true
                        ? const CircularProgressIndicator()
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Jadikan Admin'),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Visibility(
              visible: widget.typeUser != 'admin',
              child: const Text(
                'Bahaya Hati-Hati',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Visibility(
              visible: widget.typeUser != 'admin',
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      setState(() {
                        isLoadingDelete = true;
                      });
                      try {
                        var res = await DeleteUserService()
                            .adminDelete(email: widget.email);

                        if (res.containsKey('result')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Berhasil Hapus Akun")));
                        }
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/bottom_bar', (route) => false);
                        setState(() {
                          isLoadingDelete = false;
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Gagal Hapus Akun")));
                        setState(() {
                          isLoadingDelete = false;
                        });
                      }
                    },
                    child: isLoadingDelete == true
                        ? const CircularProgressIndicator()
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Hapus Akun'),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
