import 'package:cloud_firestore/cloud_firestore.dart';

class AssetService {
  final CollectionReference _assetdb =
      FirebaseFirestore.instance.collection('Asset');

  static final AssetService _assetService = AssetService._();

  AssetService._();

  factory AssetService() {
    return _assetService;
  }

  Future<void> newAsset(String id) async {
    _assetdb
        .add({
          'currentOwner': id,
          'creator': id,
          'name': "Bugatti X231",
          'description': "A picture of a car isn't a real car",
          'coverImage':
              "https://s3.amazonaws.com/appforest_uf/f1633339626133x966906097875744300/photo-1566023888476-6f17e362fbb7.jpeg",
          'views': 0,
          'externalLink': '',
          'contractAddress': '',
          'tokenId': '',
        })
        .then((value) => print('succesful added'))
        .catchError((error) => print('something error newAsset'));
  }

  Stream<QuerySnapshot<Object?>> personalAssets(String id) {
    return _assetdb.where('currentOwner', isEqualTo: id).get().asStream();
  }
}
