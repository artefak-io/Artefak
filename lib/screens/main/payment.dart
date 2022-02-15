import 'package:artefak/services/payment_service.dart';
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
            onPressed: () => PaymentService().getBalance(),
            child: const Text('coba auth'),
          ),
          ElevatedButton(
            onPressed: () => PaymentService()
                .testVirtualAccount(_data['id'], _data['price'], 'BRI'),
            child: const Text('coba virtual account'),
          ),
        ],
      ),
    );
  }
}
