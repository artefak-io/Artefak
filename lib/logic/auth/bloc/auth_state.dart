part of 'auth_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

@immutable
abstract class AuthState extends Equatable {
  final AuthenticationStatus authenticationStatus;

  const AuthState(this.authenticationStatus);

  @override
  List<Object?> get props => [authenticationStatus];
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated() : super(AuthenticationStatus.authenticated);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated() : super(AuthenticationStatus.unauthenticated);
}
