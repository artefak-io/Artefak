part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStateChanged extends AuthEvent {
  final bool isLoggedIn;

  const AuthStateChanged(this.isLoggedIn);

  @override
  List<Object?> get props => [isLoggedIn];
}
