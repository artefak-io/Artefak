part of 'otp_status_cubit.dart';

enum OtpStatus { initial, noOtp, hasOtp, authenticated, error }

abstract class OtpStatusState extends Equatable {
  final OtpStatus otpStatus;
  const OtpStatusState(this.otpStatus);

  @override
  List<Object> get props => [otpStatus];
}

class OtpStatusInitial extends OtpStatusState {
  const OtpStatusInitial() : super(OtpStatus.initial);
}

class OtpStatusNoOtp extends OtpStatusState {
  const OtpStatusNoOtp() : super(OtpStatus.noOtp);
}

class OtpStatusHasOtp extends OtpStatusState {
  const OtpStatusHasOtp() : super(OtpStatus.hasOtp);
}

class OtpStatusAuthenticated extends OtpStatusState {
  const OtpStatusAuthenticated() : super(OtpStatus.authenticated);
}

class OtpStatusError extends OtpStatusState {
  const OtpStatusError() : super(OtpStatus.error);
}
