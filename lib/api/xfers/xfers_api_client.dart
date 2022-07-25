import 'dart:convert';

import 'package:http/http.dart' as http;
import 'models/models.dart';
import '../api_keys.dart';

class EmptyInvoiceFailure implements Exception {}

class XfersClient {
  static const _sandboxBaseUrl = 'sandbox-id.xfers.com';
  final http.Client _client;

  XfersClient({http.Client? httpClient})
      : _client = httpClient ?? http.Client();

  Order createOrder(
      {required XfersPaymentMethodType paymentMethodType,
      required int amount,
      required String referenceId,
      required String expiredAt,
      required String description,
      required String displayName,
      XfersBankShortCode? bankShortCode}) {
    return Order(
      data: OrderData(
        attributes: OrderAttributes(
          paymentMethodType: paymentMethodType,
          amount: amount,
          referenceId: referenceId,
          expiredAt: expiredAt,
          description: description,
          paymentMethodOptions: OrderPaymentMethodOptions(
            displayName: displayName,
            bankShortCode: bankShortCode,
          ),
        ),
      ),
    );
  }

  Future<Invoice> getInvoice({required Order order}) async {
    String xfersAuth =
        'Basic ' + base64.encode(utf8.encode('$xfersUserName:$xfersPassword'));
    http.Response response = await _client.post(
      Uri.https(_sandboxBaseUrl, '/api/v4/payments'),
      headers: <String, String>{
        'authorization': xfersAuth,
        "Content-Type": "application/vnd.api+json",
      },
      body: jsonEncode(order),
    );

    if (response.statusCode.toString().length == 3 &&
        response.statusCode.toString()[0] == '2') {
      Map<String, dynamic> jsonBody = jsonDecode(response.body);

      if (jsonBody['data'] == null) {
        throw EmptyInvoiceFailure();
      }

      return Invoice.fromJson(jsonBody['data']);
    }

    Map<String, dynamic> error = jsonDecode(response.body);
    List errorData = error['errors'];
    throw XfersException.fromJson(errorData.first as Map<String, dynamic>);
  }
}
