part of 'confirm_otp_cubit.dart';

enum ConfirmOtpStatus {
  initial,
  inputInvalid,
  inputValid,
  success,
  loading,
  error,
}

@immutable
class ConfirmOtpState extends Equatable {
  const ConfirmOtpState({
    this.confirmOtpStatus = ConfirmOtpStatus.initial,
    this.otpInput = const OtpInput.pure(),
    this.otpInputValidationError = OtpInputValidationError.noError,
    this.errorMessage,
  });

  final ConfirmOtpStatus confirmOtpStatus;
  final OtpInput otpInput;
  final OtpInputValidationError otpInputValidationError;
  final String? errorMessage;

  @override
  List<Object> get props => [confirmOtpStatus, otpInputValidationError];

  ConfirmOtpState copyWith({
    ConfirmOtpStatus? confirmOtpStatus,
    OtpInput? otpInput,
    OtpInputValidationError? otpInputValidationError,
    String? errorMessage,
  }) {
    return ConfirmOtpState(
      confirmOtpStatus: confirmOtpStatus ?? this.confirmOtpStatus,
      otpInput: otpInput ?? this.otpInput,
      otpInputValidationError:
          otpInputValidationError ?? this.otpInputValidationError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
