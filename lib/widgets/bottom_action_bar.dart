import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    Key? key,
    required ThemeData themeData,
    required TextTheme textTheme,
    required this.size,
    required this.subTitleAbove,
    required this.textButton,
    required this.priceDisplay,
    required this.onClickButton,
  })  : _themeData = themeData,
        _textTheme = textTheme,
        super(key: key);

  final ThemeData _themeData;
  final TextTheme _textTheme;
  final Size size;
  final String subTitleAbove, textButton;
  final double priceDisplay;
  final Function onClickButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: _themeData.highlightColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subTitleAbove,
                  style: _textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Rp${NumberFormat.decimalPattern('id').format(priceDisplay)}',
                  style: _textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            ElevatedButton(
              child: Text(
                textButton,
                style: _textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width * 0.4, 48.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  alignment: Alignment.center),
              onPressed: () => onClickButton(),
            ),
          ],
        ),
      ),
    );
  }
}
