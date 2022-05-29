import 'package:artefak/screens/main/collection_review.dart';
import 'package:artefak/widgets/chosen_payment_method.dart';
import 'package:artefak/widgets/sale_price_widget.dart';
import 'package:artefak/widgets/select_card_payment.dart';
import 'package:flutter/material.dart';

class TotalCollectionReview extends StatelessWidget {
  const TotalCollectionReview({
    Key? key,
    required this.size,
    required TextTheme textTheme,
    required Map<String, dynamic> data,
    required ThemeData themeData,
    required this.onPressedPaymentMethod,
    required this.listAllMethod,
  })  : _textTheme = textTheme,
        _data = data,
        _themeData = themeData,
        super(key: key);

  final Size size;
  final TextTheme _textTheme;
  final Map<String, dynamic> _data;
  final ThemeData _themeData;
  final List<ListSelectedPayment<PaymentChoice>> listAllMethod;
  final Function onPressedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  RankSales(
                    textTheme: _textTheme,
                    saleCode: _data['codeSale'],
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text('3 Token',
                      style: _textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start),
                  Spacer(),
                  Text('Rp250.000',
                      style: _textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Nomor Token akan sesuai ketentuan pemilik proyek',
                    style: _textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: _themeData.focusColor),
                    textAlign: TextAlign.start),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
          color: Color(0xFF4B5563),
        ),
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
          color: Color(0xFF4B5563),
        ),
        SizedBox(
          height: 32.0,
        ),
        ChosenPaymentMethod(
            textTheme: _textTheme,
            themeData: _themeData,
            onPressedPaymentMethod: onPressedPaymentMethod),
      ],
    );
  }
}