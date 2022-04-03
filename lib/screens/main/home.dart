import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _assetStream =
      FirebaseFirestore.instance.collection('Asset').snapshots();

  static const index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _assetStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            'creator': snapshot.data!.docs[index]['creator'],
                            'name': snapshot.data!.docs[index]['name'],
                            'description': snapshot.data!.docs[index]
                                ['description'],
                            'coverImage': snapshot.data!.docs[index]
                                ['coverImage'],
                            'views': snapshot.data!.docs[index]['views'],
                            'externalLink': snapshot.data!.docs[index]
                                ['externalLink'],
                            'contractAddress': snapshot.data!.docs[index]
                                ['contractAddress'],
                            'tokenId': snapshot.data!.docs[index]['tokenId'],
                            'price': snapshot.data!.docs[index]['price'],
                          });
                    },
                    // needs loading indicator when image being reloaded
                    child:
                        Image.network(snapshot.data!.docs[index]['coverImage']),
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
      bottomNavigationBar: const BotNavBar(
        currentIndex: index,
      ),
    );
  }
}
