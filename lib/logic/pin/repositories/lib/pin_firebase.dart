import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_firestore;

class PinService {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final firebase_firestore.FirebaseFirestore _firebaseFirestore;

  const PinService(this._firebaseAuth, this._firebaseFirestore);

  Future<bool> get hasPin async {
    try {
      return _firebaseFirestore
          .collection('User')
          .doc(_firebaseAuth.currentUser!.uid)
          .get()
          .then((value) => value.data()!.containsKey("pin"));
    } on firebase_firestore.FirebaseException catch (error) {
      print("error code: ${error.code}");
      print("error message: ${error.message}");
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String> get pin async {
    try {
      firebase_firestore.DocumentSnapshot<Map<String, dynamic>> result =
          await _firebaseFirestore
              .collection("User")
              .doc(_firebaseAuth.currentUser!.uid)
              .get();
      return result.data()!["pin"];
    } on firebase_firestore.FirebaseException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception("get pin error");
    }
  }

  Future<void> createPin(String value) async {
    try {
      await _firebaseFirestore
          .collection("User")
          .doc(_firebaseAuth.currentUser!.uid)
          .set({"pin": value});
    } on firebase_firestore.FirebaseException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception("create pin error. ");
    }
  }

  Future<bool> get hasUserDoc async {
    try {
      return _firebaseFirestore
          .collection('User')
          .doc(_firebaseAuth.currentUser!.uid)
          .get()
          .then((value) => value.exists);
    } on firebase_firestore.FirebaseException catch (error) {
      print("error code: ${error.code}");
      print("error message: ${error.message}");
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<void> updatePin(String value) async {
    try {
      await _firebaseFirestore
          .collection("User")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({"pin": value});
    } on firebase_firestore.FirebaseException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception("update pin error");
    }
  }
}
