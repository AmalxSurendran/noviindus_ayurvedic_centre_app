// ignore_for_file: use_build_context_synchronously

import 'package:ayurvedic_centre_patients/utlit/shared_prefernce.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> navigateBasedOnToken(BuildContext context) async {
    final isLoggedIn = await SharedPreferencesHelper.isLoggedIn();

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/homepage');
    } else {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        navigateBasedOnToken(context);
      });
    });

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Image.asset(
          'assets/Splash.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
