import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_librarian/utils/Seat.dart';

class Tables extends StatefulWidget {
  final int index;
  Tables({Key? key, required this.index}) : super(key: key);

  @override
  _TableState createState() => _TableState(index);
}

class _TableState extends State<Tables> {
  final int index;

  _TableState(this.index);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown
    );
  }
}
