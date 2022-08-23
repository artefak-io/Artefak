import 'package:artefak/widgets/chosen_payment_method.dart';
import 'package:flutter/material.dart';

class TotalCollectionReview extends StatelessWidget {
  const TotalCollectionReview({
    Key? key,
    required Map<String, dynamic> data,
    required this.onPressedPaymentMethod,
    required this.indexBank,
  })  : _data = data,
        super(key: key);

  final int indexBank;
  final Map<String, dynamic> _data;
  final Function onPressedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
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
              Text('Rp750.000',
                  style: _textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start),
            ],
          ),
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
