import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9F150D),
        toolbarHeight: 98,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                String ?result = null;
                String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                RegExp regex = new RegExp(pattern);
                if (null != value && !value.isEmpty && regex.hasMatch(value)) {
                  result = "Entre com um email válido";
                }
                return result;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
