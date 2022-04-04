import 'dart:io';

import 'package:artefak/services/asset_service.dart';
import 'package:artefak/services/tatum_mint.dart';

class MintService {
  static final MintService _assetService = MintService._();

  MintService._();

  factory MintService() {
    return _assetService;
  }

  Future<void> mint(File image, String name, String desc,
      String contractAddress, String tokenId, int price) async {
    try {
      String jsonAddress = await AssetService()
          .newAsset(image, name, desc, contractAddress, tokenId, price);
      TatumMintService().nftExpress(jsonAddress);
    } catch (error) {
      print(error);
    }
  }
}
