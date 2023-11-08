import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/splash/splash_page.dart';
import 'pages/signup/cadastro_page.dart';
import 'pages/login/login_page.dart';
import 'pages/home/home_page.dart';
import 'pages/home/home_page_cont.dart';
import 'pages/establishment/establishment_page.dart';
import 'pages/establishment/parking_page.dart';
import 'pages/map/map_static_page.dart';
import 'pages/map/maps_page.dart';
import 'pages/profile/user_page.dart';
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
        "/HomePage/Establishement": (_) => const EstablishmentPage(),
        "/HomePage/Establishement/Parking": (_) => const ParkingPage(),
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
