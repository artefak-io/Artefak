import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePictureService {
  ProfilePictureService._();
  static final ProfilePictureService _profilePictureService =
      ProfilePictureService._();
  factory ProfilePictureService() {
    return _profilePictureService;
  }

  FirebaseStorage cloudStorage = FirebaseStorage.instance;

  Future<void> setProfilePicture(User user, File? profilePicture) async {
    if (profilePicture != null) {
      UploadTask result = cloudStorage
          .ref()
          .child('users')
          .child(user.uid)
          .child('profile_picture')
          .putFile(profilePicture);
      result.then((p0) => p0.ref).then((value) async {
        String ppURL = await value.getDownloadURL();
        print(ppURL);
        user.updatePhotoURL(ppURL);
      });
    }
  }

  void deleteProfilePicture(User user) {
    user.updatePhotoURL(null);
  }
}
