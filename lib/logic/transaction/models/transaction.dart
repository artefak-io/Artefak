import 'package:equatable/equatable.dart';

import 'package:artefak/api/xfers/xfers.dart';

import '../enum/transaction_enum.dart';

class Transaction extends Equatable {
  final String id;
  final String assetId;
  final String buyerId;
  final TransactionStatus status;
  final int amount;
  final String epiredAt;
  final String paymentMethodId;
  final PaymentMethodType paymentMethodType;
  final String? paymentNumber;
  final String displayName;
  const Transaction({
    required this.id,
    required this.assetId,
    required this.buyerId,
    required this.status,
    required this.amount,
    required this.epiredAt,
    required this.paymentMethodId,
    required this.paymentMethodType,
    this.paymentNumber,
    required this.displayName,
  });

  static TransactionStatus _transactionStatusFromXfers(
      {required XfersPaymentStatus status}) {
    switch (status) {
      case XfersPaymentStatus.pending:
      case XfersPaymentStatus.processing:
      case XfersPaymentStatus.paid:
        return TransactionStatus.pending;
      case XfersPaymentStatus.completed:
        return TransactionStatus.completed;
      case XfersPaymentStatus.cancelled:
      case XfersPaymentStatus.expired:
        return TransactionStatus.cancelled;
      case XfersPaymentStatus.failed:
        return TransactionStatus.failed;
      case XfersPaymentStatus.unknown:
        return TransactionStatus.unknown;
    }
  }

  static TransactionStatus _transactionStatusFromString(
      {required String status}) {
    switch (status) {
      case 'pending':
        return TransactionStatus.pending;
      case 'completed':
        return TransactionStatus.completed;
      case 'cancelled':
        return TransactionStatus.cancelled;
      case 'failed':
        return TransactionStatus.failed;
      default:
        return TransactionStatus.unknown;
    }
  }

  static PaymentMethodType _paymentMethodTypeFromXfers(
      {required XfersPaymentMethodType xfersPaymentMethodType,
      XfersBankShortCode? xfersBankShortCode}) {
    if (xfersPaymentMethodType == XfersPaymentMethodType.virtualAccount) {
      switch (xfersBankShortCode) {
        case XfersBankShortCode.bca:
          return PaymentMethodType.vaBca;
        case XfersBankShortCode.bri:
          return PaymentMethodType.vaBri;
        case XfersBankShortCode.bni:
          return PaymentMethodType.vaBni;
        case XfersBankShortCode.mandiri:
          return PaymentMethodType.vaMandiri;
        case XfersBankShortCode.unknown:
        case null:
          return PaymentMethodType.unknown;
      }
    } else if (xfersPaymentMethodType == XfersPaymentMethodType.qris) {
      return PaymentMethodType.qris;
    } else {
      return PaymentMethodType.unknown;
    }
  }

  static PaymentMethodType _paymentMethodTypeFromString(
      {required String paymentMethodType}) {
    switch (paymentMethodType) {
      case 'vaBca':
        return PaymentMethodType.vaBca;
      case 'vaBri':
        return PaymentMethodType.vaBri;
      case 'vaBni':
        return PaymentMethodType.vaBni;
      case 'vaMandiri':
        return PaymentMethodType.vaMandiri;
      case 'qris':
        return PaymentMethodType.qris;
      default:
        return PaymentMethodType.unknown;
    }
  }

  factory Transaction.empty() {
    return const Transaction(
        id: '',
        assetId: '',
        buyerId: '',
        status: TransactionStatus.unknown,
        amount: 0,
        epiredAt: '',
        paymentMethodId: '',
        paymentMethodType: PaymentMethodType.unknown,
        displayName: '');
  }

  factory Transaction.fromXfers(
      Invoice invoice, String assetId, String buyerId) {
    return Transaction(
      id: invoice.attributes.referenceId,
      assetId: assetId,
      buyerId: buyerId,
      status: _transactionStatusFromXfers(status: invoice.attributes.status),
      amount: int.parse(invoice.attributes.amount),
      epiredAt: invoice.attributes.expiredAt,
      paymentMethodId: invoice.attributes.paymentMethod.id,
      paymentMethodType: _paymentMethodTypeFromXfers(
        xfersPaymentMethodType: invoice.attributes.paymentMethod.type,
        xfersBankShortCode:
            invoice.attributes.paymentMethod.instructions.bankShortCode,
      ),
      displayName: invoice.attributes.paymentMethod.instructions.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'assetId': assetId,
      'buyerId': buyerId,
      'status': status.name,
      'amount': amount,
      'epiredAt': epiredAt,
      'paymentMethodId': paymentMethodId,
      'paymentMethodType': paymentMethodType.name,
      'paymentNumber': paymentNumber,
      'displayName': displayName,
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      assetId,
      buyerId,
      amount,
      epiredAt,
      paymentMethodId,
      paymentMethodType,
      displayName,
    ];
  }

  factory Transaction.fromMap(
      {required Map<String, dynamic> map, required String id}) {
    return Transaction(
      id: id,
      assetId: map['assetId'] as String,
      buyerId: map['buyerId'] as String,
      status: _transactionStatusFromString(status: map['status'] as String),
      amount: map['amount'] as int,
      epiredAt: map['epiredAt'] as String,
      paymentMethodId: map['paymentMethodId'] as String,
      paymentMethodType: _paymentMethodTypeFromString(
          paymentMethodType: map['paymentMethodType'] as String),
      paymentNumber:
          map['paymentNumber'] != null ? map['paymentNumber'] as String : null,
      displayName: map['displayName'] as String,
    );
  }
}
