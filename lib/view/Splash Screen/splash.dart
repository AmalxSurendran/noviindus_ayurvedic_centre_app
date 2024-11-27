import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/signin');
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Image.asset(
          'assets/Splash.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
