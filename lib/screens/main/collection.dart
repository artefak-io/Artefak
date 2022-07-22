import 'dart:ui';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/widgets/appbar_actions_button.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/collection_row_item.dart';
import 'package:artefak/widgets/qr_ticket_sliding_panel.dart';
import 'package:artefak/widgets/radio_button_filter_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Collection extends StatefulWidget {
  Collection({Key? key}) : super(key: key);

  static const index = 1;

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  List<CustomRadioModel> filterList = <CustomRadioModel>[];

  late final Stream<QuerySnapshot> _assetStream;

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.5,
            maxChildSize: 0.6,
            builder:
                (BuildContext context, ScrollController scrollController) =>
                    QrTicketSlidingPanel(
              scrollController: scrollController,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      _assetStream = FirebaseFirestore.instance.collection('Asset').snapshots();
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
                        'Koleksi',
                        style: _textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
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
            child: Stack(
              children: <Widget>[
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 64.0,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: _assetStream,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('An error has occurred!',
                                    style: _textTheme.bodyMedium),
                              );
                            } else if (snapshot.hasData) {
                              return MediaQuery.removePadding(
                                removeTop: true,
                                context: context,
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  scrollDirection: Axis.vertical,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/asset/asset_detail',
                                            arguments: <String, dynamic>{
                                              'id':
                                                  snapshot.data!.docs[index].id,
                                              'currentOwner': snapshot.data!
                                                  .docs[index]['currentOwner'],
                                              'creator': snapshot
                                                  .data!.docs[index]['creator'],
                                              'name': snapshot.data!.docs[index]
                                                  ['name'],
                                              'description': snapshot.data!
                                                  .docs[index]['description'],
                                              'coverImage': snapshot.data!
                                                  .docs[index]['coverImage'],
                                              'views': snapshot
                                                  .data!.docs[index]['views'],
                                              'contractAddress':
                                                  snapshot.data!.docs[index]
                                                      ['contractAddress'],
                                              'tokenId': snapshot
                                                  .data!.docs[index]['tokenId'],
                                              'price': snapshot
                                                  .data!.docs[index]['price'],
                                            });
                                      },
                                      // needs loading indicator when image being reloaded
                                      child: CollectionRowItem(
                                        onPressedShowTicket: _showDialog,
                                        dataItem: snapshot.data!.docs[index],
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                      SizedBox(
                        height: 80.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BotNavBar(
            currentIndex: Collection.index,
          ),
        ),
      );
    }
  }
}
