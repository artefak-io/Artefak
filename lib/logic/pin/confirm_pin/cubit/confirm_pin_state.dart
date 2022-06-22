part of 'confirm_pin_cubit.dart';

enum ConfirmPinStatus {
  initial,
  inputInvalid,
  inputValid,
  success,
  loading,
  error,
}

@immutable
class ConfirmPinState extends Equatable {
  const ConfirmPinState({
    this.confirmPinStatus = ConfirmPinStatus.initial,
    this.pinInput = const PinInput.pure(),
    this.pinInputValidationError = PinInputValidationError.noError,
    this.errorMessage,
  });

  final ConfirmPinStatus confirmPinStatus;
  final PinInput pinInput;
  final PinInputValidationError pinInputValidationError;
  final String? errorMessage;

  @override
  List<Object> get props => [confirmPinStatus, pinInputValidationError];

  ConfirmPinState copyWith({
    ConfirmPinStatus? confirmPinStatus,
    PinInput? pinInput,
    PinInputValidationError? pinInputValidationError,
    String? errorMessage,
  }) {
    return ConfirmPinState(
      confirmPinStatus: confirmPinStatus ?? this.confirmPinStatus,
      pinInput: pinInput ?? this.pinInput,
      pinInputValidationError:
          pinInputValidationError ?? this.pinInputValidationError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
