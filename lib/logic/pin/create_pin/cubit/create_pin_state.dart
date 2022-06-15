part of 'create_pin_cubit.dart';

enum CreatePinStatus { initial, inputValid, inputInvalid, success }

@immutable
class CreatePinState extends Equatable {
  final CreatePinStatus createPinStatus;
  final PinInput pinInput;
  final PinInputValidationError invalid;

  const CreatePinState({
    this.createPinStatus = CreatePinStatus.initial,
    this.pinInput = const PinInput.pure(),
    this.invalid = PinInputValidationError.noError,
  });

  CreatePinState copyWith({
    CreatePinStatus? createPinStatus,
    PinInput? pinInput,
    PinInputValidationError? invalid,
  }) {
    return CreatePinState(
      createPinStatus: createPinStatus ?? this.createPinStatus,
      pinInput: pinInput ?? this.pinInput,
      invalid: invalid ?? this.invalid,
    );
  }

  @override
  List<Object> get props => [createPinStatus, invalid];
}
