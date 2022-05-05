import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:artefak/screens/main/detail_page.dart';
import 'package:artefak/widgets/input_number_step.dart';

class listSaleWidget extends StatelessWidget {
  const listSaleWidget({
    Key? key,
    required ThemeData themeData,
    required TextTheme textTheme,
    required this.assetList,
  })  : _themeData = themeData,
        _textTheme = textTheme,
        super(key: key);

  final ThemeData _themeData;
  final TextTheme _textTheme;
  final List<SalePackages> assetList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: assetList.length,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return salePriceWidget(
              codeSale: assetList[index].code,
              price: assetList[index].price,
              themeData: _themeData,
              textTheme: _textTheme);
        });
  }
}

class salePriceWidget extends StatelessWidget {
  const salePriceWidget({
    Key? key,
    required ThemeData themeData,
    required TextTheme textTheme,
    required this.codeSale,
    required this.price,
  })  : _themeData = themeData,
        _textTheme = textTheme,
        super(key: key);

  final ThemeData _themeData;
  final TextTheme _textTheme;
  final int codeSale;
  final double price;

  @override
  Widget build(BuildContext context) {
    int yourLocalVariable = 0;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: 120,
      decoration: BoxDecoration(
        color: _themeData.shadowColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Center(
              child: RankSales(
            textTheme: _textTheme,
            saleCode: codeSale,
          )),
          SizedBox(
            height: 8,
          ),
          Center(
            child: Container(
              child: Text(
                "Rp ${NumberFormat.decimalPattern('id').format(price)}",
                style: _textTheme.bodyLarge,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Center(
            child: Container(
              child: Text(
                "Detail",
                style: _textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _themeData.hintColor,
                ),
              ),
            ),
          ),
          Divider(
            color: Color(0xFF383838),
          ),
          Center(
            child: Container(
              child: Text(
                "185/200",
                style: _textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: _themeData.focusColor,
                ),
              ),
            ),
          ),
          Container(
            child: InputNumberStep(
              maxValue: 20,
              onChanged: (value) {
                yourLocalVariable = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RankSales extends StatelessWidget {
  const RankSales({
    Key? key,
    required TextTheme textTheme,
    required this.saleCode,
  })  : _textTheme = textTheme,
        super(key: key);

  final TextTheme _textTheme;
  final int saleCode;

  @override
  Widget build(BuildContext context) {
    return saleCode == 0
        ? Container(
            decoration: BoxDecoration(
              color: Color(0xFFF0C015),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "Pre Sale",
                style: _textTheme.bodySmall?.copyWith(color: Colors.black),
              ),
            ),
          )
        : saleCode == 1
            ? Container(
                decoration: BoxDecoration(
                  color: Color(0xFF16A34A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "Regular",
                    style: _textTheme.bodySmall,
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Color(0xFFDC2626),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "Premium",
                    style: _textTheme.bodySmall,
                  ),
                ),
              );
  }
}
