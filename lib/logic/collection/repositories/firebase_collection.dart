import 'package:artefak/logic/collection/collection.dart';
import 'package:artefak/logic/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmptyCollectionFailure implements Exception {}

class FirebaseCollection {
  final FirebaseFirestore _firestore;
  FirebaseCollection(this._firestore);

  // TODO: should be a stream for bloc input
  Future<Collection> getCollection(String id) async {
    DocumentSnapshot<Map<String, dynamic>> result =
        await _firestore.collection('Collection').doc(id).get();

    if (result.data() == null) {
      throw EmptyCollectionFailure();
    }

    DocumentSnapshot<Map<String, dynamic>> userData = await (result
            .data()!['creator'] as DocumentReference<Map<String, dynamic>>)
        .get();

    // return Collection.fromMap(
    //     mapCollection: result.data()!,
    //     idCollection: result.id,
    //     mapUser: userData.data()!,
    //     idUser: userData.id);
    Collection awesome = Collection(
      id: result.id,
      coverImage: result.data()!['coverImage'],
      creator: ArtefakUser(
        id: userData.id,
        displayName: userData.data()!['displayName'],
        isVerified: userData.data()!['isVerified'],
        pin: userData.data()!['pin'],
        profilePicture: userData.data()!['profilePicture'],
        publicKey: userData.data()!['publicKey'],
      ),
      description: result.data()!['description'],
      name: result.data()!['name'],
      price: result.data()!['price'],
      externalLink: result.data()!['externalLink'],
      views: result.data()!['views'],
    );

    print(awesome.toString());
    return awesome;
  }
}
