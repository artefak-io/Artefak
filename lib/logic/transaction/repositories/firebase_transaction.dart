import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart' as artefak_transaction;

class FirebaseTransactionFailure implements Exception {}

class EmptyFirebaseTransactionFailure implements Exception {}

class FirebaseTransaction {
  final FirebaseFirestore _firestore;
  FirebaseTransaction(
    this._firestore,
  );

  Future<void> createTransaction(
      artefak_transaction.Transaction transaction) async {
    try {
      await _firestore
          .collection('Transaction')
          .doc(transaction.id)
          .set(transaction.toMap());
    } catch (error) {
      throw FirebaseTransactionFailure();
    }
  }

  //TODO: Should be a stream for bloc input
  Future<artefak_transaction.Transaction> getTransaction(String id) async {
    DocumentSnapshot<Map<String, dynamic>> result =
        await _firestore.collection('Transaction').doc(id).get();

    if (result.data() == null) {
      throw EmptyFirebaseTransactionFailure();
    }

    return artefak_transaction.Transaction.fromMap(
        map: result.data()!, id: result.id);
  }
}
