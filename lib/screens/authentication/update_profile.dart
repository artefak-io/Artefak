import 'dart:io';

import 'package:artefak/services/auth.dart';
import 'package:artefak/services/image_picker_service.dart';
import 'package:artefak/services/profile_picture_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File? _profilePicture;

  ImageProvider? _previewImage() {
    if (_profilePicture != null) {
      return FileImage(_profilePicture!);
    } else if (AuthService.user!.photoURL != null) {
      return NetworkImage(AuthService.user!.photoURL!);
    } else {
      return null;
    }
  }

  Future<void> _restrieveLostData() async {
    File? result = await ImagePickerService().retrieveLostData();
    if (result != null) {
      setState(() {
        _profilePicture = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (AuthService.user!.displayName != null) {
      _nameController.text = AuthService.user!.displayName!;
    }
    if (kIsWeb != true && defaultTargetPlatform == TargetPlatform.android) {
      _restrieveLostData();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30.0,
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            // there must be a better way too just like in the profile screen
            CircleAvatar(
              foregroundImage: _previewImage(),
              radius: 60,
              backgroundColor: Colors.red,
              child: AuthService.user!.displayName != null
                  ? Text(AuthService.user!.displayName![0])
                  : null,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*required';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ImagePickerService().retrieveImage().then((value) {
                        setState(() {
                          _profilePicture = File(value!.path);
                        });
                      }).catchError((error) => print('error happen $error'));
                    },
                    child: const Text('Select Picture'),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthService()
                            .changeUserInfo(_nameController.text);
                      }
                      ProfilePictureService().setProfilePicture(
                          AuthService.user!, _profilePicture);
                    },
                  ),
                  // for development use only
                  ElevatedButton(
                    onPressed: () {
                      ProfilePictureService()
                          .deleteProfilePicture(AuthService.user!);
                    },
                    child: const Text('Delelete Profile Picture'),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
