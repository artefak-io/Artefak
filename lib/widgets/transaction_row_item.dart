import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Status {
  static const pending = 'Menunggu Pembayaran';
  static const completed = 'Selesai';
  static const missed = 'Terlewatkan';
}

class TransactionRowItem extends StatelessWidget {
  const TransactionRowItem({
    Key? key,
    required this.transactionItem,
  }) : super(key: key);

  final QueryDocumentSnapshot? transactionItem;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;
    String collectionId = '', status = '';
    double? amountPrice = null;
    Color? statusColor = null;

    collectionId = transactionItem!['collectionId']!;
    amountPrice = transactionItem!['amount']!;
    switch (transactionItem!['status']!) {
      case 'pending':
        status = Status.pending;
        statusColor = _themeData.errorColor;
        break;
      case 'completed':
        status = Status.completed;
        statusColor = _themeData.toggleableActiveColor;
        break;
      case 'missed':
        status = Status.missed;
        statusColor = _themeData.secondaryHeaderColor;
        break;
      default:
        status = '';
    }
    if (collectionId != '' && amountPrice != null && status != '') {
      return Container(
        margin: EdgeInsets.only(bottom: 16.0),
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
                    margin: EdgeInsets.only(left: 5.0, right: 16.0),
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
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        status,
                        style:
                            _textTheme.bodySmall?.copyWith(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("Collection")
                  .doc(collectionId)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> collectionRowItem =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    color: _themeData.primaryColorDark,
                    height: 80,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          child: Image.network(
                            collectionRowItem['coverImage'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(collectionRowItem['name'],
                                  style: _textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.start),
                              SizedBox(
                                height: 4.0,
                              ),
                              FutureBuilder<DocumentSnapshot>(
                                future: collectionRowItem['creator'].get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> creatorRef =
                                        snapshot.data!.data()
                                            as Map<String, dynamic>;
                                    return Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 8.0),
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  creatorRef['profilePicture'],
                                              fit: BoxFit.cover,
                                              width: 24.75,
                                              height: 24.75,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 7.25,
                                        ),
                                        Text(
                                          creatorRef['displayName'],
                                          style: _textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    );
                                  }
                                  return Text("loading");
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Text("loading");
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              alignment: Alignment.center,
              height: 58,
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
                        child: Text('Harga Premium',
                            style: _textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: _themeData.focusColor),
                            textAlign: TextAlign.start),
                      ),
                      Text(
                        "Rp${NumberFormat.decimalPattern('id').format(amountPrice)}",
                        style: _textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(
                          'Bayar',
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
                        onPressed: () => {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
