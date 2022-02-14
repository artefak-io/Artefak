import 'package:artefak/screens/authentication/sign_in.dart';
import 'package:artefak/screens/authentication/sign_up.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    print('this should work');

    setState(() {
      showSignIn = !showSignIn;
    });

    print('showsignin is $showSignIn');
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(
        toggleView: toggleView,
      );
    } else {
      return SignUp(
        toggleView: toggleView,
      );
    }
  }
}
