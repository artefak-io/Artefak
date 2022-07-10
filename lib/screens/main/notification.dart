import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/bottom_action_bar.dart';
import 'package:artefak/widgets/desc_collection_review.dart';
import 'package:artefak/widgets/payment_sliding_panel.dart';
import 'package:artefak/widgets/select_card_payment.dart';
import 'package:artefak/widgets/total_collection_review.dart';
import 'package:flutter/material.dart';

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    final Map<String, dynamic> _data =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return AppLayout(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
        backgroundColor: _themeData.primaryColor,
      ),
      child: Stack(
        children: <Widget>[
        Positioned(
        left: 0,
        right: -120,
        top: -165,
        child: Image.asset(
          'assets/bggrad.png',
          fit: BoxFit.fitHeight,
          height: 350,
        ),
      ),
      SingleChildScrollView(
        child:
            Column(
              children: [
              ],
            ),
        ),
        ],
      ),
    );
  }
}
