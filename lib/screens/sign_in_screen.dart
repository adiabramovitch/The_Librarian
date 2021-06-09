
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_librarian/widgets/google_sign_in_button.dart';

import '../customcolors.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
        Container(
        child: Image.asset("assets/lib1.jpg", fit: BoxFit.cover)
      ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'BGU Library',
                      style: TextStyle(
                        color: CustomColors.accent_orange,
                        fontSize: 40,
                        fontFamily: 'fonts/Arimo-BoldItalic',
                        height: 1.0
                      ),
                    ),
                    Text(
                      'Seats reservations are available only for BGU students and staff',
                      style: TextStyle(
                        color: CustomColors.accent_orange,
                        fontSize: 20,
                        fontFamily: 'fonts/Arimo-Medium'
                      ),
                      textAlign: TextAlign.center ,
                    ),
                  ],
                ),
             ),
              GoogleSignInButton(),
            ],
          ),
      ],
    ),
        ),
      );
  }
}

