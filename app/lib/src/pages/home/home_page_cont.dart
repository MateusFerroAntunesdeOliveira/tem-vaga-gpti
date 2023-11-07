import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class HomePageCont extends StatefulWidget {
  const HomePageCont({super.key});

  @override
  State<HomePageCont> createState() => _HomePageContState();
}

class _HomePageContState extends State<HomePageCont> {
  int _times = 0;
  late final DatabaseReference _counterRef;
  late StreamSubscription<DatabaseEvent> _counterSubscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _counterRef = FirebaseDatabase.instance.ref('counter');
    try {
      final countSnapshot = await _counterRef.get();
      _times = countSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    _counterSubscription = _counterRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _times = (event.snapshot.value ?? 0) as int;
      });
    });
  }

  timeCounter() async {
    await _counterRef.set(ServerValue.increment(1));
  }

  @override
  void dispose() {
    _counterSubscription.cancel();
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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: timeCounter, icon: const Icon(Icons.add)),
            Text(_times.toString(), style: const TextStyle(fontSize: 24))
          ],
        ),
      ),
    );
  }
}
