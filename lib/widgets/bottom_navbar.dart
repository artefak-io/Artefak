import 'dart:ui';

import 'package:flutter/material.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({Key? key, required this.currentIndex}) : super(key: key);

  final int currentIndex;

  void _onTap(index, context) {
    switch (index) {
      case 0:
        Navigator.popUntil(context, ModalRoute.withName('/'));
        break;
      case 1:
        Navigator.pushNamed(context, '/collection');
        break;
      case 2:
        Navigator.pushNamed(context, '/like');
        break;
      case 3:
        Navigator.pushNamed(context, '/transaction');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: _themeData.highlightColor,
            selectedItemColor: _themeData.textSelectionColor,
            unselectedItemColor: _themeData.unselectedWidgetColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2),
                label: 'Koleksi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded),
                label: 'Suka',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Akun',
              ),
            ],
            currentIndex: currentIndex,
            onTap: (index) => _onTap(index, context),
          ),
        ),
      ),
    );
  }
}
