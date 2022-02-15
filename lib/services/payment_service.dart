import 'dart:convert';

import 'package:http/http.dart';

class PaymentService {
  PaymentService._();

  static final PaymentService _payment = PaymentService._();

  factory PaymentService() {
    return _payment;
  }

  static const String api =
      "xnd_development_3QoK7ooZFrXWUlXLw9mboqdNZYk1jlQJ3vXmTYYURflxSRu5rU2GsqE0D0HqEu";

  static const String testApi =
      "xnd_development_akETgEDtHWGmZx6bRiZofhfj2c0DaD7j3CB0KxNqeyeIzwikqPKEDsemjVMvK9Y";

  final String basicAuthTrial =
      'Basic ' + base64Encode(utf8.encode('$testApi:'));
  final String basicAuth = 'Basic ' + base64Encode(utf8.encode('$api:'));

//successful
  Future<void> getBalance() async {
    Response result = await get(Uri.parse('https://api.xendit.co/balance'),
        headers: <String, String>{'authorization': basicAuthTrial});
    if (result.statusCode == 200) {
      print(jsonDecode(result.body)['balance'].toString());
    } else {
      print('failure');
      return;
    }
  }

  Future<void> testVirtualAccount(String id, int price, String bankCode) async {
    Response result =
        await post(Uri.parse('https://api.xendit.co/callback_virtual_accounts'),
            headers: <String, String>{
              'authorization': basicAuth,
              "Content-Type": "application/x-www-form-urlencoded",
            },
            encoding: Encoding.getByName('utf-8'),
            body: <String, String>{
              'external_id': id,
              'bank_code': bankCode,
              'name': 'Artefak',
              'is_single_use': 'true',
              'is_closed': 'true',
              'expected_amount': price.toString(),
              'suggested_amount': price.toString(),
            });
    if (result.statusCode == 200) {
      print(result.body);
    } else {
      print(result.body);
    }
  }
}
