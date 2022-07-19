import 'dart:async';
import 'dart:ui';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/appbar_actions_button.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/card_item_custom.dart';
import 'package:artefak/widgets/sub_head_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _assetStream =
  FirebaseFirestore.instance.collection('Asset').snapshots();

  static const index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData _themeData = Theme.of(context);

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
                    backgroundColor: _themeData.highlightColor,
                    title: Image.asset('assets/logo_color.png', width: 100),
                    actions: [
                      AppbarActionsButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 64.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubHeadTitle(
                      title: "Proyek Terbaik saat ini",
                      isSeeAll: false,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16),
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubHeadTitle(
                      title: "Sedang Popular",
                      isSeeAll: true,
                    ),
                    Container(
                      height: 200,
                      child: ItemTwoAxisScroll(
                        assetStream: _assetStream,
                        isHorizontal: true,
                        heightPhoto: 120,
                        widthPhoto: size.width * 0.80,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubHeadTitle(
                      title: "Segera Hadir!",
                      isSeeAll: true,
                    ),
                    ItemTwoAxisScroll(
                      assetStream: _assetStream,
                      isHorizontal: false,
                      heightPhoto: 270,
                      widthPhoto: size.width - 32.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BotNavBar(
          currentIndex: Home.index,
        ),
      ),
    );
  }
}
