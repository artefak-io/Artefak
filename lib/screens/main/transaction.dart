import 'dart:ui';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/widgets/appbar_actions_button.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/radio_button_filter_item.dart';
import 'package:artefak/widgets/transaction_row_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TransactionFilter {
  static const all = 'all';
  static const pending = 'pending';
  static const completed = 'completed';
  static const missed = 'missed';
}

class Status {
  static const all = 'Semua';
  static const pending = 'Menunggu Pembayaran';
  static const completed = 'Selesai';
  static const missed = 'Terlewatkan';
}

class Transaction extends StatefulWidget {
  Transaction({Key? key}) : super(key: key);

  static const index = 3;

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction>
    with TickerProviderStateMixin {
  List<CustomRadioModel> filterList = <CustomRadioModel>[];
  Query<Map<String, dynamic>> _transactionStream = FirebaseFirestore.instance
      .collection('Transaction')
      .where("buyerId", isEqualTo: AuthService.user!.uid);
  late Stream<QuerySnapshot> _querySnapshotTransaction;

  final ScrollController _scrollController = ScrollController();
  late final AnimationController _filterAnimationController =
      AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 400),
  );
  bool visible = true;

  @override
  void initState() {
    super.initState();
    filterList
        .add(new CustomRadioModel(true, Status.all, TransactionFilter.all));
    filterList.add(
        new CustomRadioModel(false, Status.pending, TransactionFilter.pending));
    filterList.add(new CustomRadioModel(
        false, Status.completed, TransactionFilter.completed));
    filterList.add(
        new CustomRadioModel(false, Status.missed, TransactionFilter.missed));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;

    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      for (var element in filterList) {
        if (element.isSelected) {
          if (element.keyVal.toString() == TransactionFilter.all) {
            _querySnapshotTransaction = _transactionStream.snapshots();
          } else {
            _querySnapshotTransaction = _transactionStream
                .where("status", isEqualTo: element.keyVal.toString())
                .snapshots();
          }
        }
      }
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
                      elevation: 1,
                      toolbarHeight: 64.0,
                      automaticallyImplyLeading: false,
                      title: Text(
                        'Transaksi',
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
          body: Container(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  right: -120,
                  top: -85,
                  child: Container(
                    height: 400,
                    width: 400,
                    child: Image.asset(
                      'assets/bggrad.png',
                      fit: BoxFit.fitHeight,
                      height: 350,
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  child: Container(
                    height: size.height,
                    width: size.width,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (_scrollController.hasClients) {
                          if (_scrollController.position.userScrollDirection ==
                              ScrollDirection.reverse) {
                            _filterAnimationController.forward();
                          } else if (_scrollController
                                  .position.userScrollDirection ==
                              ScrollDirection.forward) {
                            _filterAnimationController.reverse();
                          }
                        }
                        return true;
                      },
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 128.0,
                                  left: 16.0,
                                  right: 16.0,
                                  bottom: 24.0),
                              child: Column(
                                children: [
                                  StreamBuilder<QuerySnapshot>(
                                    stream: _querySnapshotTransaction,
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            scrollDirection: Axis.vertical,
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      '/payment_process',
                                                      arguments: <String,
                                                          dynamic>{
                                                        'codeSale': 0,
                                                        'transactionId':
                                                            snapshot.data!
                                                                .docs[index].id,
                                                        'collectionId': snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['collectionId'],
                                                      });
                                                },
                                                // needs loading indicator when image being reloaded
                                                child: TransactionRowItem(
                                                  transactionItem: snapshot
                                                      .data!.docs[index],
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
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: 112.0,
                    width: size.width,
                    child: SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset.zero, end: Offset(0, -1))
                              .animate(
                        CurvedAnimation(
                            parent: _filterAnimationController,
                            curve: Curves.fastOutSlowIn),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
                        margin: EdgeInsets.only(top: 64.0),
                        height: 48.0,
                        color: _themeData.primaryColorDark,
                        child: ListView.builder(
                          itemCount: filterList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  filterList.forEach(
                                      (element) => element.isSelected = false);
                                  filterList[index].isSelected = true;
                                });
                              },
                              child:
                                  new RadioButtonFilterItem(filterList[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BotNavBar(
            currentIndex: Transaction.index,
          ),
        ),
      );
    }
  }
}
