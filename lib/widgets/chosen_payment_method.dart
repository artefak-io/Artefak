import 'dart:async';

import 'package:artefak/screens/main/collection_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChosenPaymentMethod extends StatefulWidget {
  const ChosenPaymentMethod({
    Key? key,
    required this.onPressedPaymentMethod,
    required this.indexBank,
  }) : super(key: key);

  final int indexBank;
  final Function onPressedPaymentMethod;

  @override
  State<ChosenPaymentMethod> createState() => _ChosenPaymentMethodState();
}

class _ChosenPaymentMethodState extends State<ChosenPaymentMethod>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

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
          widget.indexBank == -1
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
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
                          onPressed: () =>
                              widget.onPressedPaymentMethod(context),
                        ),
                      ],
                    ),
                    Text(
                      'Sebelum lanjut, pilih metode pembayaran ya',
                      style: _textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: _themeData.errorColor),
                      textAlign: TextAlign.start,
                    ),
                  ],
                )
              : SizedBox(),
          widget.indexBank == -1
              ? SizedBox()
              : Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 40,
                          margin: EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                            color: _themeData.shadowColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Image.asset(
                              listAllMethod[widget.indexBank].bankPathAsset),
                        ),
                        Text(listAllMethod[widget.indexBank].title,
                            style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start)
                      ],
                    ),
                    SizedBox(height: 12.0,),
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
                          onPressed: () =>
                              widget.onPressedPaymentMethod(context),
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
                          style: _textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: _themeData.focusColor,
                          ),
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
