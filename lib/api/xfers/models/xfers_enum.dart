import 'package:json_annotation/json_annotation.dart';

enum XfersPaymentMethodType {
  @JsonValue('virtual_bank_account')
  virtualAccount,
  @JsonValue('qris')
  qris,
  unknown,
}

enum XfersBankShortCode {
  @JsonValue('BCA')
  bca,
  @JsonValue('BRI')
  bri,
  @JsonValue('BNI')
  bni,
  @JsonValue('MANDIRI')
  mandiri,
  unknown,
}

enum XfersPaymentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('paid')
  paid,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('expired')
  expired,
  @JsonValue('failed')
  failed,
  unknown
}
