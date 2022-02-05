import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:artefak/services/auth.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        child: ElevatedButton(
          child: const Text('Log out'),
          onPressed: () async {
            _auth.signOut();
          },
        ),
      ),
      bottomNavigationBar: const BotNavBar(),
    );
  }
}
