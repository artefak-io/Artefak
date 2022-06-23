import 'package:flutter/material.dart';

class RadioButtonFilterItem extends StatefulWidget {
  final CustomRadioModel item;

  RadioButtonFilterItem(this.item);

  @override
  State<RadioButtonFilterItem> createState() => _RadioButtonFilterItemState();
}

class _RadioButtonFilterItemState extends State<RadioButtonFilterItem> {

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      margin: EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: (widget.item.isSelected)
            ? _themeData.hintColor
            : Colors.transparent,
        border: Border.all(
          color: (widget.item.isSelected)
              ? Colors.transparent
              : _themeData.focusColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Text(
        widget.item.buttonText,
        style: _textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          color: (widget.item.isSelected)
              ? _themeData.primaryColorDark
              : _themeData.textSelectionColor,
        ),
      ),
    );
  }
}

class CustomRadioModel {
  bool isSelected;
  final String buttonText;
  final int index;

  CustomRadioModel(this.isSelected, this.buttonText, this.index);
}
