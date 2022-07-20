import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../otp.dart';

part 'otp_status_state.dart';

class OtpStatusCubit extends Cubit<OtpStatusState> {
  OtpStatusCubit(this._otpService) : super(const OtpStatusInitial());

  final OtpService _otpService;

  void otpAuthChecked() async {
    try {
      emit(const OtpStatusNoOtp());
        if (await _otpService.hasOtp) {
          emit(const OtpStatusHasOtp());
        } else {
          emit(const OtpStatusNoOtp());
        }
    } catch (error) {
      emit(const OtpStatusError());
    }
  }

  void otpAuthenticated() {
    emit(const OtpStatusAuthenticated());
  }
}
