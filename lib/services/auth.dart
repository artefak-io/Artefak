import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final AuthService _authService = AuthService._internal();

  AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  static User? get user {
    return FirebaseAuth.instance.currentUser;
  }

  Future<User?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInEmailPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpEmailPass(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> changeUserInfo(String name) async {
    await _auth.currentUser!.updateDisplayName(name);
  }

  Future<void> requestOTP(
      {required String phoneNumber,
      required Function setTokenId,
      int? resendToken}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential authCredential) async {
        await _auth.signInWithCredential(authCredential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        if (exception.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? receivedToken) {
        setTokenId(receivedToken, verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: resendToken,
      timeout: const Duration(seconds: 30),
    );
  }

  Future<void> loginWithPhone(
      {required String verificationId, required String smsCode}) async {
    // TODO: this is a hack to allow backdoor
    if (smsCode == '000000') {
      await signInAnon();
      return;
    }

    PhoneAuthCredential result = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    await _auth.signInWithCredential(result);
  }
}
