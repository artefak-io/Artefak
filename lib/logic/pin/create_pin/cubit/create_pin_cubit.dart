import 'package:artefak/logic/pin/repository/pin_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_pin_state.dart';

class CreatePinCubit extends Cubit<CreatePinState> {
  CreatePinCubit(this._pinService) : super(const CreatePinState());
  final PinService _pinService;

  void pinVerified(String value) {
    PinInput _pinInput = PinInput.pure(value: value);

    if (_pinInput.valid) {
      emit(state.copyWith(
        pinInput: _pinInput,
        createPinStatus: CreatePinStatus.inputValid,
      ));
    } else {
      emit(state.copyWith(createPinStatus: CreatePinStatus.inputInvalid));
    }
  }

  void pinCreated(String value) async {
    if (value != state.pinInput.value) {
      emit(state.copyWith(createPinStatus: CreatePinStatus.inputDoesNotMatch));
    } else {
      try {
        if (await _pinService.hasUserDoc) {
          _pinService.updatePin(value);
        } else {
          _pinService.createPin(value);
        }
        emit(state.copyWith(createPinStatus: CreatePinStatus.success));
      } catch (error) {
        emit(state.copyWith(createPinStatus: CreatePinStatus.error));
      }
    }
  }

  void pinCreateInitial() {
    emit(state.copyWith(
      pinInput: const PinInput.pure(),
      createPinStatus: CreatePinStatus.initial,
    ));
  }
}
