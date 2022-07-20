import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../otp.dart';

part 'otp_auth_state.dart';

class OtpAuthCubit extends Cubit<OtpAuthState> {
  OtpAuthCubit(this._otpService) : super(const OtpAuthState());

  final OtpService _otpService;

  void otpRetrieved() async {
    try {
      emit(state.copyWith(otp: await _otpService.otp));
    } catch (error) {
      emit(state.copyWith(
        otpAuthStatus: OtpAuthStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void otpFilled(String value) {
    if (value.length == 6) {
      emit(state.copyWith(
          otpAuthStatus: OtpAuthStatus.filled,
          otpInput: OtpInput.dirty(value: value)));
    } else {
      emit(state.copyWith(
          otpAuthStatus: OtpAuthStatus.not_filled,
          otpInput: OtpInput.dirty(value: value)));
    }
  }

  void otpVerified() {
    if (state.otp == null) {
      emit(state.copyWith(
        otpAuthStatus: OtpAuthStatus.error,
        errorMessage: "Please wait a minute",
      ));
      return;
    }
    if (state.otpInput.value == state.otp) {
      emit(state.copyWith(otpAuthStatus: OtpAuthStatus.success));
    } else {
      emit(state.copyWith(
        otpAuthStatus: OtpAuthStatus.failure,
        otpInputValidationError: OtpInputValidationError.inputDoesntMatch,
      ));
    }
  }
}
