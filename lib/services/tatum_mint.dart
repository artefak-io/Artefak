import 'dart:convert';

import 'package:artefak/services/wallet_firestore.dart';
import 'package:http/http.dart';

class TatumMintService {
  TatumMintService._();

  static final TatumMintService _tatum = TatumMintService._();

  factory TatumMintService() {
    return _tatum;
  }

  // USW test net api
  final String ApiKey = "52a0d1b3-06b7-4a87-a4d5-e7ba5eba6529";

  Future nftExpress(String ipfs) async {
    Map<String, dynamic> body = {
      "chain": "BSC",
      "to": await WalletFirestore().getBaseAddress(),
      "url": "ipfs://" + ipfs
    };
    Response result = await post(
      Uri.parse('https://api-us-west1.tatum.io/v3/nft/mint?type=testnet'),
      headers: <String, String>{
        "x-api-key": ApiKey,
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
