import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'parking_page.dart';

class EstablishmentPage extends StatefulWidget {
  const EstablishmentPage({super.key});

  @override
  State<EstablishmentPage> createState() => _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage> {
  final Widget svg1 = SvgPicture.asset(
    "assets/images/Establishments/Estacionamento_PUC_1.svg",
    fit: BoxFit.cover,
  );
  final Widget svg2 = SvgPicture.asset(
    "assets/images/Establishments/Estacionamento_PUC_2.svg",
    fit: BoxFit.cover,
  );

  List<bool> _parkingSpot = List<bool>.generate(18, (index) => true);
  late StreamSubscription<DatabaseEvent> _valueParkingSpotSubscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    DatabaseReference _parkingSpotValueRef = FirebaseDatabase.instance.ref('establishments/PUCPR/');
    DatabaseEvent event = await _parkingSpotValueRef.once();
    var snapshot = event.snapshot;
    snapshot.children.forEach((child) {
      _parkingSpot.add(child.value as bool);
    });

    _valueParkingSpotSubscription = _parkingSpotValueRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        var snapshot = event.snapshot;
        _parkingSpot.clear();
        snapshot.children.forEach((child) {
          _parkingSpot.add(child.value as bool);
        });
      });
    });
  }

  @override
  void dispose() {
    _valueParkingSpotSubscription.cancel();
    super.dispose();
  }

  Widget _customText({required String title, required String description}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
        Text(
          description,
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black45,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }

  Widget _customInfo({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'Montserrat',
      ),
    );
  }

  Widget _customMap() {
    return GestureDetector(
      child: Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: svg1),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ParkingPage()),
      ),
    );
  }

  Widget _customMap2() {
    return GestureDetector(
      child: Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: svg2),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ParkingPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9F150D),
        toolbarHeight: 98,
        title: const Text(
          // Pegar nome do estabelecimento que está no firebase
          "PUCPR",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    _customText(title: "Nome:", description: "Estacionamento A"),
                    const SizedBox(height: 8),
                    _customText(title: "Entrada:", description: "Portão 02"),
                    const SizedBox(height: 8),
                    _customText(title: "Rua:", description: "Imaculada Conceição"),
                    const SizedBox(height: 8),
                    _customText(title: "Bairro:", description: "Padro Velho"),
                    const SizedBox(height: 8),
                    _customText(title: "Contato:", description: "+55 (41) 3642-5261"),
                    const SizedBox(height: 16),
                    _customMap(),
                    const SizedBox(height: 16),
                    _customInfo(title: "Informações das vagas"),
                    const SizedBox(height: 16),
                    _customText(
                      title: "Vagas totais:",
                      description: _parkingSpot.length.toString(),
                    ),
                    const SizedBox(height: 8),
                    _customText(
                      title: "Vagas ocupadas/reservadas:",
                      description: _parkingSpot.where((element) => element).length.toString(),
                    ),
                    const SizedBox(height: 8),
                    _customText(
                      title: "Vagas disponíveis:",
                      description: _parkingSpot.where((element) => !element).length.toString(),
                    ),
                    const SizedBox(height: 16),

                    // Divisao dos estacionamentos do estabelecimento (PUCPR)
                    const Divider(thickness: 1, color: Colors.black54),

                    const SizedBox(height: 32),
                    _customText(title: "Nome:", description: "Estacionamento D"),
                    const SizedBox(height: 8),
                    _customText(title: "Entrada:", description: "Portão 04"),
                    const SizedBox(height: 8),
                    _customText(title: "Rua:", description: "Senador Salgado Filho"),
                    const SizedBox(height: 8),
                    _customText(title: "Bairro:", description: "Padro Velho"),
                    const SizedBox(height: 8),
                    _customText(title: "Contato:", description: "+55 (41) 2500-0478"),
                    const SizedBox(height: 16),
                    _customMap2(),
                    const SizedBox(height: 16),
                    _customInfo(title: "Informações das vagas"),
                    const SizedBox(height: 16),
                    _customText(title: "Vagas totais:", description: "20"),
                    const SizedBox(height: 8),
                    _customText(title: "Vagas ocupadas/reservadas:", description: "11"),
                    const SizedBox(height: 8),
                    _customText(title: "Vagas disponíveis:", description: "09"),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
