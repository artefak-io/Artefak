import 'dart:convert';
import 'dart:math';

import 'package:artefak/api_key.dart' as api_key;
import 'package:http/http.dart';

class PaymentServiceOy {
  PaymentServiceOy._();

  static final PaymentServiceOy _payment = PaymentServiceOy._();

  factory PaymentServiceOy() {
    return _payment;
  }

  static const String _ch =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String getTransactionId() {
    Random _rnd = Random();
    return String.fromCharCodes(
        Iterable.generate(20, (_) => _ch.codeUnitAt(_rnd.nextInt(_ch.length))));
  }

//successful
  Future<void> getBalance() async {
    Response result = await get(
        Uri.parse('https://api-stg.oyindonesia.com/api/balance'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'x-oy-username': api_key.oyUserName,
          'x-api-key': api_key.oyApiKey,
        });
    if (result.statusCode == 200) {
      print(result.body);
    } else {
      print(result.reasonPhrase);
      return;
    }
  }

  Future<Map<String, dynamic>> createVirtualAccount(
      String userId, String bankCode, int price) async {
    Response result = await post(
        Uri.parse('https://api-stg.oyindonesia.com/api/generate-static-va'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'x-oy-username': api_key.oyUserName,
          'x-api-key': api_key.oyApiKey,
        },
        body: jsonEncode(<String, dynamic>{
          "partner_user_id": userId,
          "bank_code": bankCode,
          "amount": price,
          "is_open": false,
          "is_single_use": true,
          "is_lifetime": false,
          "username_display": "Artefak",
          "partner_trx_id": getTransactionId(),
        }));
    if (result.statusCode == 200) {
      print(jsonDecode(result.body));
      Map<String, dynamic> value = jsonDecode(result.body);
      return value;
    } else {
      return Future.error(
          'error in create virtual account ${result.reasonPhrase}');
    }
  }
}
