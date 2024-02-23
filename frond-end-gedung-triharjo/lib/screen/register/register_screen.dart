// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
// import 'package:penyewaan_gedung_triharjo/main.dart';
// import 'package:penyewaan_gedung_triharjo/model/register_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/login/login_screen.dart';
import 'package:penyewaan_gedung_triharjo/service/register.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _noKTPController = TextEditingController();
  final TextEditingController _dukuhController = TextEditingController();
  final TextEditingController _kelurahanController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _noWhatsappController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _namaLengkapController.dispose();
    _noKTPController.dispose();
    _dukuhController.dispose();
    _kelurahanController.dispose();
    _kecamatanController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _noWhatsappController.dispose();
    super.dispose();
  }

  bool isTextVisible = false;

  bool isTextVisibleConfirmation = false;

  bool isLoading = false;

  String gender = "l";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F6),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFF4472EB),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                height: 160,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'GTR',
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Registrasi akun Anda',
                            style: TextStyle(
                              color: Color(0xFF7E7777),
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: _namaLengkapController,
                            validator: (value) {
                              if (value != null && value.length < 5) {
                                return 'Enter min. 5 characters';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value != null && value.length < 5) {
                                return 'Enter min. 5 characters';
                              } else {
                                return null;
                              }
                            },
                            controller: _noKTPController,
                            decoration: InputDecoration(
                              labelText: 'No KTP',
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _dukuhController,
                            validator: (value) {
                              if (value != null && value.length < 2) {
                                return 'Enter min. 1 characters';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Dukuh',
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _kelurahanController,
                            validator: (value) {
                              if (value != null && value.length < 2) {
                                return 'Enter min. 1 characters';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Kelurahan',
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _kecamatanController,
                            validator: (value) {
                              if (value != null && value.length < 3) {
                                return 'Enter min. 3 characters';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Kecamatan',
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value != null && value.length < 2) {
                                      return 'Enter min. 2 characters example 01';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _rtController,
                                  decoration: InputDecoration(
                                    labelText: 'RT',
                                    filled: true,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value != null && value.length < 2) {
                                      return 'Enter min. 2 characters example 02';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _rwController,
                                  decoration: InputDecoration(
                                    labelText: 'RW',
                                    filled: true,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator: (email) {
                              if (email != null &&
                                  !EmailValidator.validate(email)) {
                                return 'Enter a valid email';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value != null && value.length < 5) {
                                return 'Enter min. 5 characters';
                              } else {
                                return null;
                              }
                            },
                            obscureText: isTextVisible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isTextVisible = !isTextVisible;
                                    });
                                  },
                                  icon: isTextVisible
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _passwordConfirmController,
                            validator: (value) {
                              if (value != null && value.length < 5) {
                                return 'Enter min. 5 characters';
                              } else if (value != _passwordController.text) {
                                return 'Password didn\'t match';
                              } else {
                                return null;
                              }
                            },
                            obscureText: isTextVisibleConfirmation,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isTextVisibleConfirmation =
                                          !isTextVisibleConfirmation;
                                    });
                                  },
                                  icon: isTextVisibleConfirmation
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              labelText: 'Confirm Password',
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      // registerViewModel.setGender('L');
                                      setState(() {
                                        gender = "l";
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: gender == 'l'
                                            ? const Color(0xFF162D68)
                                            : Colors.transparent,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Laki - laki',
                                          style: TextStyle(
                                            color: gender == 'l'
                                                ? Colors.white
                                                : const Color(0xFF777070),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      // registerViewModel.setGender('P');
                                      setState(() {
                                        gender = "p";
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: gender == 'p'
                                            ? const Color(0xFF162D68)
                                            : Colors.transparent,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          'Perempuan',
                                          style: TextStyle(
                                            color: gender == 'p'
                                                ? Colors.white
                                                : const Color(0xFF777070),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value != null && value.length < 5) {
                                return 'Enter min. 5 characters';
                              } else {
                                return null;
                              }
                            },
                            controller: _noWhatsappController,
                            decoration: InputDecoration(
                              labelText: 'Nomor Whatsapp',
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 50,
                            child: FractionallySizedBox(
                              widthFactor: 1.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF162D68),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();

                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      await RegisterService().postRegister(
                                        name: _namaLengkapController.text,
                                        noKTP: _noKTPController.text,
                                        dukuh: _dukuhController.text,
                                        kelurahan: _kelurahanController.text,
                                        kecamatan: _kecamatanController.text,
                                        rt: _rtController.text,
                                        rw: _rwController.text,
                                        email: _emailController.text,
                                        gender: gender,
                                        password: _passwordController.text,
                                        noTelp: _noWhatsappController.text,
                                      );
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding: const EdgeInsets.all(20),
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.check,
                                                  size: 80,
                                                  color: Colors.blue,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Text(
                                                    "Daftar Akun Anda Berhasil"),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                FractionallySizedBox(
                                                  widthFactor: 1.0,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF162D68),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        side: const BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen(),
                                                          ));
                                                    },
                                                    child: const Text(
                                                        'Kembali ke Login'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                      // final Session? session = res.session;
                                      // final User? user = res.user;
                                      // print("session ${session}");
                                      // print("user ${user}");

                                      setState(() {
                                        isLoading = false;
                                      });
                                    } catch (e) {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding: const EdgeInsets.all(20),
                                            height: 300,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.close,
                                                  size: 80,
                                                  color: Colors.red,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Text("Daftar Akun Gagal"),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                FractionallySizedBox(
                                                  widthFactor: 1.0,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF162D68),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        side: const BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                        'Register Ulang'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  }
                                },
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text('Register'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'Sudah punya akun ?',
                          style: TextStyle(
                            color: Color(0xFF8A8585),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(
                            'login disini',
                            style: TextStyle(
                              color: Color(0xFF4472EB),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
