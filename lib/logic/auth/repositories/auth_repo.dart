import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  const AuthenticationRepository(this._firebaseAuth);

  bool get isLoggedIn {
    if (_firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  Stream<bool> get authState {
    return _firebaseAuth
        .authStateChanges()
        .map((user) => user == null ? false : true);
  }
}
