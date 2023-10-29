import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/splash/splash_page.dart';
import 'pages/login/login_page.dart';
import 'pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tem Vaga',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (_) => const SplashScreen(),
        "/LoginPage": (_) => const LoginPage(),
        "/HomePage": (_) => const HomePage(),
      },
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      locale: const Locale('pt', 'BR'),
    );
  }
}