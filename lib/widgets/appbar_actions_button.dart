
import 'package:flutter/material.dart';

class AppbarActionsButton extends StatelessWidget {
  const AppbarActionsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.notifications_none, size: 28.0),
      onPressed: () => Navigator.pushNamed(
        context,
        '/notification',
      ),
    );
  }
}