import 'package:artefak/widgets/description_state_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AccountDescriptionRow extends StatelessWidget {
  AccountDescriptionRow({
    Key? key,
    required Map<String, dynamic> data,
  })  : _data = data,
        super(key: key);

  final Map<String, dynamic> _data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0, bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: _themeData.shadowColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            height: 56,
            alignment: Alignment.centerLeft,
            child: FutureBuilder<DocumentSnapshot>(
              future:
                  FirebaseFirestore.instance.doc(_data['creator'].path).get(),
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
                        style: _textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      ElevatedButton(
                        child: Text(
                          "Ikuti",
                          style: _textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(56.0, 32.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            alignment: Alignment.center),
                        onPressed: () {},
                      ),
                    ],
                  );
                }
                return Text("loading");
              },
            ),
          ),
          DescriptionStateClass(data: _data),
        ],
      ),
    );
  }
}
