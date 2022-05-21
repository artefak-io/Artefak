import 'package:artefak/widgets/sale_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TotalCollectionReview extends StatelessWidget {
  const TotalCollectionReview({
    Key? key,
    required this.size,
    required TextTheme textTheme,
    required Map<String, dynamic> data,
    required ThemeData themeData,
    required this.onPressedPaymentMethod,
  })  : _textTheme = textTheme,
        _data = data,
        _themeData = themeData,
        super(key: key);

  final Size size;
  final TextTheme _textTheme;
  final Map<String, dynamic> _data;
  final ThemeData _themeData;
  final Function onPressedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.only(left: 16, right: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  RankSales(
                    textTheme: _textTheme,
                    saleCode: _data['codeSale'],
                  ),
                  SizedBox(
                    width: 8,
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
                height: 8,
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
                height: 8,
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
          color: Color(0xFF4B5563),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
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
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Metode Pembayaran',
                  style: _textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 40,
                    margin: const EdgeInsets.only(right: 8.0),
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
        ),
      ],
    );
  }
}
