import 'dart:async';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/card_item_custom.dart';
import '../../widgets/sub_head_title.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _assetStream =
      FirebaseFirestore.instance.collection('Asset').snapshots();

  static const index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title: Image.asset('assets/logoColor.png', width: 100),
                actions: [
                  IconButton(
                      icon: Icon(Icons.notifications_none, size: 25.0),
                      onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  padding: const EdgeInsets.only(left: 16),
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
                        // margin: EdgeInsets.only(right: 16.0),
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
                        widthPhoto: size.width * 0.95,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BotNavBar(
          currentIndex: index,
        ),
      ),
    );
  }
}
