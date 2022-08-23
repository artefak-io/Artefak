import 'package:artefak/logic/transaction/models/models.dart';
import 'package:artefak/logic/transaction/repositories/firebase_transaction.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_transaction_state.dart';

//TODO: Should be a bloc so this could reflect when there are changes
class FetchTransactionCubit extends Cubit<FetchTransactionState> {
  FetchTransactionCubit(this._firebaseTransaction)
      : super(FetchTransactionState());

  final FirebaseTransaction _firebaseTransaction;

  void transactionFetched(String id) async {
    emit(
        state.copyWith(fetchTransactionStatus: FetchTransactionStatus.loading));

    try {
      emit(state.copyWith(
        fetchTransactionStatus: FetchTransactionStatus.success,
        transaction: await _firebaseTransaction.getTransaction(id),
      ));
    } catch (e) {
      emit(state.copyWith(
        fetchTransactionStatus: FetchTransactionStatus.failure,
      ));
    }
  }
}
