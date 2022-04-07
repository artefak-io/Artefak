import 'package:artefak/services/asset_service.dart';
import 'package:artefak/services/tatum_transfer.dart';
import 'package:artefak/services/wallet_firestore.dart';

class TransferService {
  static final TransferService _transferService = TransferService._();

  TransferService._();

  factory TransferService() {
    return _transferService;
  }

  Future<void> transferNft(
      String asssetId,
      String userId,
      String name,
      String desc,
      String coverImage,
      String contractAddress,
      String tokenId,
      int price) async {
    try {
      String userAddress =
          await WalletFirestore().getWalletWithWalletCreation(userId);
      await TatumTransfer()
          .transferNftTatum(userAddress, tokenId, contractAddress);
      AssetService().updateAssetMetaData(asssetId, userAddress, name, desc,
          coverImage, contractAddress, tokenId, price);
    } catch (error) {
      print("error happens $error");
    }
  }
}
