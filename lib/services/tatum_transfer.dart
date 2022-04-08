import 'dart:convert';

import 'package:artefak/services/wallet_firestore.dart';
import 'package:http/http.dart';
import 'package:artefak/api_key.dart' as api_key;

class TatumTransfer {
  TatumTransfer._();

  static final TatumTransfer _tatum = TatumTransfer._();

  factory TatumTransfer() {
    return _tatum;
  }

  Future<void> transferNftTatum(
      String userAddress, String tokenId, String contractAddress) async {
    Map<String, dynamic> body = {
      "chain": "BSC",
      "to": userAddress,
      "tokenId": tokenId,
      "contractAddress": contractAddress,
      "fromPrivateKey": await WalletFirestore().getBaseKey()
    };
    Response result = await post(
      Uri.parse(
          'https://api-us-west1.tatum.io/v3/nft/transaction?type=testnet'),
      headers: <String, String>{
        "x-api-key": api_key.tatumApiKey,
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
    if (result.statusCode == 200) {
      print(jsonDecode(result.body));
    } else {
      print('error in test virtual account ${result.body}');
    }
  }
}
