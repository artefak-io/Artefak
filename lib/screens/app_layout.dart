import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavBar;
  final Key? key;

  const AppLayout({required this.child, this.appBar, this.bottomNavBar, this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) { // TODO: semua page pakai app layout
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        key: key,
        appBar: appBar,
        body: child,
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }
}
