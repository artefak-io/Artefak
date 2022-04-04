import 'dart:convert';

import 'package:artefak/services/wallet_firestore.dart';
import 'package:http/http.dart';
import 'package:artefak/api_key.dart' as api_key;

class TatumMintService {
  TatumMintService._();

  static final TatumMintService _tatum = TatumMintService._();

  factory TatumMintService() {
    return _tatum;
  }

  Future nftExpress(String ipfs) async {
    Map<String, dynamic> body = {
      "chain": "BSC",
      "to": await WalletFirestore().getBaseAddress(),
      "url": "ipfs://" + ipfs
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
      Map<String, dynamic> value = jsonDecode(result.body);
      return value;
    } else {
      return Future.error('error in test virtual account ${result.body}');
    }
  }
}
