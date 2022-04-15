import 'package:cloud_firestore/cloud_firestore.dart';

class BlockchainFirestore {
  final CollectionReference<Map<String, dynamic>> _blockchainDB =
      FirebaseFirestore.instance.collection('Blockchain');

  static final BlockchainFirestore _blockchainFirestore =
      BlockchainFirestore._();

  BlockchainFirestore._();

  factory BlockchainFirestore() {
    return _blockchainFirestore;
  }

  Future<String> getContractAddress() async {
    DocumentSnapshot<Map<String, dynamic>> result =
        await _blockchainDB.doc("BSC Testnet").get();
    return result.data()!["contractAddress"];
  }

  Future<String> getTokenIdMeta() async {
    DocumentSnapshot<Map<String, dynamic>> result =
        await _blockchainDB.doc("BSC Testnet").get();
    int resultInt = await result.data()!["tokenId"];
    return resultInt.toString();
  }

  Future<void> incrementTokenIdMeta() async {
    _blockchainDB
        .doc("BSC Testnet")
        .update({"tokenId": FieldValue.increment(1)});
  }
}
