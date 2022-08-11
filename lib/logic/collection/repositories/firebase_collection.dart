import 'package:artefak/logic/collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmptyCollectionFailure implements Exception {}

class FirebaseCollection {
  final FirebaseFirestore _firestore;
  FirebaseCollection(this._firestore);

  // TODO: should be a stream
  Future<Collection> getCollection(String id) async {
    DocumentSnapshot<Map<String, dynamic>> result =
        await _firestore.collection('Collection').doc(id).get();

    if (result.data() == null) {
      throw EmptyCollectionFailure();
    }

    DocumentSnapshot<Map<String, dynamic>> userData = await (result
            .data()!['creator'] as DocumentReference<Map<String, dynamic>>)
        .get();

    return Collection.fromMap(
        mapCollection: result.data()!,
        idCollection: result.id,
        mapUser: userData.data()!,
        idUser: userData.id);
  }
}
