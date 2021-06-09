import 'package:flutter/material.dart';
import 'package:the_librarian/widgets/google_sign_in_button.dart';

class ErrorPage extends StatefulWidget {
  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<ErrorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: new InkWell(
        child: new Stack(
          fit: StackFit.expand,
            children: <Widget>[
       Container(
            child: Image.asset("assets/lib1.jpg", fit: BoxFit.cover)),
       Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text("Authentication was not completed please try again"),
              ],
            ),
          ),
        GoogleSignInButton(),
        ],
      )
      ],
    ),
    ),
    );
  }
}
