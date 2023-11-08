import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';

import '../login/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          backgroundColor: Color.fromARGB(255, 182, 182, 182),
          splashIconSize: 350,
          splash: Image.asset("assets/images/Logo_TemVaga-semFundo.png"),
          duration: 1500,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: const LoginPage()),
    );
  }
}
