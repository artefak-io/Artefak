import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/payment_button.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> _data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return AppLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Pembayaran'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                PaymentButton(
                  price: _data['price'],
                  assetName: _data['assetName'],
                  assetId: _data['id'],
                  bankLogo: Image.asset('assets/bank_mandiri.png'),
                  bankCode: '008',
                ),
                PaymentButton(
                  price: _data['price'],
                  assetName: _data['assetName'],
                  assetId: _data['id'],
                  bankLogo: Image.asset('assets/bank_bri.png'),
                  bankCode: '002',
                ),
                PaymentButton(
                  price: _data['price'],
                  assetName: _data['assetName'],
                  assetId: _data['id'],
                  bankLogo: Image.asset('assets/bank_bca.png'),
                  bankCode: '014',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
