import 'package:artefak/widgets/bottom_action_bar.dart';
import 'package:artefak/widgets/desc_collection_review.dart';
import 'package:artefak/widgets/payment_sliding_panel.dart';
import 'package:artefak/widgets/select_card_payment.dart';
import 'package:artefak/widgets/total_collection_review.dart';
import 'package:flutter/material.dart';

class CollectionReview extends StatefulWidget {
  const CollectionReview({Key? key}) : super(key: key);

  @override
  State<CollectionReview> createState() => _CollectionReviewState();
}

class _CollectionReviewState extends State<CollectionReview> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool updatedIsPanelOpen = false;

  List<ListSelectedPayment<PaymentChoice>> listAllMethod = [];
  List<String> listVA = [];

  @override
  void initState() {
    super.initState();
    populateData();
  }

  void populateData() {
    for (int i = 0; i < choices.length; i++)
      listAllMethod.add(ListSelectedPayment<PaymentChoice>(choices[i]));
    listAllMethod.add(ListSelectedPayment<PaymentChoice>(
        PaymentChoice(title: "QRIS", bankPathAsset: "")));

    listVA.add("assets/CIMB.png");
    listVA.add("assets/DANA.png");
    listVA.add("assets/GOPAY.png");
    listVA.add("assets/OVO.png");
  }

  void onPressedPaymentMethod() {
    setState(() {
      updatedIsPanelOpen = true;
    });
  }

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.8,
            minChildSize: 0.5,
            maxChildSize: 0.8,
            builder:
                (BuildContext context, ScrollController scrollController) =>
                    PaymentSlidingPanel(
              scrollController: scrollController,
              listAllMethod: listAllMethod,
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
    final Map<String, dynamic> _data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.transparent,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Review Koleksi',
          style: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
        backgroundColor: _themeData.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: -120,
              top: -100,
              child: Image.asset(
                'assets/bggrad.png',
                fit: BoxFit.fitHeight,
                height: 350,
              ),
            ),
            Column(
              children: [
                DescCollectionReview(
                    size: size, textTheme: _textTheme, themeData: _themeData),
                TotalCollectionReview(
                  size: size,
                  textTheme: _textTheme,
                  data: _data,
                  themeData: _themeData,
                  listAllMethod: listAllMethod,
                  onPressedPaymentMethod: _showDialog,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: updatedIsPanelOpen
          ? null
          : BottomActionBar(
              themeData: _themeData,
              textTheme: _textTheme,
              size: size,
              subTitleAbove: "Total Pembayaran",
              priceDisplay: 750000,
              textButton: "Proses Sekarang",
            ),
    );
  }
}

class ListSelectedPayment<T> {
  bool isSelected = false;
  T data;

  ListSelectedPayment(this.data);
}
