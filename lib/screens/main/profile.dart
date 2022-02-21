import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/asset_service.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:artefak/services/auth.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  static const index = 2;

  late final Stream<QuerySnapshot> _assetStream;

  @override
  Widget build(BuildContext context) {
    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      _assetStream = AssetService().personalAssets(AuthService.user!.uid);

      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/finn.jpg'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Name'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Text(AuthService.user!.displayName ?? ''),
                      ),
                      const Text('Email'),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(AuthService.user!.email!),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/updateProfile',
                ),
                child: const Text('Update Profile'),
              ),
              ElevatedButton(
                child: const Text('Log out'),
                onPressed: () async {
                  AuthService().signOut();
                },
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
      );
    }
  }
}
