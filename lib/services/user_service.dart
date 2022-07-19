import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  UserService._();
  static final UserService _userService =
      UserService._();
  factory UserService() {
    return _userService;
  }

  FirebaseStorage cloudStorage = FirebaseStorage.instance;

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> setProfilePicture(User user, File? profilePicture) async {
    if (profilePicture != null) {
      UploadTask result = cloudStorage
          .ref()
          .child('users')
          .child(user.uid)
          .child('profile_picture')
          .putFile(profilePicture);
      result.then((p0) => p0.ref).then((value) async {
        String profilePictureURL = await value.getDownloadURL();
        print(profilePictureURL);
        user.updatePhotoURL(profilePictureURL);
      });
    }
  }

  Future<String> getProfilePicture(User user) async {
    try {
      firebase_firestore.DocumentSnapshot<Map<String, dynamic>> result =
      await _firebaseFirestore
          .collection("User")
          .doc(user.uid)
          .get();
      return result.data()!["profilePicture"];
    } on firebase_firestore.FirebaseException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception("get profile picture error");
    }
  }

  Future<Map<String, dynamic>> getUser(String userid) async {
    try {
      firebase_firestore.DocumentSnapshot<Map<String, dynamic>> result =
      await _firebaseFirestore
          .collection('User')
          .doc(userid)
          .get();
      return result.data()!;
    } on firebase_firestore.FirebaseException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception("get user error");
    }
  }

  void deleteProfilePicture(User user) {
    user.updatePhotoURL(null);
  }
}
