import 'package:flutter/material.dart';

class SelectCardPayment extends StatefulWidget {
  const SelectCardPayment(
      {Key? key,
      required this.paymentChoice,
      required this.onSelectValue,
      required this.isSelected})
      : super(key: key);
  final PaymentChoice paymentChoice;
  final ValueChanged<bool> onSelectValue;
  final bool isSelected;

  @override
  State<SelectCardPayment> createState() => _SelectCardPaymentState();
}

class _SelectCardPaymentState extends State<SelectCardPayment> {
  bool onSelectValue = false;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          onSelectValue = !onSelectValue;
          widget.onSelectValue(onSelectValue);
        });
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: widget.isSelected
                  ? _themeData.textSelectionColor
                  : _themeData.focusColor,
              width: widget.isSelected ? 2 : 1,
            ),
          ),
          color: widget.isSelected
              ? _themeData.shadowColor
              : _themeData.highlightColor,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Image.asset(widget.paymentChoice.bankPathAsset,
                          width: 70.0)),
                  Text(widget.paymentChoice.title, style: _textTheme.bodySmall),
                ]),
          )),
    );
  }
}

class PaymentChoice {
  const PaymentChoice({required this.title, required this.bankPathAsset});

  final String title;
  final String bankPathAsset;
}

const List<PaymentChoice> choices = const <PaymentChoice>[
  const PaymentChoice(title: 'VA BCA', bankPathAsset: "assets/bank_bca.png"),
  const PaymentChoice(title: 'VA Mandiri', bankPathAsset: "assets/bank_mandiri.png"),
  const PaymentChoice(title: 'VA BRI', bankPathAsset: "assets/bank_bri.png"),
  const PaymentChoice(title: 'VA BCA', bankPathAsset: "assets/bank_bca.png"),
  const PaymentChoice(title: 'VA Mandiri', bankPathAsset: "assets/bank_mandiri.png"),
  const PaymentChoice(title: 'VA BRI', bankPathAsset: "assets/bank_bri.png"),
];
