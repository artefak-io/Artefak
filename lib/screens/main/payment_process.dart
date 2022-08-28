import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/appbar_actions_button.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/desc_collection_review.dart';
import 'package:artefak/widgets/detail_payment_process.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentProcess extends StatelessWidget {
  const PaymentProcess({Key? key}) : super(key: key);

  static const index = 3;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    final Map<String, dynamic> _data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Stream<DocumentSnapshot<Map<String, dynamic>>>
        _collectionStreamPayment = FirebaseFirestore.instance
            .collection('Collection')
            .doc(_data['collectionId'])
            .snapshots();

    print(_collectionStreamPayment);

    return AppLayout(
      appBar: AppBar(
        title: Text(
          'Proses Pembayaran',
          style: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
        actions: [
          AppbarActionsButton(),
        ],
        backgroundColor: _themeData.primaryColor,
      ),
      child: SingleChildScrollView(
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
            Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Transaction')
                      .doc(_data['transactionId'])
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return DetailPaymentProcess(data: data);
                    } else if (snapshot.hasError) {
                      return const Text("error");
                    } else {
                      return const Text("please wait");
                    }
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                Divider(
                  height: 0,
                  color: _themeData.cursorColor,
                ),
                DescCollectionReview(
                  collectionStream: _collectionStreamPayment,
                ),
                SizedBox(
                  height: 40.0,
                ),
                ElevatedButton(
                  child: Text(
                    "Lihat Semua Transaksi",
                    style: _textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(size.width * 0.55, 40.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      alignment: Alignment.center),
                  onPressed: () => {
                    Navigator.pushNamed(
                      context,
                      '/bill',
                    ),
                  },
                ),
                SizedBox(
                  height: 49.0,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavBar: const BotNavBar(
        currentIndex: index,
      ),
    );
  }
}
