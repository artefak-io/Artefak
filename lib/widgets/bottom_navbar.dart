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
    return SizedBox(
      height: 80,
      child: BottomNavigationBar(
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
            icon: Icon(Icons.account_circle_outlined),
            label: 'Akun',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) => _onTap(index, context),
      ),
    );
  }
}
