import 'package:artefak/logic/transaction/repositories/firebase_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:test/test.dart';

void main() {
  group('Firebase Transaction Repository', () {
    late FirebaseTransaction transaction;
    setUp(() async {
      transaction = FirebaseTransaction(FirebaseFirestore.instance);
    });
    test('Firebase Transaction Repository', () {});
  });
}
