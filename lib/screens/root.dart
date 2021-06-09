
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_librarian/screens/loading.dart';
import 'package:the_librarian/screens/sign_in_screen.dart';
import 'package:the_librarian/utils/authentication.dart';
import 'Error.dart';
import 'home.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}


class _RootState extends State<Root> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Authentication.initializeFirebase(context: context).then(_setIsAuth);
  }

   void _setIsAuth(fba) {
    setState(() {
      _isLoading = false;
    });
  }
  Widget build(BuildContext context) {
    return _isLoading ? WelcomePage()
        :  FirebaseAuth.instance.currentUser != null ? Home(FirebaseAuth.instance.currentUser as User) : SignInScreen();
  }

}