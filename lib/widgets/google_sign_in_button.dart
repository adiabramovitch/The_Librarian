import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_librarian/screens/Error.dart';
import 'package:the_librarian/screens/home.dart';
import 'package:the_librarian/screens/sign_in_screen.dart';
import 'package:the_librarian/utils/authentication.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
          onPressed: () async {
            setState(() {
              _isSigningIn = true;
            });

            User? user =
            await Authentication.signInWithGoogle(context: context);

            setState(() {
              _isSigningIn = false;
            });

            if (user != null ){
              String domain = user.email!.substring(user.email!.indexOf('@'));
              if(["@post.bgu.ac.il", "@bgu.ac.il"].contains(domain))
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Home(user)
                  ),
                );
              else{
                setState(() {
                  _isSigningIn = false;
                });

                Authentication.signOut(context: context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => ErrorPage()
                  ),
                );
              }
            }
          },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/google_logo.png"),
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}