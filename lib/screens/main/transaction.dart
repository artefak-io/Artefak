import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  const Transaction({Key? key}) : super(key: key);

  static const index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
      ),
      body: Container(),
      bottomNavigationBar: const BotNavBar(
        currentIndex: index,
      ),
    );
  }
}
