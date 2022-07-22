import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemTwoAxisScroll extends StatelessWidget {
  const ItemTwoAxisScroll({
    Key? key,
    required Stream<QuerySnapshot<Object?>> assetStream,
    required this.isHorizontal,
    required this.heightPhoto,
    required this.widthPhoto,
  })  : _assetStream = assetStream,
        super(key: key);

  final Stream<QuerySnapshot<Object?>> _assetStream;
  final bool isHorizontal;
  final double heightPhoto, widthPhoto;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return StreamBuilder<QuerySnapshot>(
      stream: _assetStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('An error has occurred!', style: _textTheme.bodyMedium),
          );
        } else if (snapshot.hasData) {
          return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
              physics: isHorizontal
                  ? ClampingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/asset/product_detail',
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
                          'contractAddress': snapshot.data!.docs[index]
                              ['contractAddress'],
                          'tokenId': snapshot.data!.docs[index]['tokenId'],
                          'price': snapshot.data!.docs[index]['price'],
                        });
                  },
                  // needs loading indicator when image being reloaded
                  child: ItemCardCustom(
                    isHorizontal: isHorizontal,
                    heightPhoto: heightPhoto,
                    widthPhoto: widthPhoto,
                    dataEach: snapshot.data!.docs[index],
                  ),
                );
              },
            ),
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

class ItemCardCustom extends StatefulWidget {
  final bool isHorizontal;
  final double heightPhoto, widthPhoto;
  final DateTime? timeToGo;
  final QueryDocumentSnapshot dataEach;

  const ItemCardCustom(
      {Key? key,
      required this.heightPhoto,
      required this.widthPhoto,
      this.timeToGo,
      required this.dataEach,
      required this.isHorizontal})
      : super(key: key);

  @override
  State<ItemCardCustom> createState() => _ItemCardCustomState();
}

class _ItemCardCustomState extends State<ItemCardCustom> {
  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  late dynamic profileData;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    print(widget.dataEach.toString());

    return Container(
      margin: widget.isHorizontal
          ? const EdgeInsets.only(right: 16.0)
          : const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            height: widget.heightPhoto,
            width: widget.widthPhoto,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      widget.dataEach['coverImage'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 80,
            width: widget.widthPhoto,
            decoration: BoxDecoration(
              color: _themeData.shadowColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: Text(
                          '${truncateWithEllipsis(20, widget.dataEach['name'])}',
                          style: _textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: Text(
                          'Rp${NumberFormat.decimalPattern('id').format(widget.dataEach['price'])}',
                          style: _textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
                FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .doc(widget.dataEach['creator'].path)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 8.0),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: data['profilePicture'],
                                      fit: BoxFit.cover,
                                      width: 25.0,
                                      height: 25.0,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Text(
                                  data['displayName'],
                                  style: _textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                child: Text(
                                  '231/300 Token',
                                  style: _textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: _themeData.indicatorColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Text("loading");
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
