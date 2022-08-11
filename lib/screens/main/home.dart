import 'dart:async';
import 'dart:math';
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

  Random random = new Random();

  final Stream<QuerySnapshot> _collectionStream =
      FirebaseFirestore.instance.collection('Collection').snapshots();

  static const index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;
    int pickOne = random.nextInt(4);

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
                    StreamBuilder<QuerySnapshot>(
                      stream: _collectionStream,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('An error has occurred!',
                                style: _textTheme.bodyMedium),
                          );
                        } else if (snapshot.hasData) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/asset/product_detail',
                                  arguments: <String, dynamic>{
                                    'id': snapshot.data!.docs[pickOne].id,
                                    'creator': snapshot.data!.docs[pickOne]
                                        ['creator'],
                                    'name': snapshot.data!.docs[pickOne]
                                        ['name'],
                                    'description': snapshot.data!.docs[pickOne]
                                        ['description'],
                                    'coverImage': snapshot.data!.docs[pickOne]
                                        ['coverImage'],
                                    'views': snapshot.data!.docs[pickOne]
                                        ['views'],
                                    'price': snapshot.data!.docs[pickOne]
                                        ['price'],
                                  });
                            },
                            // needs loading indicator when image being reloaded
                            child: ItemCardCustom(
                              isHorizontal: false,
                              heightPhoto: 270,
                              widthPhoto: size.width - 32.0,
                              dataEach: snapshot.data!.docs[pickOne],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
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
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: SubHeadTitle(
                        title: "Sedang Popular",
                        isSeeAll: true,
                      ),
                    ),
                    Container(
                      height: 200,
                      child: ItemTwoAxisScroll(
                        assetStream: _collectionStream,
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
                      assetStream: _collectionStream,
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
