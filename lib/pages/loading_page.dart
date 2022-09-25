import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
