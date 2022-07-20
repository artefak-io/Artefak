part of 'otp_auth_cubit.dart';

enum OtpAuthStatus {
  initial,
  filled,
  success,
  failure,
  error,
  not_filled,
}

class OtpAuthState extends Equatable {
  final OtpAuthStatus otpAuthStatus;
  final OtpInput otpInput;
  final OtpInputValidationError otpInputValidationError;
  final String? errorMessage;
  final String? otp;

  const OtpAuthState({
    this.otpAuthStatus = OtpAuthStatus.initial,
    this.otpInput = const OtpInput.pure(),
    this.otpInputValidationError = OtpInputValidationError.noError,
    this.errorMessage,
    this.otp,
  });

  @override
  List<Object> get props => [otpAuthStatus, otpInputValidationError];

  OtpAuthState copyWith({
    OtpAuthStatus? otpAuthStatus,
    OtpInput? otpInput,
    OtpInputValidationError? otpInputValidationError,
    String? errorMessage,
    String? otp,
  }) {
    return OtpAuthState(
      otpAuthStatus: otpAuthStatus ?? this.otpAuthStatus,
      otpInput: otpInput ?? this.otpInput,
      otpInputValidationError: this.otpInputValidationError,
      errorMessage: errorMessage ?? this.errorMessage,
      otp: otp ?? this.otp,
    );
  }
}
