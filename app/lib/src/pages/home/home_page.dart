import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
          "Home Screen",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pushReplacementNamed('/LoginPage'),
          ),
          const SizedBox(width: 16),
        ],
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
