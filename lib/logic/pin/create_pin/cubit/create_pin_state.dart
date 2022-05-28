part of 'create_pin_cubit.dart';

enum CreatePinStatus {
  initial,
  inputValid,
  inputInvalid,
  inputDoesNotMatch,
  success,
  error
}

class CreatePinState extends Equatable {
  final CreatePinStatus createPinStatus;
  final PinInput pinInput;

  const CreatePinState({
    this.createPinStatus = CreatePinStatus.initial,
    this.pinInput = const PinInput.pure(),
  });

  CreatePinState copyWith({
    CreatePinStatus? createPinStatus,
    PinInput? pinInput,
  }) {
    return CreatePinState(
        createPinStatus: createPinStatus ?? this.createPinStatus,
        pinInput: pinInput ?? this.pinInput);
  }

  @override
  List<Object> get props => [createPinStatus];
}
