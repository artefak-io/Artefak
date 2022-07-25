import 'package:artefak/api/xfers/models/xfers_enum.dart';
import 'package:test/test.dart';
import 'package:artefak/api/xfers/models/invoice.dart';

void main() {
  group('Invoice', () {
    group('fromJson', () {
      test('retuns XfersBankShortCode.bri', () {
        expect(
            Invoice.fromJson(<String, dynamic>{
              "id": "contract_2f89a9ce44fb4d12a0f6990a6c03744f",
              "type": "payment",
              "attributes": {
                "status": "pending",
                "amount": "1000000.0",
                "createdAt": "2022-07-23T03:27:28+07:00",
                "description": "First Mint Nidji",
                "expiredAt": "2022-07-23T20:27:28Z",
                "referenceId": "2jfh7234",
                "fees": "3663.0",
                "paymentMethod": {
                  "id": "va_28665ae57c0708b7db25464a261ec684",
                  "type": "virtual_bank_account",
                  "referenceId": "2jfh7234",
                  "instructions": {
                    "bankShortCode": "BRI",
                    "accountNo": "1269700000000197",
                    "displayName": "IKN-Artefak Jaya Sejahtera"
                  }
                }
              }
            }),
            isA<Invoice>().having(
                (p0) => p0.attributes.paymentMethod.instructions.bankShortCode,
                'Bank Code',
                XfersBankShortCode.bri));
      });
    });
  });
}
