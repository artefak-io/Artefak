import 'dart:ui';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/radio_button_filter_item.dart';
import 'package:artefak/widgets/transaction_row_item.dart';
import 'package:flutter/material.dart';

enum TransactionFilter { all, wait, active, missed }

class Transaction extends StatefulWidget {
  Transaction({Key? key}) : super(key: key);

  static const index = 3;

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<CustomRadioModel> filterList = <CustomRadioModel>[];

  @override
  void initState() {
    super.initState();
    filterList.add(new CustomRadioModel(true, 'Semua', 1));
    filterList.add(new CustomRadioModel(false, 'Menunggu Pembayaran', 2));
    filterList.add(new CustomRadioModel(false, 'Koleksi Aktif', 3));
    filterList.add(new CustomRadioModel(false, 'Terlewatkan', 4));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    if (AuthService.user == null) {
      return const Authenticate();
    } else {
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
                      automaticallyImplyLeading: false,
                      title: Text(
                        'Transaksi',
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
                Column(
                  children: [
                    Container(
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
                            child: new RadioButtonFilterItem(filterList[index]),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TransactionRowItem(),
                          SizedBox(
                            height: 16,
                          ),
                          TransactionRowItem(),
                          SizedBox(
                            height: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ],
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
