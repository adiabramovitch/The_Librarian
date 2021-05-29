import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:the_librarian/screens/floors/floor.dart';
import 'package:the_librarian/screens/home.dart';
import 'package:the_librarian/screens/root.dart';

import 'screens/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final dbRef = FirebaseDatabase.instance.reference();
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterFire Samples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: Root(),
      routes: {
        '/floor-1': (context) => Floor(floorInd: -1),
        '/floor0': (context) => Floor(floorInd: 0),
        '/floor3': (context) => Floor(floorInd: 3),
        '/floor4': (context) => Floor(floorInd: 4),
        '/floor5': (context) => Floor(floorInd: 5),
      }
    );
  }
}