// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';
import 'package:penyewaan_gedung_triharjo/service/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isTextVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F6),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                            'Login ke akun Anda',
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
                            controller: emailController,
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
                            height: 25,
                          ),
                          TextFormField(
                            controller: passwordController,
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
                                      try {
                                        var res =
                                            await LoginService().postLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                        if (res.containsKey('accessToken')) {
                                          String accessToken =
                                              res['accessToken'] ?? '';
                                          saveToken(valueToken: accessToken);

                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/bottom_bar',
                                                  (route) => false);
                                        } else if (res.containsKey('error')) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            '${res['error']}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )));
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                      } catch (e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          '$e',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )));
                                        // print("error $e");
                                      }
                                    } catch (e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  }
                                },
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text('Login'),
                              ),
                            ),
                          ),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Atau login dengan',
                                style: TextStyle(
                                  color: Color(0xFF8A8585),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: FractionallySizedBox(
                              widthFactor: 1.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icon/onboarding/google.png',
                                      height: 25,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Text(
                                      'Sign In with Google',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
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
                          'Belum punya akun ?',
                          style: TextStyle(
                            color: Color(0xFF8A8585),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/register');
                          },
                          child: const Text(
                            'Register disini',
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
            ],
          ),
        ),
      ),
    );
  }
}
