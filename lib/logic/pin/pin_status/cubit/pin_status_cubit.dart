import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../pin.dart';

part 'pin_status_state.dart';

class PinStatusCubit extends Cubit<PinStatusState> {
  PinStatusCubit(this._pinService) : super(const PinStatusInitial());

  final PinService _pinService;

  void pinAuthChecked() async {
    try {
      if (await _pinService.hasUserDoc) {
        if (await _pinService.hasPin) {
          emit(const PinStatusHasPin());
        } else {
          emit(const PinStatusNoPin());
        }
      } else {
        emit(const PinStatusNoPin());
      }
    } catch (error) {
      emit(const PinStatusError());
    }
  }

  void pinAuthenticated() {
    emit(const PinStatusAuthenticated());
  }
}
