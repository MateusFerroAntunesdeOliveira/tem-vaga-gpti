import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9F150D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-> Bem vindo
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Bem-vindo(a) ao",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),
              //-> TEM VAGA
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "TEM VAGA?",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                      fontFamily: 'Montserrat'),
                ),
              ),
              // Logo
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: SizedBox(
                  height: 320,
                  child: Center(
                    child: Image.asset("assets/images/Logo_TemVaga-semFundo.png"),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              //-> Apple
              Expanded(
                child: ElevatedButton(
                  style: BasicButtonStyle(
                    elevation: 0,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(FontAwesomeIcons.apple),
                      SizedBox(width: 8),
                      Text(
                        "Continuar com Apple",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/HomePage');
                  },
                ),
              ),
              const SizedBox(height: 8),
              //-> Google
              Expanded(
                child: ElevatedButton(
                  style: BasicButtonStyle(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(FontAwesomeIcons.google, color: Color(0xFFdd4b39)),
                      SizedBox(width: 8),
                      Text(
                        "Continuar com Google",
                        style: TextStyle(
                          color: Color(0xFF2E324A),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/HomePage');
                  },
                ),
              ),
              const SizedBox(height: 8),
              //-> Facebook
              Expanded(
                child: ElevatedButton(
                  style: BasicButtonStyle(
                    elevation: 0,
                    backgroundColor: const Color(0xFF3769C9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(FontAwesomeIcons.facebookF, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Continuar com Facebook",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/HomePage');
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

