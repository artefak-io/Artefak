import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/appbar_actions_button.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/desc_collection_review.dart';
import 'package:artefak/widgets/detail_payment_process.dart';
import 'package:artefak/widgets/sale_price_widget.dart';
import 'package:flutter/material.dart';

class PaymentProcess extends StatelessWidget {
  const PaymentProcess({Key? key}) : super(key: key);

  static const index = 2; // TODO: In what index is this?

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    final Map<String, dynamic> _data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
                DetailPaymentProcess(),
                SizedBox(
                  height: 24.0,
                ),
                Divider(
                  height: 0,
                  color: _themeData.cursorColor,
                ),
                DescCollectionReview(),
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
