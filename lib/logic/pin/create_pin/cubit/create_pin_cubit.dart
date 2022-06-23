import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../pin.dart';

part 'create_pin_state.dart';

class CreatePinCubit extends Cubit<CreatePinState> {
  CreatePinCubit() : super(const CreatePinState());

  void pinValidatedOnCompleted(String value) {
    PinInput _pinInput = PinInput.dirty(value: value);
    if (_pinInput.valid) {
      emit(state.copyWith(
        pinInput: _pinInput,
        createPinStatus: CreatePinStatus.inputValid,
        invalid: PinInputValidationError.noError,
      ));
    } else {
      emit(state.copyWith(
          createPinStatus: CreatePinStatus.inputInvalid,
          invalid: _pinInput.error));
    }
  }

  void pinValidatedOnChanged(String value) {
    PinInput _pinInput = PinInput.dirty(value: value);
    if (_pinInput.numberValidator() == PinInputValidationError.nonNumberInput) {
      emit(state.copyWith(
        createPinStatus: CreatePinStatus.inputInvalid,
        invalid: _pinInput.numberValidator(),
      ));
    } else {
      emit(state.copyWith(
        createPinStatus: CreatePinStatus.initial,
        invalid: PinInputValidationError.noError,
      ));
    }
  }

  void pinSucceed() {
    if (state.createPinStatus == CreatePinStatus.inputValid) {
      emit(state.copyWith(createPinStatus: CreatePinStatus.success));
    }
  }

  void pinCreateValid() {
    if (state.createPinStatus == CreatePinStatus.success) {
      emit(state.copyWith(createPinStatus: CreatePinStatus.inputValid));
    }
  }

  void pinCreateInitial() {
    emit(state.copyWith(
      createPinStatus: CreatePinStatus.initial,
    ));
  }
}
