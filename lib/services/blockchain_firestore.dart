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
    return result.data()!["tokenId"];
  }

  Future<void> incrementTokenIdMeta() async {
    String tokenId = await getTokenIdMeta();
    int newTokenId = int.parse(tokenId) + 1;
    _blockchainDB.doc("BSC Testnet").set({
      "contractAddress": await getContractAddress(),
      "tokenId": newTokenId.toString()
    });
  }
}
