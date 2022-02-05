import 'package:artefak/services/auth.dart';
import 'package:flutter/material.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({Key? key}) : super(key: key);

  // BottomNavigationBarItem loginChecker() {
  //   if (AuthService.user == null) {
  //     return const BottomNavigationBarItem(
  //       icon: Icon(
  //         Icons.person,
  //       ),
  //       label: 'Login',
  //     );
  //   } else {
  //     return const BottomNavigationBarItem(
  //       icon: Icon(
  //         Icons.person,
  //       ),
  //       label: 'Profile',
  //     );
  //   }
  // }

  void _onTap(index, context) {
    if (AuthService.user == null) {
      Navigator.pushNamed(context, '/authenticate');
    } else {
      switch (index) {
        case 0:
          Navigator.popUntil(context, ModalRoute.withName('/'));
          break;
        case 1:
          Navigator.pushNamed(context, '/transaction');
          break;
        case 2:
          Navigator.pushNamed(context, '/profile');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
          ),
          label: 'Cart',
        ),
        /* loginChecker(), */
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'Profile',
        ),
      ],
      onTap: (index) => _onTap(index, context),
      // (index) {
      //   switch (index) {
      //     case 0:
      //       break;
      //     case 1:
      //       Navigator.pushNamed(context, "/transaction");
      //       break;
      //     default:
      //       break;
      //   }
      // }
    );
  }
}
