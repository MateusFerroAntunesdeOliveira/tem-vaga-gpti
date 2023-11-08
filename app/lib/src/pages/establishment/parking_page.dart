import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ParkingPage extends StatefulWidget {
  const ParkingPage({super.key});

  @override
  State<ParkingPage> createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingPage> {
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

  Widget _buildSensor({required int index}) {
    return Positioned(
      top: 49 * ((index + 1) / 2).ceilToDouble(),
      right: index % 2 != 0 ? 32 : null,
      left: index % 2 == 0 ? 32 : null,
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: (_parkingSpot[index]) ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black45,
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget svg1() => Stack(
        children: [
          SvgPicture.asset(
            "assets/images/Establishments/Estacionamento_PUC_1_1.svg",
            fit: BoxFit.contain,
            color: Colors.white,
            colorBlendMode: BlendMode.colorBurn,
          ),
          ...List.generate(_parkingSpot.length, (index) => _buildSensor(index: index)),
        ],
      );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9F150D),
        toolbarHeight: 98,
        title: const Text(
          "Mapa",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              svg1(),
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
            ],
          ),
        ),
      ),
    );
  }
}
