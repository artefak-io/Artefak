import 'dart:ui';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/under_construction_page.dart';
import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  static const index = 2;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return AppLayout(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                  ),
                  child: AppBar(
                    toolbarHeight: 64.0,
                    automaticallyImplyLeading: false,
                    title: Text(
                      'Suka',
                      style: _textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.notifications_none, size: 25.0),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: -120,
              top: -85,
              child: Image.asset(
                'assets/bggrad.png',
                fit: BoxFit.fitHeight,
                height: 350,
              ),
            ),
            UnderConstructionPage(
              onClickHome: () => Navigator.pushNamed(
                context,
                '/',
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BotNavBar(
          currentIndex: index,
        ),
      ),
    );
  }
}
