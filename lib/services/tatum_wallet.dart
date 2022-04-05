import 'dart:convert';

import 'package:http/http.dart';
import 'package:artefak/api_key.dart' as api_key;

class TatumWalletService {
  TatumWalletService._();

  static final TatumWalletService _tatum = TatumWalletService._();

  factory TatumWalletService() {
    return _tatum;
  }

  Future<Map<String, dynamic>> _generateWalletBSC() async {
    Response result = await get(
        Uri.parse('https://api-us-west1.tatum.io/v3/bsc/wallet?type=testnet'),
        headers: <String, String>{
          "x-api-key": api_key.tatumApiKey,
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

  Future<Map<String, dynamic>> _generatePublicKeyBSC(
      String xpub, int index) async {
    Response result = await get(
        Uri.parse('https://api-us-west1.tatum.io/v3/bsc/address/' +
            xpub +
            '/' +
            index.toString() +
            '?type=testnet'),
        headers: <String, String>{
          "x-api-key": api_key.tatumApiKey,
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

  Future<Map<String, dynamic>> _generatePrivateKeyBSC(
      String mnemonic, int index) async {
    Map<String, dynamic> body = {"index": index, "mnemonic": mnemonic};
    Response result = await post(
      Uri.parse(
          'https://api-us-west1.tatum.io/v3/bsc/wallet/priv?type=testnet'),
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

      Map<String, dynamic> resultGenerateWalletBSC = await _generateWalletBSC();
      mnemonic = resultGenerateWalletBSC['mnemonic'];

      Map<String, dynamic> resultGeneratePublicKeyBSC =
          await _generatePublicKeyBSC(resultGenerateWalletBSC['xpub'], index);
      publicKey = resultGeneratePublicKeyBSC['address'];

      Map<String, dynamic> resultGeneratePrivateKeyBSC =
          await _generatePrivateKeyBSC(mnemonic, index);
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
