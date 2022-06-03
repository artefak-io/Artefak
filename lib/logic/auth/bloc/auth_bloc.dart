import 'dart:async';

import '../repositories/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authenticationRepository)
      : super(_authenticationRepository.isLoggedIn
            ? const AuthAuthenticated()
            : const AuthUnauthenticated()) {
    on<AuthStateChanged>(_onStateChanged);
    _authSubscription = _authenticationRepository.authState.listen((event) {
      add(AuthStateChanged(event));
    });
  }

  void _onStateChanged(AuthStateChanged event, Emitter<AuthState> emit) {
    emit(event.isLoggedIn
        ? const AuthAuthenticated()
        : const AuthUnauthenticated());
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<bool> _authSubscription;

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
