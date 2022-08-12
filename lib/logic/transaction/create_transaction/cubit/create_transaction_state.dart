part of 'create_transaction_cubit.dart';

enum CreateTransactionStatus {
  initial,
  loading,
  success,
}

class CreateTransactionState extends Equatable {
  const CreateTransactionState(
      {this.createTransactionStatus = CreateTransactionStatus.initial,
      this.paymentMethodType = PaymentMethodType.unknown,
      this.order = _OrderPlus.empty});

  final CreateTransactionStatus createTransactionStatus;
  final PaymentMethodType paymentMethodType;
  final Order order;

  @override
  List<Object> get props => [createTransactionStatus, paymentMethodType, order];
}

extension _OrderPlus on Order {
  static const empty = Order(
    data: OrderData(
      attributes: OrderAttributes(
        referenceId: '',
        amount: 0,
        description: '',
        expiredAt: '',
        paymentMethodType: XfersPaymentMethodType.unknown,
        paymentMethodOptions: OrderPaymentMethodOptions(
          displayName: '',
        ),
      ),
    ),
  );
}
