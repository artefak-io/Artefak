part of 'pin_status_cubit.dart';

enum PinStatusStatus { initial, noPin, hasPin, authenticated, error }

abstract class PinStatusState extends Equatable {
  final PinStatusStatus pinStatusStatus;
  const PinStatusState(this.pinStatusStatus);

  @override
  List<Object> get props => [pinStatusStatus];
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

class PinStatusAuthenticated extends PinStatusState {
  const PinStatusAuthenticated() : super(PinStatusStatus.authenticated);
}

class PinStatusError extends PinStatusState {
  const PinStatusError() : super(PinStatusStatus.error);
}
