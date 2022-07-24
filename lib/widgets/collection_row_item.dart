import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CollectionRowItem extends StatelessWidget {
  const CollectionRowItem({
    Key? key,
    required this.onPressedShowTicket,
    required this.dataItem,
  }) : super(key: key);

  final Function onPressedShowTicket;
  final QueryDocumentSnapshot dataItem;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(
        bottom: 16.0,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
            alignment: Alignment.center,
            height: 66,
            decoration: BoxDecoration(
              color: _themeData.shadowColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  child: CircleAvatar(
                    child: Text('H', style: _textTheme.bodySmall),
                    radius: 32,
                    backgroundColor: Colors.white30,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Tiket',
                          style: _textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        child: Text(
                          '19 Juni 2022',
                          style: _textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: _themeData.toggleableActiveColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      "Koleksi Aktif",
                      style:
                          _textTheme.bodySmall?.copyWith(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 328,
            child: Image.network(
              dataItem['coverImage'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.center,
            height: 86,
            decoration: BoxDecoration(
              color: _themeData.shadowColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        dataItem['name'],
                        style: _textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .doc(dataItem['creator'].path)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8.0),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: data['profilePicture'],
                                    fit: BoxFit.cover,
                                    width: 35.0,
                                    height: 35.0,
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
                          );
                        }
                        return Text("loading");
                      },
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "#888",
                        style: _textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text(
                        'Akses',
                        style: _textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(67.0, 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          alignment: Alignment.center),
                      onPressed: () => onPressedShowTicket(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
