import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../pin.dart';

part 'pin_auth_state.dart';

class PinAuthCubit extends Cubit<PinAuthState> {
  PinAuthCubit(this._pinService) : super(const PinAuthState());

  final PinService _pinService;

  void pinRetrieved() async {
    try {
      emit(state.copyWith(pin: await _pinService.pin));
    } catch (error) {
      emit(state.copyWith(
        pinAuthStatus: PinAuthStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void pinFilled(String value) {
    if (value.length == 6) {
      emit(state.copyWith(
          pinAuthStatus: PinAuthStatus.filled,
          pinInput: PinInput.dirty(value: value)));
    } else {
      emit(state.copyWith(
          pinAuthStatus: PinAuthStatus.not_filled,
          pinInput: PinInput.dirty(value: value)));
    }
  }

  void pinVerified() {
    if (state.pin == null) {
      emit(state.copyWith(
        pinAuthStatus: PinAuthStatus.error,
        errorMessage: "Please wait a minute",
      ));
      return;
    }
    if (state.pinInput.value == state.pin) {
      emit(state.copyWith(pinAuthStatus: PinAuthStatus.success));
    } else {
      emit(state.copyWith(
        pinAuthStatus: PinAuthStatus.failure,
        pinInputValidationError: PinInputValidationError.inputDoesntMatch,
      ));
    }
  }
}
