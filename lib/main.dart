import 'package:flutter/material.dart';
import 'package:the_librarian/screens/floor.dart';
import 'package:the_librarian/screens/root.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BGU Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'fonts/Arimo-Regular',
        primarySwatch: Colors.grey,
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

