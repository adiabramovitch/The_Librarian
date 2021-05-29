import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



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

  _Floor1State(this.floorInd);
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: db.child('floors/$floorInd').onValue,
        builder: (BuildContext context, AsyncSnapshot<Event> snapshot){
          if(snapshot.hasData){
            var values = snapshot.data!.snapshot.value;
            var seats = values["seats"];
            var rowSize = values['rowSize'];
            var columnSize = values['columnSize'];
            var floorSize = values['floorSize'];

            List<Widget> stackChildren =
            List.generate(floorSize, (i) => seats[i]==null ? Seat(index: i, available: null, db: db, floorInd: floorInd,) : Seat(index: i, available: seats[i]["state"], db: db, startData: seats[i]["startDate"], takenBy: seats[i]["user"], floorInd: floorInd));
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
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
              // backgroundColor: Colors.blue[100],
              body: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/black.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    GridView.count(
                        crossAxisCount: rowSize,
                        padding: EdgeInsets.all(10),
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                        children: stackChildren
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ErrorWidget.withDetails();
          }

        }
    );
  }
}


class Seat extends StatefulWidget {
  final int index;
  final bool? available;
  int startData;
  String takenBy;
  int floorInd;
  final DatabaseReference db;


  Seat({Key? key, required this.index, required this.available, required this.db, this.startData: 0, this.takenBy: "", required this.floorInd}) : super (key: key);
  @override
  _Seat createState() => _Seat(this.available);
}

class _Seat extends State<Seat>{
  late bool state;
  User user = FirebaseAuth.instance.currentUser as User;

  _Seat(avaliable);

  void updateState(newState){
    state = newState;
    widget.db.child('floors/${widget.floorInd}/seats/${widget.index}/state').set(state);
  }

  void updateAvailable(){
    if(widget.available != null){
      state = widget.available as bool;
    }
  }

  void initState(){
    super.initState();
    state = widget.available == null ||
            widget.available == false
            ? Duration(milliseconds: (DateTime.now().millisecondsSinceEpoch - widget.startData) ).inHours > 2 ? true : false
            : true;
  }
  
  Color updateColor(state){
    if (widget.available == null)
      return Colors.transparent;
    
    return (state == false) && (widget.takenBy.compareTo(user.email as String) == 0) ? Colors.lightBlue 
        : state ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    // print("build seat ${widget.index}, ${widget.available}");
    updateAvailable();
    return Container(
      child: InkWell(
        onTap: widget.available == null ? null : () => {
          setState(() => {
            if (state) {
              // print(widget.db.child('users/${user.email!.substring(0,user.email!.indexOf('@'))}').key),

              widget.db.child('users/${user.email!.substring(0,user.email!.indexOf('@'))}').once().then((value){
                if(value.value == null){
                  widget.db.child('users/${user.email!.substring(0,user.email!.indexOf('@'))}').set({"floor": widget.floorInd, "seat":widget.index}).then((value) =>
                  widget.db.child('floors/${widget.floorInd}/seats/${widget.index}/user').set(user.email).then((value) =>
                      widget.db.child('floors/${widget.floorInd}/seats/${widget.index}/startDate').set(
                          DateTime
                              .now()
                              .millisecondsSinceEpoch).then((value)=>
                          widget.db.child('floors/${widget.floorInd}/seats/${widget.index}/state').set(false))));
                }
              })
            }
            else{ // seat is taken
              if(widget.takenBy.compareTo(user.email as String) == 0){
                widget.db.child('users/${user.email!.substring(0,user.email!.indexOf('@'))}').remove().then((value) =>
                widget.db.child('floors/${widget.floorInd}/seats/${widget.index}/state').set(true).then((value) =>
                widget.db.child('floors/${widget.floorInd}/seats/${widget.index}/user').set("").then((value) =>
                  widget.db.child('floors/${widget.floorInd}/seats/${widget.index}/startDate').set(0)))),
              },
           },
        })
      },
        child: widget.available == null ? null :
        Align(
          alignment: Alignment.center,
          child: Text(widget.index.toString()),
        ),
      ),
      height: 60,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: updateColor(state),
      ),
    );
  }
}