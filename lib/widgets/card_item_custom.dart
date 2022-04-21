import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
      margin: widget.isHorizontal
          ? const EdgeInsets.only(left: 10.0)
          : const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: <Widget>[
          Container(
            height: widget.heightPhoto,
            width: widget.widthPhoto,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
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
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF404040), Color(0xFF363636)],
              ),
              borderRadius: BorderRadius.circular(20),
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
                          '${truncateWithEllipsis(10, widget.dataEach['name'])}',
                          style: _textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: Text(
                          '${NumberFormat.currency(locale: 'id').format(widget.dataEach['price'])}',
                          style: _textTheme.labelMedium,
                        ),
                      ),
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
