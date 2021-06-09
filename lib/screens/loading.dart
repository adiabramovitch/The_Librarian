import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {

  @override
  _WelcomeState createState() => _WelcomeState();

}

class _WelcomeState extends State<WelcomePage> {


  @override
  Widget build(BuildContext context) {

      return Scaffold(
          body: new InkWell(
            child: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                 Container(
                      child: Image.asset("assets/lib1.jpg", fit: BoxFit.cover)
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
