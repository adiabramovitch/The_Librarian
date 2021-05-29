import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_librarian/screens/floors/floor.dart';
import 'package:the_librarian/screens/user_info_screen.dart';

class WelcomePage extends StatefulWidget {

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {

  // @override
  // void initState(){
  //
  // }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.black,
          body: new InkWell(
            child: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
            /// Paint the area where the inner widgets are loaded with the
            /// background to keep consistency with the screen background
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/lib1.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
          new Expanded(
          flex: 3,
            child: new Container(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                      new Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      ),
                  ],
                )),
              ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /// Loader Animation Widget
                CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.green),
                ),
                Padding(
                padding: const EdgeInsets.only(top: 20.0),
                ),
                Text("Loading"),
              ],
            ),
          ),
          ],
      ),
      ],
      ),
      ),
      );
    }
  }
