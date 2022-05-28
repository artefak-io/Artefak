import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/pin_repo.dart';
part 'pin_auth_state.dart';

class PinAuthCubit extends Cubit<PinAuthState> {
  PinAuthCubit(this._pinService) : super(const PinAuthInitial());

  final PinService _pinService;

  void pinAuthenticated(String value) async {
    try {
      if (value == await _pinService.pin) {
        emit(const PinAuthSuccess());
      } else {
        emit(const PinAuthFailure());
      }
    } catch (error) {
      emit(const PinAuthError());
    }
  }
}
