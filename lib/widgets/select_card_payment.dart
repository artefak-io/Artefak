import 'package:flutter/material.dart';

class SelectCardPayment extends StatelessWidget {
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    return GestureDetector(
      onTap: () => onSelectValue(true),
      child: Container(
        width: 98.0,
        height: 86.0,
        child: Container(
          decoration: BoxDecoration(
            color:
                isSelected ? _themeData.shadowColor : _themeData.highlightColor,
            border: Border.all(
              color: isSelected
                  ? _themeData.textSelectionColor
                  : _themeData.focusColor,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                paymentChoice.bankPathAsset,
                width: 70.0,
                height: 50,
              ),
              Text(paymentChoice.title, style: _textTheme.bodySmall),
              SizedBox(height: 8.0,),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentChoice {
  PaymentChoice(this.index, {required this.title, required this.bankPathAsset});

  final int index;
  final String title;
  final String bankPathAsset;
  bool isSelected = false;
}

List<PaymentChoice> choices = [
  PaymentChoice(0, title: 'VA BCA', bankPathAsset: "assets/bank_bca.png"),
  PaymentChoice(1, title: 'VA Mandiri', bankPathAsset: "assets/bank_mandiri.png"),
  PaymentChoice(2, title: 'VA BRI', bankPathAsset: "assets/bank_bri.png"),
  PaymentChoice(3, title: 'VA BCA', bankPathAsset: "assets/bank_bca.png"),
  PaymentChoice(4, title: 'VA Mandiri', bankPathAsset: "assets/bank_mandiri.png"),
  PaymentChoice(5, title: 'VA BRI', bankPathAsset: "assets/bank_bri.png"),
];
