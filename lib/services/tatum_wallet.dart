import 'dart:convert';

import 'package:http/http.dart';

class TatumWalletService {
  TatumWalletService._();

  static final TatumWalletService _tatum = TatumWalletService._();

  factory TatumWalletService() {
    return _tatum;
  }

  // USW test net api
  final String ApiKey = "52a0d1b3-06b7-4a87-a4d5-e7ba5eba6529";

  Future<Map<String, dynamic>> generateWalletBSC() async {
    Response result = await get(
        Uri.parse('https://api-us-west1.tatum.io/v3/bsc/wallet?type=testnet'),
        headers: <String, String>{
          "x-api-key": ApiKey,
        });
    if (result.statusCode == 200) {
      print(jsonDecode(result.body));
      Map<String, dynamic> value = jsonDecode(result.body);
      return value;
    } else {
      return Future.error(
          'error in test virtual account ${result.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> generatePublicKeyBSC(
      String xpub, int index) async {
    Response result = await get(
        Uri.parse('https://api-us-west1.tatum.io/v3/bsc/address/' +
            xpub +
            '/' +
            index.toString() +
            '?type=testnet'),
        headers: <String, String>{
          "x-api-key": ApiKey,
        });
    if (result.statusCode == 200) {
      print(jsonDecode(result.body));
      Map<String, dynamic> value = jsonDecode(result.body);
      return value;
    } else {
      return Future.error(
          'error in test virtual account ${result.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> generatePrivateKeyBSC(
      String mnemonic, int index) async {
    Map<String, dynamic> body = {"index": index, "mnemonic": mnemonic};
    Response result = await post(
      Uri.parse(
          'https://api-us-west1.tatum.io/v3/bsc/wallet/priv?type=testnet'),
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
      return Future.error(
          'error in test virtual account ${result.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> createWalletBSC() async {
    try {
      const int index = 13;
      String mnemonic;
      String publicKey;
      String privateKey;

      Map<String, dynamic> resultGenerateWalletBSC = await generateWalletBSC();
      mnemonic = resultGenerateWalletBSC['mnemonic'];

      Map<String, dynamic> resultGeneratePublicKeyBSC =
          await generatePublicKeyBSC(resultGenerateWalletBSC['xpub'], index);
      publicKey = resultGeneratePublicKeyBSC['address'];

      Map<String, dynamic> resultGeneratePrivateKeyBSC =
          await generatePrivateKeyBSC(mnemonic, index);
      privateKey = resultGeneratePrivateKeyBSC['key'];

      return {
        "mnemonic": mnemonic,
        "publicKey": publicKey,
        "privateKey": privateKey
      };
    } catch (error) {
      return Future.error(error);
    }
  }
}
