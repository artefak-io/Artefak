import 'package:artefak/services/auth.dart';
import 'package:artefak/services/payment_service_firestore.dart';
import 'package:artefak/services/payment_service_oy.dart';
import 'package:artefak/services/transaction_service.dart';
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
          Text(_data['id']),
          Text(_data['price'].toString()),
          ElevatedButton(
            onPressed: () => PaymentServiceOy().getBalance(),
            child: const Text('coba auth'),
          ),
          ElevatedButton(
            onPressed: () {
              PaymentServiceOy()
                  .testVirtualAccount(
                      AuthService.user!.uid, '002', _data['price'])
                  .then((value1) => PaymentFirestore().newPayment(value1))
                  .then((value2) => TransactionService()
                      .newTransaction(_data['id'], _data['assetName'], value2));
            },
            child: const Text('coba virtual account'),
          ),
        ],
      ),
    );
  }
}
