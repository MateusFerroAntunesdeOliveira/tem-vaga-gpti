import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';

import '../login/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          backgroundColor: const Color(0xFF9F150D),
          splashIconSize: 350,
          splash: Image.asset("assets/images/Logo_TemVaga-semFundo.png"),
          duration: 2000,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: const LoginPage()),
    );
  }
}
