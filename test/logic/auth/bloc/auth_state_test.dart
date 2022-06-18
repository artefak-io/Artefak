// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:artefak/logic/auth/auth.dart';

void main() {
  group('AuthState', () {
    group('AuthAuthenticated', () {
      final state1 = AuthAuthenticated();

      test('should equal', () {
        final state2 = AuthAuthenticated();
        expect(state1 == state2, true);
      });
    });
    group('AuthUnauthenticated', () {});
  });
}
