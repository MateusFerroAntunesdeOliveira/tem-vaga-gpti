import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 182, 182, 182),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      color: Color.fromARGB(255, 53, 53, 53),
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
                    child:
                        Image.asset("assets/images/Logo_TemVaga-semFundo.png"),
                  ),
                ),
              ),
              TextFormField(
                  decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Login',
              )),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Senha',
                ),
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/HomePage');
                },
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
