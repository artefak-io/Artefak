import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../otp.dart';

part 'confirm_otp_state.dart';

class ConfirmOtpCubit extends Cubit<ConfirmOtpState> {
  ConfirmOtpCubit(this._otpService) : super(const ConfirmOtpState());
  final OtpService _otpService;

  void otpValidatedOnChange(String value) {
    OtpInput _otpInput = OtpInput.dirty(value: value);
    if (_otpInput.numberValidator() == OtpInputValidationError.nonNumberInput) {
      emit(state.copyWith(
        confirmOtpStatus: ConfirmOtpStatus.inputInvalid,
        otpInputValidationError: OtpInputValidationError.nonNumberInput,
      ));
    }
  }

  void otpValidatedOnCompleted(String otp) {
    await AuthService().loginWithPhone(verificationId: verificationId, smsCode: _codeController.text);
    if (value != otp) {
      emit(state.copyWith(
        confirmOtpStatus: ConfirmOtpStatus.inputInvalid,
        otpInputValidationError: OtpInputValidationError.inputDoesntMatch,
      ));
    } else {
      OtpInput _otpInput = OtpInput.dirty(value: value);
      if (_otpInput.valid) {
        emit(state.copyWith(
          otpInput: _otpInput,
          confirmOtpStatus: ConfirmOtpStatus.inputValid,
        ));
      } else {
        emit(state.copyWith(
          confirmOtpStatus: ConfirmOtpStatus.inputInvalid,
          otpInputValidationError: _otpInput.error,
        ));
      }
    }
  }

  // void otpCreated() async {
  //   if (state.confirmOtpStatus != ConfirmOtpStatus.inputValid) return;
  //   emit(state.copyWith(confirmOtpStatus: ConfirmOtpStatus.loading));
  //   try {
  //     if (await _otpService.hasUserDoc) {
  //       _otpService.updateOtp(state.otpInput.value);
  //     } else {
  //       _otpService.createOtp(state.otpInput.value);
  //     }
  //     emit(state.copyWith(confirmOtpStatus: ConfirmOtpStatus.success));
  //   } catch (error) {
  //     emit(state.copyWith(
  //       confirmOtpStatus: ConfirmOtpStatus.error,
  //       errorMessage: error.toString(),
  //     ));
  //   }
  // }
}
