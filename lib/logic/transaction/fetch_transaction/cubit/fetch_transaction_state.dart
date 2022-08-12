// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'fetch_transaction_cubit.dart';

enum FetchTransactionStatus { initial, success, loading, failure }

class FetchTransactionState extends Equatable {
  FetchTransactionState({
    this.fetchTransactionStatus = FetchTransactionStatus.initial,
    Transaction? transaction,
  }) : transaction = transaction ?? Transaction.empty();

  final FetchTransactionStatus fetchTransactionStatus;
  final Transaction transaction;

  @override
  List<Object> get props => [fetchTransactionStatus, transaction];

  FetchTransactionState copyWith({
    FetchTransactionStatus? fetchTransactionStatus,
    Transaction? transaction,
  }) {
    return FetchTransactionState(
      fetchTransactionStatus:
          fetchTransactionStatus ?? this.fetchTransactionStatus,
      transaction: transaction ?? this.transaction,
    );
  }
}
