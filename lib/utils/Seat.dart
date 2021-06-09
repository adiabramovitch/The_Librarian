
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Seat extends StatefulWidget {
  final int index;
  final bool? available;
  int startDate;
  String takenBy;
  int floorInd;
  final DatabaseReference db;

  Seat(
      {Key? key,
        required this.index,
        required this.available,
        required this.db,
        this.startDate: 0,
        this.takenBy: "",
        required this.floorInd})
      : super(key: key);

  @override
  _Seat createState() => _Seat(this.available);
}

class _Seat extends State<Seat> {
  late bool state;
  User user = FirebaseAuth.instance.currentUser as User;

  _Seat(avaliable);

  void updateState(newState) {
    state = newState;
    widget.db
        .child('floors/${widget.floorInd}/seats/${widget.index}/state')
        .set(state);
  }

  void updateAvailable() {
    if (widget.available != null) {
      state = widget.available as bool;
    }
  }

  void initState() {
    super.initState();
    state = widget.available == null || widget.available == false
        ? Duration(
        milliseconds: (DateTime.now().millisecondsSinceEpoch -
            widget.startDate))
        .inHours >
        2
        ? true
        : false
        : true;
  }

  Color updateColor(state) {
    if (widget.available == null) return Colors.transparent;

    return (state == false) &&
        (widget.takenBy.compareTo(user.email as String) == 0)
        ? Colors.lightBlue
        : state
        ? Colors.green
        : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    // print("build seat ${widget.index}, ${widget.available}");
    updateAvailable();

    return Container(
      child: InkWell(
        onTap: widget.available == null
            ? null
            : () => {
          setState(() => {
            if (state)
              {
                // print(widget.db.child('users/${user.email!.substring(0,user.email!.indexOf('@'))}').key),

                widget.db
                    .child(
                    'users/${user.email!.substring(0, user.email!.indexOf('@'))}')
                    .once()
                    .then((value) {
                  if (value.value == null) {
                    widget.db.child('users/${user.email!.substring(0, user.email!.indexOf('@'))}').set({
                      "floor": widget.floorInd,
                      "seat": widget.index
                    }).then((value) => widget.db
                        .child(
                        'floors/${widget.floorInd}/seats/${widget.index}/user')
                        .set(user.email)
                        .then((value) => widget.db
                        .child(
                        'floors/${widget.floorInd}/seats/${widget.index}/startDate')
                        .set(DateTime.now()
                        .millisecondsSinceEpoch)
                        .then((value) => widget.db.child('floors/${widget.floorInd}/seats/${widget.index}/state').set(false))));
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        content:
                        '${user.displayName}, you booked seat number ${widget.index} from ${DateTime.now().hour} until ${DateTime.now().hour + 2}',
                      ),
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        content:
                        '${user.displayName}, you already booked seat number ${value.value['seat']} in floor ${value.value['floor']}',
                      ),
                    );
                  }
                })
              }
            else
              {
                // seat is taken
                if (widget.takenBy
                    .compareTo(user.email as String) ==
                    0)
                  {
                    widget.db
                        .child(
                        'users/${user.email!.substring(0, user.email!.indexOf('@'))}')
                        .remove()
                        .then((value) => widget.db
                        .child(
                        'floors/${widget.floorInd}/seats/${widget.index}/state')
                        .set(true)
                        .then((value) => widget.db
                        .child(
                        'floors/${widget.floorInd}/seats/${widget.index}/user')
                        .set("")
                        .then((value) => widget.db
                        .child(
                        'floors/${widget.floorInd}/seats/${widget.index}/startDate')
                        .set(0)))),
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        content:
                        '${user.displayName}, you canceled your reservation to  seat number ${widget.index}',
                      ),
                    )
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        content:
                        'Sorry ${user.displayName}, seat ${widget.index} is already taken ',
                      ),
                    )
                  }
              },
          }),
        },
        child: widget.available == null
            ? null
            : Align(
          alignment: Alignment.center,
          // child: Text(
          //   widget.index.toString(),
          //   style: TextStyle(
          //       fontFamily: 'fonts/Arimo-Regular', fontSize: 10),
          // ),
        ),
      ),
      // height: 60,
      // width: 30,
      // padding: EdgeInsets.all(100.0),
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border:  widget.available == null
            ? null
            : Border.all(
          color: Colors.white,
          width: 2,
        ),
        color: updateColor(state),
      ),
    );
  }

  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.white60, letterSpacing: 0.5),
      ),
    );
  }
}
