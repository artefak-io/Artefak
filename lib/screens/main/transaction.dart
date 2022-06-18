import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/services/transaction_service.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/radio_button_filter_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum TransactionFilter { all, wait, active, missed }

class Transaction extends StatefulWidget {
  Transaction({Key? key}) : super(key: key);

  static const index = 1;

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<CustomRadioModel> filterList = <CustomRadioModel>[];

  late final Stream<QuerySnapshot> _transactionStream;

  TransactionFilter? _transactionFilter = TransactionFilter.all;

  @override
  void initState() {
    super.initState();
    filterList.add(new CustomRadioModel(false, 'Semua'));
    filterList.add(new CustomRadioModel(false, 'Menunggu Pembayaran'));
    filterList.add(new CustomRadioModel(false, 'Koleksi Aktif'));
    filterList.add(new CustomRadioModel(false, 'Terlewatkan'));
  }


  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme
        .of(context)
        .textTheme;

    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      _transactionStream =
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
                    style:
                    _textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400),
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
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(right: 16.0),
                  height: 32.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return new InkWell(
                        //highlightColor: Colors.red,
                        splashColor: Colors.blueAccent,
                        onTap: () {
                          setState(() {
                            filterList.forEach((element) =>
                            element.isSelected = false);
                            filterList[index].isSelected = true;
                          });
                        },
                        child: new RadioButtonFilterItem(filterList[index]),
                      );
                    },
                  ),
                ),
                Container(
                  child: Text(
                    "Terbaru",
                    style: _textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                // Container(
                //   child: Column(
                //     children: [
                //       Container(
                //         decoration: BoxDecoration(
                //         color: _themeData.shadowColor,
                //           borderRadius: BorderRadius.all(Radius.circular(16)),
                //         ),
                //         height: 80,
                //         alignment: Alignment.centerLeft,
                //         child: Row(
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
