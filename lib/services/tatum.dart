import 'dart:convert';

import 'package:http/http.dart';

class TatumService {
  TatumService._();

  static final TatumService _tatum = TatumService._();

  factory TatumService() {
    return _tatum;
  }

  // test net api
  final String ApiKey = "52a0d1b3-06b7-4a87-a4d5-e7ba5eba6529";

  Future<Map<String, dynamic>> createWalletBSC() async {
    Response result = await get(
        Uri.parse('https://api-us-west1.tatum.io/v3/bnb/account'),
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
}
