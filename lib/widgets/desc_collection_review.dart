import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DescCollectionReview extends StatelessWidget {
  const DescCollectionReview({
    Key? key,
    required Stream<DocumentSnapshot<Object?>> collectionStream,
  })  : _collectionStream = collectionStream,
        super(key: key);

  final Stream<DocumentSnapshot<Object?>> _collectionStream;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return StreamBuilder<DocumentSnapshot>(
      stream: _collectionStream,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('An error has occurred!', style: _textTheme.bodyMedium),
          );
        } else if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Proyek',
                          style: _textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: _themeData.shadowColor,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      height: 80,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: _themeData.shadowColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: Image.network(
                                (snapshot.data!.data()! as Map)['coverImage'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text((snapshot.data!.data()! as Map)['name'],
                                    style: _textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.start),
                                SizedBox(
                                  height: 5.0,
                                ),
                                FutureBuilder<DocumentSnapshot>(
                                  future:
                                      (snapshot.data!.data()! as Map)['creator']
                                          .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;
                                      return Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 8.0),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    data['profilePicture'],
                                                fit: BoxFit.cover,
                                                width: 25.0,
                                                height: 25.0,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            data['displayName'],
                                            style: _textTheme.bodySmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                        ],
                                      );
                                    };
                                    return Container();
                                  },
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
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
