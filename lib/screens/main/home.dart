import 'dart:async';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/card_item_custom.dart';

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
                title: SvgPicture.asset(
                  'assets/logo.svg',
                  width: 100,
                ),
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
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SubHeadTitle(
                        title: "Proyek Terbaik saat ini",
                        isSeeAll: false,
                      ),
                      SubHeadTitle(
                        title: "Sedang Popular",
                        isSeeAll: true,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16.0),
                        height: 200,
                        child: ItemTwoAxisScroll(
                          assetStream: _assetStream,
                          isHorizontal: true,
                          heightPhoto: 120,
                          widthPhoto: size.width * 0.80,
                        ),
                      ),
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

class ItemTwoAxisScroll extends StatelessWidget {
  const ItemTwoAxisScroll({
    Key? key,
    required Stream<QuerySnapshot<Object?>> assetStream,
    required this.isHorizontal,
    required this.heightPhoto,
    required this.widthPhoto,
  })  : _assetStream = assetStream,
        super(key: key);

  final Stream<QuerySnapshot<Object?>> _assetStream;
  final bool isHorizontal;
  final double heightPhoto, widthPhoto;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _assetStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
            physics: isHorizontal
                ? ClampingScrollPhysics()
                : NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/asset',
                        arguments: <String, dynamic>{
                          'id': snapshot.data!.docs[index].id,
                          'currentOwner': snapshot.data!.docs[index]
                              ['currentOwner'],
                          'creator': snapshot.data!.docs[index]['creator'],
                          'name': snapshot.data!.docs[index]['name'],
                          'description': snapshot.data!.docs[index]
                              ['description'],
                          'coverImage': snapshot.data!.docs[index]
                              ['coverImage'],
                          'views': snapshot.data!.docs[index]['views'],
                          'contractAddress': snapshot.data!.docs[index]
                              ['contractAddress'],
                          'tokenId': snapshot.data!.docs[index]['tokenId'],
                          'price': snapshot.data!.docs[index]['price'],
                        });
                  },
                  // needs loading indicator when image being reloaded
                  child: ItemCardCustom(
                    isHorizontal: isHorizontal,
                    heightPhoto: heightPhoto,
                    widthPhoto: widthPhoto,
                    dataEach: snapshot.data!.docs[index],
                  ));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class SubHeadTitle extends StatelessWidget {
  final String title;
  final bool isSeeAll;

  const SubHeadTitle({
    Key? key,
    required this.title,
    required this.isSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: _textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          Spacer(),
          isSeeAll
              ? TextButton(
                  child: Text(
                    "Lihat Semua",
                    style: _textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700, color: Color(0xFF7CA1F3)),
                  ),
                  onPressed: () {},
                )
              : Container(),
        ],
      ),
    );
  }
}
