import 'package:flutter/material.dart';

import 'home_page_cont.dart';
import '../config/config_page.dart';
import '../mapa/map_static_page.dart';
import '../perfil/user_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentIndex = 0;

  final screens = [
    HomePageCont(),
    MapPage(),
    UserPage(),
    ConfigPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        // To maintain the state of the pages - keepalive
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF9F150D),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        elevation: 25,
        enableFeedback: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 32, color: Colors.red),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, size: 32, color: Colors.red),
            label: 'Mapa',
            tooltip: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 32, color: Colors.red),
            label: 'Perfil',
            tooltip: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 32, color: Colors.red),
            label: 'Configurações',
            tooltip: 'Configurações',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}
