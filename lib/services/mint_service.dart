import 'dart:io';

import 'package:artefak/services/asset_service.dart';
import 'package:artefak/services/blockchain_firestore.dart';
import 'package:artefak/services/tatum_mint.dart';

class MintService {
  static final MintService _mintService = MintService._();

  MintService._();

  factory MintService() {
    return _mintService;
  }

  Future<void> mint(File image, String name, String desc, int price) async {
    try {
      String jsonUrl = await AssetService().newAsset(image, name, desc, price);
      await TatumMintService().mintNft(jsonUrl);
      BlockchainFirestore().incrementTokenIdMeta();
    } catch (error) {
      print("error happens $error");
    }
  }
}
