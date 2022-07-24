import 'package:json_annotation/json_annotation.dart';
import 'xfers_enum.dart';

part 'order.g.dart';

@JsonSerializable(
    explicitToJson: true, createToJson: true, createFactory: false)
class Order {
  final OrderData data;
  const Order({required this.data});

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable(
    explicitToJson: true, createToJson: true, createFactory: false)
class OrderData {
  final OrderAttributes attributes;
  const OrderData({required this.attributes});

  Map<String, dynamic> toJson() => _$OrderDataToJson(this);
}

@JsonSerializable(
    explicitToJson: true, createToJson: true, createFactory: false)
class OrderAttributes {
  @JsonKey(unknownEnumValue: XfersPaymentMethodType.unknown)
  final XfersPaymentMethodType paymentMethodType;
  final int amount;
  final String referenceId;
  final String expiredAt;
  final String description;
  final OrderPaymentMethodOptions paymentMethodOptions;

  const OrderAttributes({
    required this.paymentMethodType,
    required this.amount,
    required this.referenceId,
    required this.expiredAt,
    required this.description,
    required this.paymentMethodOptions,
  });

  Map<String, dynamic> toJson() => _$OrderAttributesToJson(this);
}

@JsonSerializable(createToJson: true, createFactory: false)
class OrderPaymentMethodOptions {
  @JsonKey(unknownEnumValue: XfersBankShortCode.unknown)
  final XfersBankShortCode? bankShortCode;
  final String displayName;

  const OrderPaymentMethodOptions({
    this.bankShortCode,
    required this.displayName,
  });

  Map<String, dynamic> toJson() => _$OrderPaymentMethodOptionsToJson(this);
}
