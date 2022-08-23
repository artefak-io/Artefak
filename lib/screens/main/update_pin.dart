import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/bottom_action_bar.dart';
import 'package:artefak/widgets/desc_collection_review.dart';
import 'package:artefak/widgets/payment_sliding_panel.dart';
import 'package:artefak/widgets/select_card_payment.dart';
import 'package:artefak/widgets/sub_head_title.dart';
import 'package:artefak/widgets/total_collection_review.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return AppLayout(
      appBar: AppBar(
        title: Text(
          'Ubah PIN',
          style: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
        backgroundColor: _themeData.highlightColor,
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
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: _themeData.primaryColorDark,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outlined,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: _themeData.shadowColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 11.0),
                          child: Image.asset(
                            'assets/propict.png',
                            width: 33.0,
                            fit: BoxFit.contain,
                            height: 33.0,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sarah15 mengikutimu",
                              style: _textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "15 menit lalu",
                              style: _textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: _themeData.focusColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide(
                              color: _themeData.focusColor,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          child: Text(
                            "Ikuti",
                            style: _textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SubHeadTitle(
                    title: "Sebelumnya",
                    isSeeAll: false,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: _themeData.shadowColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 11.0),
                          child: Image.asset(
                            'assets/propict.png',
                            width: 33.0,
                            fit: BoxFit.contain,
                            height: 33.0,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sarah15 mengikutimu",
                              style: _textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "15 menit lalu",
                              style: _textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: _themeData.focusColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        ElevatedButton(
                          child: Text(
                            "Bayar",
                            style: _textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(65.0, 32.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              alignment: Alignment.center),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
