import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/services/transaction_service.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/collection_each_item.dart';
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

  late final Stream<QuerySnapshot> _collectionStream;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      _collectionStream =
          TransactionService().personalTransaction(AuthService.user!.uid);
      return AppLayout(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(64.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Koleksi',
                    style: _textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
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
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CollectionEachItem(textTheme: _textTheme, themeData: _themeData)
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
