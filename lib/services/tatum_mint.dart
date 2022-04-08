import 'dart:convert';

import 'package:artefak/services/blockchain_firestore.dart';
import 'package:artefak/services/wallet_firestore.dart';
import 'package:http/http.dart';
import 'package:artefak/api_key.dart' as api_key;

class TatumMintService {
  TatumMintService._();

  static final TatumMintService _tatum = TatumMintService._();

  factory TatumMintService() {
    return _tatum;
  }

  Future<void> mintNft(String jsonUrl) async {
    Map<String, dynamic> body = {
      "chain": "BSC",
      "to": await WalletFirestore().getBaseAddress(),
      "url": jsonUrl,
      "tokenId": await BlockchainFirestore().getTokenIdMeta(),
      "contractAddress": await BlockchainFirestore().getContractAddress(),
      "fromPrivateKey": await WalletFirestore().getBaseKey()
    };
    Response result = await post(
      Uri.parse('https://api-us-west1.tatum.io/v3/nft/mint?type=testnet'),
      headers: <String, String>{
        "x-api-key": api_key.tatumApiKey,
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
    if (result.statusCode == 200) {
      print(jsonDecode(result.body));
    } else {
      return Future.error('error in test virtual account ${result.body}');
    }
  }
}
