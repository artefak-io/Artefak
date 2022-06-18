import 'package:flutter/material.dart';

class RadioButtonFilterItem extends StatelessWidget {
  final CustomRadioModel _item;

  RadioButtonFilterItem(this._item);

  void onPressedPaymentMethod() {}

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: _themeData.focusColor,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        _item.buttonText,
        style: _textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
      ),
      onPressed: () => onPressedPaymentMethod(),
    );
  }
}

class CustomRadioModel {
  bool isSelected;
  final String buttonText;

  CustomRadioModel(this.isSelected, this.buttonText);
}
