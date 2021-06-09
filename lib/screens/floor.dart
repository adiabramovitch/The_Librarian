import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_librarian/utils/Seat.dart';
import 'package:the_librarian/utils/table.dart';

class Floor extends StatefulWidget {
  final int floorInd;

  Floor({Key? key, required this.floorInd}) : super(key: key);

  @override
  _Floor1State createState() => _Floor1State(floorInd);
}

class _Floor1State extends State<Floor> {
  final int floorInd;
  final db = FirebaseDatabase.instance.reference();
  User user = FirebaseAuth.instance.currentUser as User;
  late List<Widget> stChild;
  double leftImage = 0.0;

  _Floor1State(this.floorInd);

  @override
  void initState() {
    super.initState();
    leftImage = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.child('floors/$floorInd').onValue,
        builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            var values = snapshot.data!.snapshot.value;
            var seats = values["seats"];
            var tables = values["tables"];
            var rowSize = values['rowSize'];
            // var imageURL = values['imageURL'];
            var imageHeight = values['imageHeight'].toDouble();
            var imageWidth = values['imageWidth'].toDouble();
            int floorSize = values['floorSize'];
            List<Widget> tablesstack = List.generate(tables.length, (index) => Tables(index: index));
            List<Widget> stackChildren = List.generate(
                floorSize,
                (i) => seats[i.toString()] == null
                    ? Seat(
                        index: i,
                        available: null,
                        db: db,
                        floorInd: floorInd,
                      )
                    : Container(
                    color: Colors.brown[100],
                    child:Seat(
                        index: i,
                        available: seats[i.toString()]["state"],
                        db: db,
                        startDate: seats[i.toString()]["startDate"],
                        takenBy: seats[i.toString()]["user"],
                        floorInd: floorInd),),
                growable: true);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white70,
                title: Text(
                  'FLOOR ' + floorInd.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              body: NotificationListener(
                onNotification: (v) {
                  if (v is ScrollUpdateNotification) {
                    setState(() {
                      leftImage -= v.scrollDelta!;
                    });
                  }
                  return true;
                },
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: leftImage,
                        top: 0,
                        child: Container(
                          height: imageHeight,
                          width: imageWidth,
                          child: Image.asset("assets/white1.jpg", fit: BoxFit.cover)
                        ),
                      ),
                      GridView.count(
                          scrollDirection: Axis.horizontal,
                          crossAxisCount: rowSize,
                          padding: EdgeInsets.all(10),
                          children: stackChildren ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return ErrorWidget.withDetails();
          }
        });
  }
}
