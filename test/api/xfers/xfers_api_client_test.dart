import 'package:artefak/api/xfers/xfers.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;

void main() {
  group('group name', () {
    late http.Client httpClient;
    late XfersClient xfersClient;
    setUp(() {
      httpClient = http.Client();
      xfersClient = XfersClient(httpClient: httpClient);
    });
    tearDown(() {
      httpClient.close();
    });
    group('getInvoice', (() {
      test('throws XfersException', () {
        expect(
          () async {
            await xfersClient.getInvoice(
                order: xfersClient.createOrder(
              paymentMethodType: XfersPaymentMethodType.virtualAccount,
              amount: 1000000,
              referenceId: '123817365',
              expiredAt: '2022-07-30T06:07:04+07:00',
              description: 'First Mint Kunang Kunang',
              displayName: 'Artefak Jaya Indonesia',
              bankShortCode: XfersBankShortCode.mandiri,
            ));
          },
          throwsA(isA<XfersException>().having((p0) => p0.code, 'code', '005')),
        );
      });
    }));
  });
}
