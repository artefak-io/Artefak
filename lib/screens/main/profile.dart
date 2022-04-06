import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/screens/authentication/sign_in.dart';
import 'package:artefak/services/asset_service.dart';
import 'package:artefak/services/wallet_firestore.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/carousel_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:artefak/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  static const index = 2;

  late final Stream<QuerySnapshot> _assetStream;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      _assetStream = AssetService().personalAssets(AuthService.user!.uid);

      return Scaffold(
        backgroundColor: Color(0xFFEFEFEF),
        appBar:AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {},
            ),
            title: const Text('Profile'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  AuthService().signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  ));
                  
                },
                child: Text('Log out', style: TextStyle(color: Colors.white),),
              ),
            ]
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.45,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.45 - 60,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child:
                                  AuthService.user!.photoURL != null ?
                                  CircleAvatar(
                                    foregroundImage: CachedNetworkImageProvider(AuthService.user!.photoURL!),
                                    // NetworkImage(AuthService.user!.photoURL!),
                                    radius: 60,
                                    backgroundColor: Colors.white30,
                                    child: AuthService.user!.displayName != null
                                        ? Text(AuthService.user!.displayName![0])
                                        : null,
                                  )
                                      : CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.white30,
                                    child: AuthService.user!.displayName != null
                                        ? Text(AuthService.user!.displayName![0], style: GoogleFonts.inter(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFB80D0D)
                                    ))
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                    width: 18
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(AuthService.user?.providerData[0].displayName?? "[Edit Name]", style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFFFFFFF)
                                        ),),
                                        Text(AuthService.user?.providerData[0].email ?? "[Edit Email]", style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFFFFFFF)
                                        ),),
                                      ]
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    WalletFirestore().createWallet(AuthService.user!.uid);
                                  },
                                  child: const Text('Create Wallet', style: TextStyle(color: Colors.white)),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    '/mint',
                                  ),
                                  child: const Text('Mint', style: TextStyle(color: Colors.white)),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.symmetric(vertical: 2),
                                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.white
                                        ),
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    child:
                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        '/updateProfile',
                                      ),
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                              Text('Edit Profile', style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFFFFFFFF)
                                              ),),

                                              Icon(
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
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: 120,
                          child: Carousel(),
                        )
                    )
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
                                    'currentOwner': snapshot.data!.docs[index]
                                    ['currentOwner'],
                                    'creator': snapshot.data!.docs[index]
                                    ['creator'],
                                    'name': snapshot.data!.docs[index]['name'],
                                    'description': snapshot.data!.docs[index]
                                    ['description'],
                                    'coverImage': snapshot.data!.docs[index]
                                    ['coverImage'],
                                    'views': snapshot.data!.docs[index]
                                    ['views'],
                                    'externalLink': snapshot.data!.docs[index]
                                    ['externalLink'],
                                    'contractAddress': snapshot
                                        .data!.docs[index]['contractAddress'],
                                    'tokenId': snapshot.data!.docs[index]
                                    ['tokenId'],
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
        // body: SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //           // there must be a better way to do this either by using
        //           // imagestream, imageprovider or another stream widget
        //           AuthService.user!.photoURL != null
        //               ? CircleAvatar(
        //                   foregroundImage:
        //                       NetworkImage(AuthService.user!.photoURL!),
        //                   radius: 60,
        //                   backgroundColor: Colors.red,
        //                   child: AuthService.user!.displayName != null
        //                       ? Text(AuthService.user!.displayName![0])
        //                       : null,
        //                 )
        //               : CircleAvatar(
        //                   radius: 60,
        //                   backgroundColor: Colors.red,
        //                   child: AuthService.user!.displayName != null
        //                       ? Text(AuthService.user!.displayName![0])
        //                       : null,
        //                 ),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               const Text('Name'),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(
        //                   vertical: 10.0,
        //                 ),
        //                 child: Text(AuthService.user!.displayName ?? ''),
        //               ),
        //               const Text('Email'),
        //               Padding(
        //                 padding: const EdgeInsets.only(
        //                   top: 10,
        //                 ),
        //                 child: Text(AuthService.user!.email!),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       ElevatedButton(
        //         onPressed: () => Navigator.pushNamed(
        //           context,
        //           '/updateProfile',
        //         ),
        //         child: const Text('Update Profile'),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           WalletFirestore().createWallet(AuthService.user!.uid);
        //         },
        //         child: const Text('Create Wallet'),
        //       ),
        //       ElevatedButton(
        //         onPressed: () => Navigator.pushNamed(
        //           context,
        //           '/mint',
        //         ),
        //         child: const Text('Mint'),
        //       ),
        //       ElevatedButton(
        //         child: const Text('Log out'),
        //         onPressed: () async {
        //           AuthService().signOut();
        //         },
        //       ),
        //       SizedBox(
        //         height: 400,
        //         child: StreamBuilder<QuerySnapshot>(
        //           stream: _assetStream,
        //           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //             //needs to show something when user doesn't own any asset yet
        //             if (snapshot.hasError) {
        //               return const Center(
        //                 child: Text('An error has occurred!'),
        //               );
        //             } else if (snapshot.hasData) {
        //               return GridView.builder(
        //                 scrollDirection: Axis.horizontal,
        //                 itemCount: snapshot.data!.docs.length,
        //                 gridDelegate:
        //                     const SliverGridDelegateWithFixedCrossAxisCount(
        //                   crossAxisCount: 3,
        //                   crossAxisSpacing: 5.0,
        //                   mainAxisSpacing: 5.0,
        //                 ),
        //                 itemBuilder: (context, index) {
        //                   return GestureDetector(
        //                     onTap: () {
        //                       Navigator.pushNamed(context, '/asset',
        //                           arguments: <String, dynamic>{
        //                             'currentOwner': snapshot.data!.docs[index]
        //                                 ['currentOwner'],
        //                             'creator': snapshot.data!.docs[index]
        //                                 ['creator'],
        //                             'name': snapshot.data!.docs[index]['name'],
        //                             'description': snapshot.data!.docs[index]
        //                                 ['description'],
        //                             'coverImage': snapshot.data!.docs[index]
        //                                 ['coverImage'],
        //                             'views': snapshot.data!.docs[index]
        //                                 ['views'],
        //                             'externalLink': snapshot.data!.docs[index]
        //                                 ['externalLink'],
        //                             'contractAddress': snapshot
        //                                 .data!.docs[index]['contractAddress'],
        //                             'tokenId': snapshot.data!.docs[index]
        //                                 ['tokenId'],
        //                           });
        //                     },
        //                     // needs loading indicator when image being reloaded
        //                     child: Image.network(
        //                         snapshot.data!.docs[index]['coverImage']),
        //                   );
        //                 },
        //               );
        //             } else {
        //               return const Center(
        //                 child: CircularProgressIndicator(),
        //               );
        //             }
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: const BotNavBar(
          currentIndex: Profile.index,
        ),
      );
    }
  }
}
