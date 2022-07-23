import 'dart:ui';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/user_service.dart';
import 'package:artefak/widgets/appbar_actions_button.dart';
import 'package:artefak/widgets/profile_segment_setting.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/widgets/bottom_navbar.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  static const index = 4;

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
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            AuthService()
                                .signOut()
                                .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()),
                                    ));
                          },
                          child: Text(
                            'Log out',
                            style: _textTheme.bodySmall,
                          ),
                        ),
                        AppbarActionsButton(),
                      ],
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
                FutureBuilder<Map<String, dynamic>>(
                  future: UserService().getUser(AuthService.user!.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 144.0,
                              foregroundDecoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent],
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
                            Positioned.fill(
                              bottom: 0,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: 80,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!["profilePicture"],
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
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 4.0),
                              child: Text(snapshot.data!["displayName"],
                                  style: _textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w400)),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  AuthService.user!.email! +
                                      (AuthService.user!.email != "" &&
                                              AuthService.user!.phoneNumber !=
                                                  ""
                                          ? " • "
                                          : "") +
                                      AuthService.user!.phoneNumber!,
                                  style: _textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w400)),
                            ),
                            Container(
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
                            )),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 33.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: listProfileSetting
                        .map(
                          (item) => new ProfileSegmentSetting(
                            title: item.title,
                            settingItems: item.listSettingItem,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text('Keluar Aplikasi',
                          style: _textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: _themeData.hintColor)),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        'Version 0.2.8',
                        style: _textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: _themeData.focusColor),
                      ),
                      SizedBox(
                        height: 96.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: const BotNavBar(
            currentIndex: Profile.index,
          ),
        ),
      );
    }
  }
}
