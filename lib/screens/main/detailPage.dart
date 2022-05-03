import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/services/transfer_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/card_item_custom.dart';
import '../../widgets/sale_price_widget.dart';
import '../../widgets/sub_head_title.dart';

class salePackages {
  final int code;
  final double price;

  salePackages(this.code, this.price);
}

List<salePackages> sales = [
  salePackages(0, 250000),
  salePackages(1, 350000),
  salePackages(2, 549000),
];

class ProductDetail extends StatelessWidget {
  ProductDetail({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _assetStream =
      FirebaseFirestore.instance.collection('Asset').snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    final Map<String, dynamic> _data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return AppLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Proyek'),
          actions: [
            IconButton(
                icon: Icon(Icons.notifications_none, size: 25.0),
                onPressed: () {}),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: size.width,
                          alignment: Alignment.center,
                          child: Image.network(
                            _data['coverImage'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _themeData.highlightColor,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _themeData.highlightColor,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          height: 40,
                          child: Text("12 Jam 30 Detik",
                              style: _textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        _data['name'],
                        style: _textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400, letterSpacing: 0.0),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      child: Text(
                        "Mint 7 April 2022",
                        style: _textTheme.bodySmall?.copyWith(
                            color: _themeData.focusColor,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.0),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "•",
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.green,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "231/300 Token",
                            style: _textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 231 / 300,
                          backgroundColor: Colors.grey,
                          minHeight: 8,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      child: listSaleWidget(
                          assetList: sales,
                          themeData: _themeData,
                          textTheme: _textTheme),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 32, bottom: 8),
                      decoration: BoxDecoration(
                        color: _themeData.shadowColor,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      height: 56,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.asset('assets/propict.png'),
                          ),
                          Text("Sarah & Friends"),
                          Spacer(),
                          OutlinedButton(
                            child: Text("Ikuti"),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: _themeData.shadowColor,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                                top: 16.0,
                                bottom: 8.0),
                            child: Text(
                              "Detail Proyek",
                              style: _textTheme.titleMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              right: 12.0,
                            ),
                            child: Text(
                              "Tiramisu pie danish jelly happy jolie. Mclaukin clackuin queen mister clean.",
                              style: _textTheme.bodyMedium
                                  ?.copyWith(color: _themeData.focusColor),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                                top: 8.0,
                                bottom: 24.0),
                            alignment: Alignment.topRight,
                            child: Text(
                              "Baca Selengkapnya",
                              style: _textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: _themeData.hintColor,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SubHeadTitle(
                      title: "Menarik Lainnya",
                      isSeeAll: true,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    height: 200,
                    child: ItemTwoAxisScroll(
                      assetStream: _assetStream,
                      isHorizontal: true,
                      heightPhoto: 120,
                      widthPhoto: size.width * 0.80,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (AuthService.user == null) {
                        Navigator.pushNamed(context, '/auth');
                      }
                      // else if (check if this user still has active unpaid account or not)

                      else {
                        Navigator.pushNamed(context, '/payment',
                            arguments: <String, dynamic>{
                              'id': _data['id'],
                              'price': _data['price'],
                              'assetName': _data['name'],
                            });
                      }
                    },
                    child: const Text('Buy'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Text(
                      'This "Yoink Button" is extremely fragile. Please use it wisely',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (AuthService.user == null) {
                        Navigator.pushNamed(context, '/auth');
                      } else {
                        TransferService().transferNft(
                            _data['id'],
                            AuthService.user!.uid,
                            _data['name'],
                            _data['description'],
                            _data['coverImage'],
                            _data['contractAddress'],
                            _data['tokenId'],
                            _data['price']);
                      }
                    },
                    child: const Text('YOINK!!!'),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Container(
            padding: const EdgeInsets.all(16),
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
                      "Jumlah Token: 3",
                      style: _textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Rp 750.000",
                      style: _textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  child: Text(
                    'Beli Sekarang',
                    style: _textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(size.width * 0.4, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      alignment: Alignment.center),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
