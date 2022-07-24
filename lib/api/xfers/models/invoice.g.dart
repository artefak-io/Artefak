// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      id: json['id'] as String,
      type: json['type'] as String,
      attributes: InvoiceAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

InvoiceAttributes _$InvoiceAttributesFromJson(Map<String, dynamic> json) =>
    InvoiceAttributes(
      status: $enumDecode(_$XfersPaymentStatusEnumMap, json['status'],
          unknownValue: XfersPaymentStatus.unknown),
      amount: json['amount'] as String,
      createdAt: json['createdAt'] as String,
      description: json['description'] as String,
      expiredAt: json['expiredAt'] as String,
      fees: json['fees'] as String,
      referenceId: json['referenceId'] as String,
      paymentMethod: InvoicePaymentMethod.fromJson(
          json['paymentMethod'] as Map<String, dynamic>),
    );

const _$XfersPaymentStatusEnumMap = {
  XfersPaymentStatus.pending: 'pending',
  XfersPaymentStatus.processing: 'processing',
  XfersPaymentStatus.paid: 'paid',
  XfersPaymentStatus.completed: 'completed',
  XfersPaymentStatus.cancelled: 'cancelled',
  XfersPaymentStatus.expired: 'expired',
  XfersPaymentStatus.failed: 'failed',
  XfersPaymentStatus.unknown: 'unknown',
};

InvoicePaymentMethod _$InvoicePaymentMethodFromJson(
        Map<String, dynamic> json) =>
    InvoicePaymentMethod(
      id: json['id'] as String,
      type: $enumDecode(_$XfersPaymentMethodTypeEnumMap, json['type'],
          unknownValue: XfersPaymentMethodType.unknown),
      referenceId: json['referenceId'] as String,
      instructions: InvoiceInstructions.fromJson(
          json['instructions'] as Map<String, dynamic>),
    );

const _$XfersPaymentMethodTypeEnumMap = {
  XfersPaymentMethodType.virtualAccount: 'virtual_bank_account',
  XfersPaymentMethodType.qris: 'qris',
  XfersPaymentMethodType.unknown: 'unknown',
};

InvoiceInstructions _$InvoiceInstructionsFromJson(Map<String, dynamic> json) =>
    InvoiceInstructions(
      displayName: json['displayName'] as String,
      bankShortCode: $enumDecodeNullable(
          _$XfersBankShortCodeEnumMap, json['bankShortCode'],
          unknownValue: XfersBankShortCode.unknown),
      accountNo: json['accountNo'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

const _$XfersBankShortCodeEnumMap = {
  XfersBankShortCode.bca: 'BCA',
  XfersBankShortCode.bri: 'BRI',
  XfersBankShortCode.bni: 'BNI',
  XfersBankShortCode.mandiri: 'MANDIRI',
  XfersBankShortCode.unknown: 'unknown',
};
