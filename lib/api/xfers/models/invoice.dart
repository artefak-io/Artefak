import 'package:json_annotation/json_annotation.dart';
import 'xfers_enum.dart';

part 'invoice.g.dart';

@JsonSerializable(createToJson: false, createFactory: true)
class Invoice {
  final String id;
  final String type;
  final InvoiceAttributes attributes;

  const Invoice({
    required this.id,
    required this.type,
    required this.attributes,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}

@JsonSerializable(createToJson: false, createFactory: true)
class InvoiceAttributes {
  @JsonKey(unknownEnumValue: XfersPaymentStatus.unknown)
  final XfersPaymentStatus status;
  final String amount;
  final String createdAt;
  final String description;
  final String expiredAt;
  final String referenceId;
  final String fees;
  final InvoicePaymentMethod paymentMethod;

  const InvoiceAttributes({
    required this.status,
    required this.amount,
    required this.createdAt,
    required this.description,
    required this.expiredAt,
    required this.fees,
    required this.referenceId,
    required this.paymentMethod,
  });

  factory InvoiceAttributes.fromJson(Map<String, dynamic> json) =>
      _$InvoiceAttributesFromJson(json);
}

@JsonSerializable(createToJson: false, createFactory: true)
class InvoicePaymentMethod {
  final String id;
  @JsonKey(unknownEnumValue: XfersPaymentMethodType.unknown)
  final XfersPaymentMethodType type;
  final String referenceId;
  final InvoiceInstructions instructions;

  const InvoicePaymentMethod({
    required this.id,
    required this.type,
    required this.referenceId,
    required this.instructions,
  });

  factory InvoicePaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$InvoicePaymentMethodFromJson(json);
}

@JsonSerializable(createToJson: false, createFactory: true)
class InvoiceInstructions {
  @JsonKey(unknownEnumValue: XfersBankShortCode.unknown)
  final XfersBankShortCode? bankShortCode;
  final String displayName;
  final String? accountNo;
  final String? imageUrl;

  const InvoiceInstructions({
    required this.displayName,
    this.bankShortCode,
    this.accountNo,
    this.imageUrl,
  });

  factory InvoiceInstructions.fromJson(Map<String, dynamic> json) =>
      _$InvoiceInstructionsFromJson(json);
}
