import 'dart:ui';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/screens/main/profile.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  String _emailText = "";
  final _phoneController = TextEditingController();
  String _phoneText = "";

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
            child: Column(
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
                          colors: [_themeData.primaryColor, Colors.transparent],
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
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 80,
                        child: CircleAvatar(
                          child: Text('H', style: _textTheme.displayMedium),
                          radius: 64,
                          backgroundColor: Colors.white30,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: size.width * 0.15,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    Positioned(
                      top: 8.0,
                      left: 8.0,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
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
                          border: Border.all(width: 1, color: Colors.black26),
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
                            suffixIcon: _emailText.isEmpty
                                ? null
                                : IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => _emailController.clear(),
                                  ),
                            labelText: 'Nama',
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(color: Colors.white),
                          controller: _emailController,
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
                          border: Border.all(width: 1, color: Colors.black26),
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
                            suffixIcon: _phoneText.isEmpty
                                ? null
                                : IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => _phoneController.clear(),
                                  ),
                            labelText: 'No HP',
                            labelStyle: const TextStyle(color: Colors.white),
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
                                  padding: const EdgeInsets.all(16.0),
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
                                    onPressed: () {},
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
