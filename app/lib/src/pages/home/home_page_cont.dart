import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import '../../dto/reservationDTO.dart';
import '../establishment/establishment_page.dart';

class HomePageCont extends StatefulWidget {
  const HomePageCont({super.key});

  @override
  State<HomePageCont> createState() => _HomePageContState();
}

class _HomePageContState extends State<HomePageCont> {
  late List<Object?> reservations;
  late final DatabaseReference _reservationValueRef;
  late StreamSubscription<DatabaseEvent> _valueReservationSubscription;

  /* Lista de reservas do usuário. */
  List<ReservationDTO> entries = List<ReservationDTO>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _reservationValueRef = FirebaseDatabase.instance.ref('reservations/user1');
    try {
      final catchReservation = await _reservationValueRef.get();
      reservations = catchReservation.value as List<Object?>;
      this.refreshReservationList();
    } catch (err) {
      debugPrint(err.toString());
    }
    _valueReservationSubscription = _reservationValueRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        reservations = (event.snapshot.value ?? " ") as List<Object?>;
        this.refreshReservationList();
      });
    });
  }

  void refreshReservationList() {
    entries.clear();
    //loop over mapped object collection
    reservations.forEach((reservation) {
      if (null != reservation) {
        entries.add(ReservationDTO.fromJson(reservation));
      }
    });
  }

  @override
  void dispose() {
    _valueReservationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9F150D),
        toolbarHeight: 98,
        title: const Text(
          "Tela Inicial",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Estabelecimentos cadastrados",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EstablishmentPage()),
                    );
                  },
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black38),
                      color: Colors.white70,
                    ),
                    child: Center(
                      child: Text('${entries[index].getName()}',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
