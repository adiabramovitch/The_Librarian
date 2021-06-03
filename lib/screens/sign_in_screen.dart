
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
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'BGU Library',
                      style: TextStyle(
                        color: CustomColors.accent_orange,
                        fontSize: 40,
                        fontFamily: 'fonts/Arimo-BoldItalic'
                      ),
                    ),
                    Text(
                      'Seats reservations are available only for BGU students and stuff',
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
          ) ,
        ),
      ),
    );
  }
}

