import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/services/transfer_service.dart';
import 'package:artefak/widgets/account_description_row.dart';
import 'package:artefak/widgets/asset_preview.dart';
import 'package:artefak/widgets/bottom_action_bar.dart';
import 'package:artefak/widgets/card_item_custom.dart';
import 'package:artefak/widgets/sale_price_widget.dart';
import 'package:artefak/widgets/title_mint_token_info.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SalePackages {
  final int code;
  final double price;

  SalePackages(this.code, this.price);
}

List<SalePackages> sales = [
  SalePackages(0, 250000),
  SalePackages(1, 350000),
  SalePackages(2, 549000),
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
              AssetPreview(
                size: size,
                data: _data,
              ),
              TitleMintTokenInfo(
                data: _data,
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
                      ),
                    ),
                  ],
                ),
              ),
              AccountDescriptionRow(),
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
        bottomNavigationBar: BottomActionBar(
          size: size,
          subTitleAbove: "Jumlah Token: 3",
          priceDisplay: 750000,
          textButton: "Beli Sekarang",
          onClickButton: () => Navigator.pushNamed(
              context, '/asset/product_detail/collection_review',
              arguments: <String, dynamic>{
                'codeSale': 0,
              }),
        ),
      ),
    );
  }
}
