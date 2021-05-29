


import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_librarian/screens/loading.dart';
import 'package:the_librarian/screens/sign_in_screen.dart';
import 'package:the_librarian/utils/authentication.dart';
import 'package:the_librarian/widgets/google_sign_in_button.dart';

import '../customcolors.dart';
import 'home.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}


class _RootState extends State<Root> {
  bool _isAuth = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Authentication.initializeFirebase(context: context).then(_setIsAuth);
    // setState(() {
    //
    // });
  }

   void _setIsAuth(fba) {
    sleep(Duration(seconds: 2));
    // _isAuth = FirebaseAuth.instance.currentUser != null ? true : false;
    setState(() {
      _isLoading = false;
    });
  }
  Widget build(BuildContext context) {
    // Authentication.initializeFirebase(context: context); // future stuff to be fixed

    return _isLoading ? WelcomePage()
        :  FirebaseAuth.instance.currentUser != null ? Home(FirebaseAuth.instance.currentUser as User) : SignInScreen();
    // if (getCurrentUser() == null)
    //   return SignInScreen();
    // else
    //   return Home();
    // return SignInScreen();
  }

}