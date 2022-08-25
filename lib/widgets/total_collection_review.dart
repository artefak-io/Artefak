import 'package:artefak/widgets/chosen_payment_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalCollectionReview extends StatelessWidget {
  const TotalCollectionReview({
    Key? key,
    required Map<String, dynamic> data,
    required this.onPressedPaymentMethod,
    required this.indexBank,
    required Stream<DocumentSnapshot<Object?>> collectionStream,
  })  : _data = data,
        _collectionStream = collectionStream,
        super(key: key);

  final int indexBank;
  final Map<String, dynamic> _data;
  final Function onPressedPaymentMethod;
  final Stream<DocumentSnapshot<Object?>> _collectionStream;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        StreamBuilder<DocumentSnapshot>(
          stream: _collectionStream,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('An error has occurred!',
                    style: _textTheme.bodyMedium),
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Row(
                  children: [
                    Text('Sub Total',
                        style: _textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start),
                    Spacer(),
                    Text(
                        "Rp${NumberFormat.decimalPattern('id').format((snapshot.data!.data()! as Map)['price'])}",
                        style: _textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Divider(
          height: 0,
          color: _themeData.cursorColor,
        ),
        SizedBox(
          height: 32.0,
        ),
        ChosenPaymentMethod(
          onPressedPaymentMethod: onPressedPaymentMethod,
          indexBank: indexBank,
        ),
      ],
    );
  }
}
