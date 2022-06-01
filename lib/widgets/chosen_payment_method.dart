import 'package:artefak/screens/main/collection_review.dart';
import 'package:artefak/widgets/select_card_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChosenPaymentMethod extends StatelessWidget {
  const ChosenPaymentMethod({
    Key? key,
    required TextTheme textTheme,
    required ThemeData themeData,
    required this.onPressedPaymentMethod,
    required this.indexBank,
  })  : _textTheme = textTheme,
        _themeData = themeData,
        super(key: key);

  final TextTheme _textTheme;
  final ThemeData _themeData;
  final int indexBank;
  final Function onPressedPaymentMethod;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
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
          indexBank == -1
              ? Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 40,
                    margin: EdgeInsets.only(right: 8.0),
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
                  ),
                ],
              ),
              Text('Sebelum lanjut, pilih metode pembayaran ya',
                      style: _textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400, color: _themeData.errorColor),
                      textAlign: TextAlign.start),
            ],
          ) : SizedBox(),
          indexBank == -1
              ? SizedBox() :
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 40,
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: _themeData.shadowColor,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Image.asset(listAllMethod[indexBank].bankPathAsset),
                  ),
                  Text(listAllMethod[indexBank].title,
                      style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,),
                      textAlign: TextAlign.start)
                ],
              ),
              Row(
                children: [
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
                      "Ganti Metode Lainnya",
                      style: _textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    onPressed: () => onPressedPaymentMethod(context),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Biaya Lainnya",
                    style: _textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w400, color: _themeData.focusColor,),
                  ),
                  Divider(
                    height: 16.0,
                    color: _themeData.cursorColor,
                  ),
                  Row(
                    children: [
                      Text(
                        "Biaya Admin Bank",
                        style: _textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      Text(
                        "Rp 5.500",
                        style: _textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Divider(
                    height: 16.0,
                    color: _themeData.cursorColor,
                  ),
                  Row(
                    children: [
                      Text(
                        "Biaya Gas Fee",
                        style: _textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      Text(
                        "Rp 2.000",
                        style: _textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.0,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
