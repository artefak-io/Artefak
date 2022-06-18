import 'package:artefak/screens/authentication/input_phone.dart';
import 'package:artefak/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const InputPhone();
    return SignIn(toggleView: (){});
  }
}
