import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:artefak/services/auth.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
            AuthService().signOut();
          },
        ),
      ),
      bottomNavigationBar: const BotNavBar(),
    );
  }
}
