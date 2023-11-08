import 'dart:async';

import 'package:tem_vaga/src/dto/reservationDTO.dart';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import '../mapa/maps_page.dart';

class HomePageCont extends StatefulWidget {
  const HomePageCont({super.key});

  @override
  State<HomePageCont> createState() => _HomePageContState();
}

class _HomePageContState extends State<HomePageCont> {
  late List<Object?> reservations;
  late final DatabaseReference _ReservationValueRef;
  late StreamSubscription<DatabaseEvent> _valueSubscription;

  /** Lista de reservas do usuário. */
  List<ReservationDTO> entries = List<ReservationDTO>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _ReservationValueRef = FirebaseDatabase.instance.ref('reservations/user1');
    try {
      final catchSnapshot = await _ReservationValueRef.get();
      reservations = catchSnapshot.value as List<Object?>;
      this.refreshReservationList();
    } catch (err) {
      debugPrint(err.toString());
    }
    _valueSubscription =
        _ReservationValueRef.onValue.listen((DatabaseEvent event) {
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
    _valueSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 89, 89),
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
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Reservas",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 65, 65, 65),
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(9),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapsGooglePage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            color: Colors.white70),
                        child:
                            Center(child: Text('${entries[index].getName()}')),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
