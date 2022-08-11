import 'package:artefak/api/xfers/xfers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../enum/transaction_enum.dart';

part 'create_transaction_state.dart';

class CreateTransactionCubit extends Cubit<CreateTransactionState> {
  CreateTransactionCubit() : super(const CreateTransactionState());
}
