// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:artefak/api/xfers/models/xfers_enum.dart';
import 'package:test/test.dart';
import 'package:artefak/api/xfers/models/order.dart';

void main() {
  group('Order', () {
    group('toJson', () {
      test('returns value in json format', () {
        final Order order = Order(
          data: OrderData(
            attributes: OrderAttributes(
              paymentMethodType: XfersPaymentMethodType.virtualAccount,
              amount: 1000000,
              referenceId: '2jfh712345',
              expiredAt: '2022-07-30T06:07:04+07:00',
              description: 'First Mint Nidji',
              paymentMethodOptions: OrderPaymentMethodOptions(
                  bankShortCode: XfersBankShortCode.bri,
                  displayName: 'Artefak Jaya Sejahtera'),
            ),
          ),
        );
        expect(
          jsonEncode(order),
          '{"data":{"attributes":{"paymentMethodType":"virtual_bank_account","amount":1000000,"referenceId":"2jfh712345","expiredAt":"2022-07-30T06:07:04+07:00","description":"First Mint Nidji","paymentMethodOptions":{"bankShortCode":"BRI","displayName":"Artefak Jaya Sejahtera"}}}}',
        );
      });
    });
  });
}
