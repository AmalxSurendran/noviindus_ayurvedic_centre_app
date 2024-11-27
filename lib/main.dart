import 'package:ayurvedic_centre_patients/utlit/colors.dart';
import 'package:ayurvedic_centre_patients/provider/signin_provider.dart';
import 'package:ayurvedic_centre_patients/view/homepage.dart';
import 'package:ayurvedic_centre_patients/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ayurvedic_centre_patients/view/Splash%20Screen/splash.dart';
import 'package:ayurvedic_centre_patients/view/auth/signin_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _customPageRoute(
              const SplashScreen(),
            );
          case '/signin':
            return _customPageRoute(
              SigninPage(),
            );
          case '/homepage':
            return _customPageRoute(
              const HomePage(),
            );
          case '/regpage':
            return _customPageRoute(
              const RegisterPage(),
            );

          default:
            return _customPageRoute(const SplashScreen());
        }
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
    );
  }

  PageRouteBuilder _customPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
