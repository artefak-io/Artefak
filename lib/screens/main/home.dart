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
        appBar: AppBar(
          title: SvgPicture.asset(
            'assets/logo.svg',
            width: 120,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.notifications_none, size: 25.0),
                onPressed: () {}),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                      ),
                      SubHeadTitle(
                        title: "Sedang Popular",
                      ),
                      Container(
                        height: 200,
                        child: ItemHorizontalScroll(
                          assetStream: _assetStream,
                          isHorizontal: true,
                          heightPhoto: 120,
                          widthPhoto: size.width * 0.80,
                        ),
                      ),
                      SubHeadTitle(
                        title: "Segera Hadir!",
                      ),
                      ItemHorizontalScroll(
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

class ItemHorizontalScroll extends StatelessWidget {
  const ItemHorizontalScroll({
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
                ? BouncingScrollPhysics()
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

  const SubHeadTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Text(title,
              style: _textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          Spacer(),
          TextButton(
            child: Text("Lihat Semua"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
