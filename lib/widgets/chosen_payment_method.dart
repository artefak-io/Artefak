import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChosenPaymentMethod extends StatelessWidget {
  const ChosenPaymentMethod({
    Key? key,
    required TextTheme textTheme,
    required ThemeData themeData,
    required this.onPressedPaymentMethod,
  }) : _textTheme = textTheme, _themeData = themeData, super(key: key);

  final TextTheme _textTheme;
  final ThemeData _themeData;
  final Function onPressedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Metode Pembayaran',
              style: _textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Container(
                width: 56,
                height: 40,
                margin:
                EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  color: _themeData.shadowColor,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: SvgPicture.asset(
                  'assets/exclamation_triangle.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    color: _themeData.focusColor,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
                child: Text(
                  "Pilih Metode Pembayaranmu",
                  style: _textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
                onPressed: () => onPressedPaymentMethod(context),
              )
            ],
          ),
          Text('Sebelum lanjut, pilih metode pembayaran ya',
              style: _textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400, color: Color(0xFFEA7D7D)),
              textAlign: TextAlign.start),
        ],
      ),
    );
  }
}