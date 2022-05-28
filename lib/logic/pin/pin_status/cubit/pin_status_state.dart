part of 'pin_status_cubit.dart';

enum PinStatusStatus { initial, noPin, hasPin, error }

abstract class PinStatusState extends Equatable {
  final PinStatusStatus _pinStatusStatus;
  const PinStatusState(this._pinStatusStatus);

  @override
  List<Object> get props => [_pinStatusStatus];
}

class PinStatusInitial extends PinStatusState {
  const PinStatusInitial() : super(PinStatusStatus.initial);
}

class PinStatusNoPin extends PinStatusState {
  const PinStatusNoPin() : super(PinStatusStatus.noPin);
}

class PinStatusHasPin extends PinStatusState {
  const PinStatusHasPin() : super(PinStatusStatus.hasPin);
}

class PinStatusError extends PinStatusState {
  const PinStatusError() : super(PinStatusStatus.error);
}
