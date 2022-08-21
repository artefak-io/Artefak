import 'package:artefak/api/xfers/xfers.dart';
import 'package:artefak/logic/transaction/transaction.dart'
    as artefak_transaction;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class QuickTransaction {
  static final QuickTransaction _quickTransaction = QuickTransaction._();

  QuickTransaction._();

  factory QuickTransaction() {
    return _quickTransaction;
  }

  final CollectionReference<Map<String, dynamic>> _transactiondb =
      FirebaseFirestore.instance.collection('Transaction');

  final Uuid _uuid = const Uuid();
  final XfersClient _xfersClient = XfersClient();

  XfersBankShortCode bankFromIndex(int index) {
    switch (index) {
      case 0:
        return XfersBankShortCode.bca;
      case 1:
        return XfersBankShortCode.bri;
      case 2:
        return XfersBankShortCode.bni;
      case 3:
        return XfersBankShortCode.mandiri;
      default:
        return XfersBankShortCode.unknown;
    }
  }

  Future createTransaction({
    required int amount,
    required String name,
    required String buyerId,
    required int index,
    required String collectionId,
  }) async {
    String transactionId = _uuid.v4();
    Order order = _xfersClient.createOrder(
      paymentMethodType: XfersPaymentMethodType.virtualAccount,
      amount: amount,
      referenceId: transactionId,
      expiredAt: DateTime.now().add(const Duration(hours: 6)).toIso8601String(),
      description: 'First mint of $name',
      displayName: 'Artefak Jaya Indonesia',
      bankShortCode: bankFromIndex(index),
    );
    Invoice invoice = await _xfersClient.getInvoice(order: order);

    artefak_transaction.Transaction transaction =
        artefak_transaction.Transaction.fromXfers(
            invoice, _uuid.v4(), buyerId, collectionId);

    await _transactiondb.doc(transaction.id).set(transaction.toMap());

    return transactionId;
  }
}
