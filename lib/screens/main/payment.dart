import 'package:artefak/widgets/payment_button.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> _data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              PaymentButton(
                price: _data['price'],
                assetName: _data['assetName'],
                assetId: _data['id'],
                bankLogo: Image.asset('assets/bankmandiri.png'),
                bankCode: '008',
              ),
              PaymentButton(
                price: _data['price'],
                assetName: _data['assetName'],
                assetId: _data['id'],
                bankLogo: Image.asset('assets/bankbri.png'),
                bankCode: '002',
              ),
              PaymentButton(
                price: _data['price'],
                assetName: _data['assetName'],
                assetId: _data['id'],
                bankLogo: Image.asset('assets/bankbca.png'),
                bankCode: '014',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
