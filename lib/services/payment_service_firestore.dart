import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentFirestore {
  static final PaymentFirestore _paymentFirestore = PaymentFirestore._();

  PaymentFirestore._();

  factory PaymentFirestore() {
    return _paymentFirestore;
  }

  final CollectionReference<Map<String, dynamic>> _paymentdb =
      FirebaseFirestore.instance.collection('Payment');

  Future<Map<String, dynamic>> newPayment(Map<String, dynamic> fromOy) async {
    return _paymentdb
        .add({
          'transactionId': fromOy["partner_trx_id"],
          'status': fromOy["va_status"],
          'price': fromOy["amount"],
          'method': 'virtual account',
          'bankCode': fromOy["bank_code"],
          'partnerPaymentId': fromOy["id"],
        })
        .then((value) => fromOy)
        .catchError((error) => throw Exception('error in newPayment $error'));
  }
}
