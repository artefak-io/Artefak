import 'dart:convert';
import 'dart:io';

import 'package:artefak/services/wallet_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AssetService {
  final CollectionReference _assetdb =
      FirebaseFirestore.instance.collection('Asset');

  final FirebaseStorage _assetCloud = FirebaseStorage.instance;

  static final AssetService _assetService = AssetService._();

  AssetService._();

  factory AssetService() {
    return _assetService;
  }

  Future<String> assetPicture(File image, String name) async {
    UploadTask result =
        _assetCloud.ref().child('assets').child(name).putFile(image);
    try {
      TaskSnapshot task = await result;
      return task.ref.getDownloadURL();
    } catch (error) {
      print(result.snapshot);
      return Future.error(error);
    }
  }

  Future<String> assetJson(
      String name, String description, String imageLink) async {
    Map<String, dynamic> jsonBody = {
      "name": name,
      "description": description,
      "image": imageLink
    };

    SettableMetadata metaData =
        SettableMetadata(contentType: 'application/json');

    UploadTask result = _assetCloud
        .ref()
        .child('assets')
        .child("json")
        .child(name + "JSON")
        .putString(jsonEncode(jsonBody), metadata: metaData);
    try {
      TaskSnapshot task = await result;
      return task.ref.getDownloadURL();
    } catch (error) {
      print(result.snapshot);
      return Future.error(error);
    }
  }

  Future<void> assetMetaData(
      String name,
      String desc,
      String coverImage,
      String externalLink,
      String contractAddress,
      String tokenId,
      int price) async {
    _assetdb
        .add({
          'currentOwner': await WalletFirestore().getBaseAddress(),
          'creator': await WalletFirestore().getBaseAddress(),
          'name': name,
          'description': desc,
          'coverImage': coverImage,
          'views': 0,
          'externalLink': externalLink,
          'contractAddress': '',
          'tokenId': '',
          "price": price,
        })
        .then((value) => print('succesful added'))
        .catchError((error) => print('something error newAsset $error'));
  }

  Future<String> newAsset(File image, String name, String desc,
      String contractAddress, String tokenId, int price) async {
    try {
      String coverImage = await assetPicture(image, name);
      String jsonAddress = await assetJson(name, desc, coverImage);
      assetMetaData(
          name, desc, coverImage, jsonAddress, contractAddress, tokenId, price);
      return jsonAddress;
    } catch (error) {
      return Future.error(error);
    }
  }

// need to fix this
// this should query based on user public key rather than user id
  Stream<QuerySnapshot<Object?>> personalAssets(String id) {
    return _assetdb.where('currentOwner', isEqualTo: id).get().asStream();
  }
}
