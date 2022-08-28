import 'package:artefak/main.dart';
import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/services/quick_transaction_service.dart';
import 'package:artefak/widgets/bottom_action_bar.dart';
import 'package:artefak/widgets/desc_collection_review.dart';
import 'package:artefak/widgets/payment_sliding_panel.dart';
import 'package:artefak/widgets/select_card_payment.dart';
import 'package:artefak/widgets/total_collection_review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CollectionReview extends StatefulWidget {
  const CollectionReview({Key? key}) : super(key: key);

  @override
  State<CollectionReview> createState() => _CollectionReviewState();
}

List<PaymentChoice> listAllMethod = [
  PaymentChoice(0, title: 'VA BCA', bankPathAsset: "assets/bank_bca.png"),
  PaymentChoice(1,
      title: 'VA Mandiri', bankPathAsset: "assets/bank_mandiri.png"),
  PaymentChoice(2, title: 'VA BRI', bankPathAsset: "assets/bank_bri.png"),
  PaymentChoice(3, title: 'VA BNI', bankPathAsset: "assets/bank_bni.png"),
];

class _CollectionReviewState extends State<CollectionReview>
    with TickerProviderStateMixin {
  bool updatedIsPanelOpen = false;
  int indexBank = -1;
  List<String> listVA = [];

  void onPressedPaymentMethod() {
    setState(() {
      updatedIsPanelOpen = true;
    });
  }

  void updateBankAssetState() {
    for (int i = 0; i < listAllMethod.length; i++) {
      if (listAllMethod[i].isSelected) {
        setState(() {
          indexBank = i;
        });
      }
    }
  }

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.66,
            minChildSize: 0.5,
            maxChildSize: 0.66,
            builder:
                (BuildContext context, ScrollController scrollController) =>
                    PaymentSlidingPanel(
              scrollController: scrollController,
              updateBankAssetState: updateBankAssetState,
              listVA: listVA,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    final Map<String, dynamic> _data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Stream<DocumentSnapshot<Map<String, dynamic>>> _collectionStream =
    FirebaseFirestore.instance.collection('Collection').doc(_data['collectionId']).snapshots();

    print(_collectionStream);

    final SnackBar _snackBar = SnackBar(
      backgroundColor: const Color(0xFFF3F4F6),
      content: Container(
        alignment: Alignment.center,
        height: 48.0,
        child: Text(
          'Pilih metode pembayaran terlebih dulu 💸',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Colors.black,
            height: 1.20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    return AppLayout(
      appBar: AppBar(
        title: Text(
          'Review Koleksi',
          style: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
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
                DescCollectionReview(
                  collectionStream: _collectionStream,
                ),
                TotalCollectionReview(
                  collectionStream: _collectionStream,
                  data: _data,
                  onPressedPaymentMethod: _showDialog,
                  indexBank: indexBank,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavBar: updatedIsPanelOpen
          ? null
          : BottomActionBar(
              subTitleAbove: "Total Pembayaran",
              titleBottom:
                  "Rp${NumberFormat.decimalPattern('id').format(_data['price'])}",
              textButton: "Proses Sekarang",
              onClickButton: () async {
                indexBank != -1
                    ? Navigator.pushNamed(context, '/payment_process',
                        arguments: <String, dynamic>{
                            'codeSale': 0,
                            'transactionId': await QuickTransaction()
                                .createTransaction(
                                    amount: _data['price'],
                                    name: _data['name'],
                                    buyerId: AuthService.user!.uid,
                                    index: indexBank,
                                    collectionId: _data['collectionId']),
                            'collectionId': _data['collectionId'],
                          })
                    : rootScaffoldMessengerKey.currentState
                        ?.showSnackBar(_snackBar);
              },
            ),
    );
  }
}
