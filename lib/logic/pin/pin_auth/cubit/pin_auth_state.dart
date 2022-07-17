part of 'pin_auth_cubit.dart';

enum PinAuthStatus {
  initial,
  filled,
  success,
  failure,
  error,
  not_filled,
}

class PinAuthState extends Equatable {
  final PinAuthStatus pinAuthStatus;
  final PinInput pinInput;
  final PinInputValidationError pinInputValidationError;
  final String? errorMessage;
  final String? pin;

  const PinAuthState({
    this.pinAuthStatus = PinAuthStatus.initial,
    this.pinInput = const PinInput.pure(),
    this.pinInputValidationError = PinInputValidationError.noError,
    this.errorMessage,
    this.pin,
  });

  @override
  List<Object> get props => [pinAuthStatus, pinInputValidationError];

  PinAuthState copyWith({
    PinAuthStatus? pinAuthStatus,
    PinInput? pinInput,
    PinInputValidationError? pinInputValidationError,
    String? errorMessage,
    String? pin,
  }) {
    return PinAuthState(
      pinAuthStatus: pinAuthStatus ?? this.pinAuthStatus,
      pinInput: pinInput ?? this.pinInput,
      pinInputValidationError: this.pinInputValidationError,
      errorMessage: errorMessage ?? this.errorMessage,
      pin: pin ?? this.pin,
    );
  }
}
