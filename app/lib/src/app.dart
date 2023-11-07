import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/splash/splash_page.dart';
import 'pages/cadastro/cadastro_page.dart';
import 'pages/login/login_page.dart';
import 'pages/home/home_page.dart';
import 'pages/home/home_page_cont.dart';
import 'pages/mapa/map_static_page.dart';
import 'pages/mapa/maps_page.dart';
import 'pages/perfil/user_page.dart';
import 'pages/config/config_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tem Vaga',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (_) => const SplashScreen(),
        "/SignUpPage": (_) => const SignupPage(),
        "/LoginPage": (_) => const LoginPage(),
        "/HomePage": (_) => const HomePage(),
        "/HomePageCont": (_) => const HomePageCont(),
        "/MapPage": (_) => const MapPage(),
        "/MapPage/MapsGooglePage": (_) => MapsGooglePage(),
        "/UserPage": (_) => const UserPage(),
        "/ConfigPage": (_) => const ConfigPage(),
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
