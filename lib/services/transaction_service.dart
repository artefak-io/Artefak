import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionService {
  final CollectionReference<Map<String, dynamic>> _transactiondb =
      FirebaseFirestore.instance.collection('Transaction');

  static final TransactionService _transactionService = TransactionService._();

  TransactionService._();

  factory TransactionService() {
    return _transactionService;
  }

  String getBankNameVA(String bankCode) {
    if (bankCode == "002") {
      return "BRI";
    } else if (bankCode == "008") {
      return "Bank Mandiri";
    } else if (bankCode == "009") {
      return "BNI";
    } else if (bankCode == "013") {
      return "Bank Pertama";
    } else if (bankCode == "014") {
      return "BCA";
    } else if (bankCode == "022") {
      return "CIMB Niaga";
    } else if (bankCode == "213") {
      return "BPTN";
    } else {
      return "this shouldn't happens but it happens";
    }
  }

  Future newTransaction(
      String assetId, String assetName, Map<String, dynamic> fromOy) async {
    return _transactiondb.doc(fromOy["partner_trx_id"]).set({
      'assetId': assetId,
      'userId': fromOy["partner_user_id"],
      'price': fromOy["amount"],
      'assetName': assetName,
      'status': fromOy["va_status"],
      "bankName": getBankNameVA(fromOy["bank_code"]),
      "vaNumber": fromOy["va_number"],
      "vaHolder": fromOy["username_display"],
      "expTime": fromOy["expiration_time"],
    }).catchError((error) => Future.error('error in newTransaction $error'));
  }

  Future<void> deleteTransaction(
      DocumentSnapshot<Map<String, dynamic>> transaction) async {
    _transactiondb.doc(transaction.id).delete();
  }

  Stream<QuerySnapshot<Object?>> personalTransaction(String id) {
    return _transactiondb.where('userId', isEqualTo: id).get().asStream();
  }
}
