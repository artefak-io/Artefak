import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../pin.dart';

part 'confirm_pin_state.dart';

class ConfirmPinCubit extends Cubit<ConfirmPinState> {
  ConfirmPinCubit(this._pinService) : super(const ConfirmPinState());
  final PinService _pinService;

  void pinValidatedOnChange(String value) {
    PinInput _pinInput = PinInput.dirty(value: value);
    if (_pinInput.numberValidator() == PinInputValidationError.nonNumberInput) {
      emit(state.copyWith(
        confirmPinStatus: ConfirmPinStatus.inputInvalid,
        pinInputValidationError: PinInputValidationError.nonNumberInput,
      ));
    }
  }

  void pinValidatedOnCompleted(String value, String pin) {
    if (value != pin) {
      emit(state.copyWith(
        confirmPinStatus: ConfirmPinStatus.inputInvalid,
        pinInputValidationError: PinInputValidationError.inputDoesntMatch,
      ));
    } else {
      PinInput _pinInput = PinInput.dirty(value: value);
      if (_pinInput.valid) {
        emit(state.copyWith(
          pinInput: _pinInput,
          confirmPinStatus: ConfirmPinStatus.inputValid,
        ));
      } else {
        emit(state.copyWith(
          confirmPinStatus: ConfirmPinStatus.inputInvalid,
          pinInputValidationError: _pinInput.error,
        ));
      }
    }
  }

  void pinCreated() async {
    if (state.confirmPinStatus != ConfirmPinStatus.inputValid) return;
    emit(state.copyWith(confirmPinStatus: ConfirmPinStatus.loading));
    try {
      if (await _pinService.hasUserDoc) {
        _pinService.updatePin(state.pinInput.value);
      } else {
        _pinService.createPin(state.pinInput.value);
      }
      emit(state.copyWith(confirmPinStatus: ConfirmPinStatus.success));
    } catch (error) {
      emit(state.copyWith(
        confirmPinStatus: ConfirmPinStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
