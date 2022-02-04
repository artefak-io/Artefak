import 'package:artefak/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sign in'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30.0,
        ),
        child: Row(
          children: [
            FloatingActionButton(
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print('error signing up');
                } else {
                  print(result);
                }
              },
            ),
            const SizedBox(
              width: 40.0,
            ),
            FloatingActionButton(
              backgroundColor: Colors.red[900],
              onPressed: () {
                _auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
