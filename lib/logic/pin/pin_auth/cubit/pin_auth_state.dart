part of 'pin_auth_cubit.dart';

enum PinAuthStatus { initial, success, failure, error }

abstract class PinAuthState extends Equatable {
  final PinAuthStatus _pinAuthStatus;

  const PinAuthState(this._pinAuthStatus);

  @override
  List<Object> get props => [_pinAuthStatus];
}

class PinAuthInitial extends PinAuthState {
  const PinAuthInitial() : super(PinAuthStatus.initial);
}

class PinAuthSuccess extends PinAuthState {
  const PinAuthSuccess() : super(PinAuthStatus.success);
}

class PinAuthFailure extends PinAuthState {
  const PinAuthFailure() : super(PinAuthStatus.failure);
}

class PinAuthError extends PinAuthState {
  const PinAuthError() : super(PinAuthStatus.error);
}
