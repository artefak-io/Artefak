import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_firestore;

class OtpService {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final firebase_firestore.FirebaseFirestore _firebaseFirestore;

  const OtpService(this._firebaseAuth, this._firebaseFirestore);

  // AuthService().loginWithPhone(
  //                         verificationId: verificationId,
  //                         smsCode: _codeController.text);

  Future<String> get otp async {
    try {
      firebase_firestore.DocumentSnapshot<Map<String, dynamic>> result =
          await _firebaseFirestore
              .collection("User")
              .doc(_firebaseAuth.currentUser!.uid)
              .get();
      return result.data()!["otp"];
    } on firebase_firestore.FirebaseException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception("get otp error");
    }
  }

  Future<void> createOtp(String value) async {
    try {
      await _firebaseFirestore
          .collection("User")
          .doc(_firebaseAuth.currentUser!.uid)
          .set({"otp": value});
    } on firebase_firestore.FirebaseException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception("create otp error. ");
    }
  }
}
