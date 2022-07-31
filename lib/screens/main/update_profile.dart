import 'dart:io';
import 'dart:ui';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/screens/main/profile.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/services/image_picker_service.dart';
import 'package:artefak/services/user_service.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _nameText = "";
  String _phoneText = "";
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
    if (AuthService.user!.phoneNumber != null) {
      _phoneController.text = AuthService.user!.phoneNumber!;
    }
    if (kIsWeb != true && defaultTargetPlatform == TargetPlatform.android) {
      _restrieveLostData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      return AppLayout(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(64.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: AppBar(
                      toolbarHeight: 64.0,
                      automaticallyImplyLeading: false,
                      title: Text('Akun',
                          style: _textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: FutureBuilder<Map<String, dynamic>>(
              future: UserService().getUser(AuthService.user!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>> snapshot) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 64.0,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 144.0,
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _themeData.primaryColor,
                                Colors.transparent
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0, 0.2],
                            ),
                          ),
                          child: Image.asset(
                            "assets/cover_profile.png",
                            width: size.width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            height: 80,
                            child: ClipOval(
                              child: _profilePicture != null
                                  ? Image.file(_profilePicture!)
                                  : CachedNetworkImage(
                                      imageUrl:
                                          snapshot.data?["profilePicture"] ??
                                              "",
                                      fit: BoxFit.cover,
                                      width: 80.0,
                                      height: 80.0,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                            ),
                            //   },
                            // ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: size.width * 0.15,
                          child: InkWell(
                            onTap: () {
                              ImagePickerService()
                                  .retrieveImage()
                                  .then((value) {
                                setState(() {
                                  _profilePicture = File(value!.path);
                                });
                              }).catchError(
                                      (error) => print('error happen $error'));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 32.0,
                              decoration: BoxDecoration(
                                color: _themeData.dialogBackgroundColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                    size: 13.5,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "Ubah Foto",
                                    style: _textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8.0,
                          left: 8.0,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 32.0,
                              decoration: BoxDecoration(
                                color: _themeData.dialogBackgroundColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                    size: 13.5,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "Ubah Latar Belakang",
                                    style: _textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 0),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 32.0, top: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _themeData.selectedRowColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  "Terverifikasi",
                                  style: _textTheme.bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: _themeData.primaryColorDark,
                              border:
                                  Border.all(width: 1, color: Colors.black26),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.account_circle_outlined,
                                  color: _themeData.focusColor,
                                ),
                                suffixIcon: _nameText.isEmpty
                                    ? null
                                    : IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            _nameController.clear(),
                                      ),
                                labelText: 'Nama',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                              ),
                              style: const TextStyle(color: Colors.white),
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '*required';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            decoration: BoxDecoration(
                              color: _themeData.primaryColorDark,
                              border:
                                  Border.all(width: 1, color: Colors.black26),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.smartphone_outlined,
                                  color: _themeData.focusColor,
                                ),
                                suffixIcon: _phoneText.isEmpty
                                    ? null
                                    : IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            _phoneController.clear(),
                                      ),
                                labelText: 'No HP',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                              ),
                              style: const TextStyle(color: Colors.white),
                              controller: _phoneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '*required';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 80.0),
                            alignment: Alignment.bottomCenter,
                            height: 220.0,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: ElevatedButton(
                                        child: Text(
                                          "Simpan Perubahan",
                                          style: _textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            fixedSize:
                                                Size(size.width - 32.0, 48.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            alignment: Alignment.center),
                                        onPressed: () {
                                          UserService().setProfilePicture(
                                              AuthService.user!,
                                              _profilePicture);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar: BotNavBar(
            currentIndex: Profile.index,
          ),
        ),
      );
    }
  }
}
