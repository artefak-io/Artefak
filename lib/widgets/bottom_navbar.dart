import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({Key? key, required this.currentIndex}) : super(key: key);

  final int currentIndex;

  void _onTap(index, context) {
    switch (index) {
      case 0:
        Navigator.popUntil(context, ModalRoute.withName('/'));
        break;
      case 1:
        Navigator.pushNamed(context, '/bill');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return FloatingNavbar(
      backgroundColor: _themeData.highlightColor,
      selectedItemColor: _themeData.highlightColor,
      onTap: (index) => _onTap(index, context),
      currentIndex: currentIndex,
      items: [
        FloatingNavbarItem(icon: Icons.home, title: 'Home'),
        FloatingNavbarItem(icon: Icons.shopping_cart, title: 'Cart'),
        FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
      ],
    );
  }
}
