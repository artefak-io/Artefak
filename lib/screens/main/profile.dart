import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/asset_service.dart';
import 'package:artefak/services/wallet_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:artefak/services/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/carousel_profile.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  static const index = 2;

  late final Stream<QuerySnapshot> _assetStream;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      _assetStream = AssetService().personalAssets(AuthService.user!.uid);

      return AppLayout(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: _themeData.textSelectionColor,
                  size: 30.0,
                ),
                onPressed: () {},
              ),
              title: Text('Profile',
                  style: _textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w400)),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    AuthService().signOut().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        ));
                  },
                  child: Text(
                    'Log out',
                    style: _textTheme.bodySmall,
                  ),
                ),
              ]),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.45,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.45 - 60,
                        decoration: BoxDecoration(
                          color: _themeData.highlightColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: AuthService.user!.photoURL != null
                                        ? CircleAvatar(
                                            foregroundImage:
                                                CachedNetworkImageProvider(
                                                    AuthService
                                                        .user!.photoURL!),
                                            radius: 60,
                                            backgroundColor: Colors.white30,
                                          )
                                        : CircleAvatar(
                                            radius: 60,
                                            backgroundColor: Colors.white30,
                                            child:
                                                AuthService.user!.displayName !=
                                                        ""
                                                    ? Text(
                                                        AuthService.user!
                                                            .displayName![0],
                                                        style: _textTheme
                                                            .headlineLarge)
                                                    : null,
                                          ),
                                  ),
                                  const SizedBox(width: 18),
                                  Flexible(
                                    flex: 3,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AuthService.user!.displayName != ""
                                                ? AuthService.user!.displayName!
                                                : "[Edit Name]",
                                            style:
                                                _textTheme.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            AuthService.user!.email != ""
                                                ? AuthService.user!.email!
                                                : "[Edit Email]",
                                            style:
                                                _textTheme.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ]),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      WalletFirestore()
                                          .createWallet(AuthService.user!.uid);
                                    },
                                    child: Text('Create Wallet',
                                        style: _textTheme.bodyMedium
                                            ?.copyWith(color: Colors.white)),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      '/mint',
                                    ),
                                    child: Text('Mint',
                                        style: _textTheme.bodyMedium
                                            ?.copyWith(color: Colors.white)),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      '/update_profile',
                                    ),
                                    child: Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 4),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                                width: 1, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Edit Profile',
                                              style: _textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                            const Icon(
                                              Icons.chevron_right,
                                              color: Colors.white,
                                              size: 28.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          height: 120,
                          child: const Carousel(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _assetStream,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      //needs to show something when user doesn't own any asset yet
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('An error has occurred!'),
                        );
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/asset',
                                    arguments: <String, dynamic>{
                                      'id': snapshot.data!.docs[index].id,
                                      'currentOwner': snapshot.data!.docs[index]
                                          ['currentOwner'],
                                      'creator': snapshot.data!.docs[index]
                                          ['creator'],
                                      'name': snapshot.data!.docs[index]
                                          ['name'],
                                      'description': snapshot.data!.docs[index]
                                          ['description'],
                                      'coverImage': snapshot.data!.docs[index]
                                          ['coverImage'],
                                      'views': snapshot.data!.docs[index]
                                          ['views'],
                                      'contractAddress': snapshot
                                          .data!.docs[index]['contractAddress'],
                                      'tokenId': snapshot.data!.docs[index]
                                          ['tokenId'],
                                      'price': snapshot.data!.docs[index]
                                          ['price'],
                                    });
                              },
                              // needs loading indicator when image being reloaded
                              child: Image.network(
                                  snapshot.data!.docs[index]['coverImage']),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
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
