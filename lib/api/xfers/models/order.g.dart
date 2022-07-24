// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'data': instance.data.toJson(),
    };

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
      'attributes': instance.attributes.toJson(),
    };

Map<String, dynamic> _$OrderAttributesToJson(OrderAttributes instance) =>
    <String, dynamic>{
      'paymentMethodType':
          _$XfersPaymentMethodTypeEnumMap[instance.paymentMethodType]!,
      'amount': instance.amount,
      'referenceId': instance.referenceId,
      'expiredAt': instance.expiredAt,
      'description': instance.description,
      'paymentMethodOptions': instance.paymentMethodOptions.toJson(),
    };

const _$XfersPaymentMethodTypeEnumMap = {
  XfersPaymentMethodType.virtualAccount: 'virtual_bank_account',
  XfersPaymentMethodType.qris: 'qris',
  XfersPaymentMethodType.unknown: 'unknown',
};

Map<String, dynamic> _$OrderPaymentMethodOptionsToJson(
        OrderPaymentMethodOptions instance) =>
    <String, dynamic>{
      'bankShortCode': _$XfersBankShortCodeEnumMap[instance.bankShortCode],
      'displayName': instance.displayName,
    };

const _$XfersBankShortCodeEnumMap = {
  XfersBankShortCode.bca: 'BCA',
  XfersBankShortCode.bri: 'BRI',
  XfersBankShortCode.bni: 'BNI',
  XfersBankShortCode.mandiri: 'MANDIRI',
  XfersBankShortCode.unknown: 'unknown',
};
