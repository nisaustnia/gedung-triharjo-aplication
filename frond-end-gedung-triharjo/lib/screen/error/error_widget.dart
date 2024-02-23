import 'package:flutter/material.dart';

class ErrorWidgetScreen extends StatelessWidget {
  final VoidCallback onRefreshPressed;
  const ErrorWidgetScreen({super.key, required this.onRefreshPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'ERROR',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text('Maaf sepertinya ada kesalahan'),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: onRefreshPressed,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Coba Lagi'),
          ),
        )
      ],
    );
  }
}
