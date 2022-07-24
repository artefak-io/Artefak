import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/account_description_row.dart';
import 'package:artefak/widgets/appbar_actions_button.dart';
import 'package:artefak/widgets/asset_preview.dart';
import 'package:artefak/widgets/bottom_action_bar.dart';
import 'package:artefak/widgets/card_item_custom.dart';
import 'package:artefak/widgets/title_mint_token_info.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    final Map<String, dynamic> _data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return AppLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Proyek'),
          actions: [
            AppbarActionsButton(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AssetPreview(
                data: _data,
              ),
              TitleMintTokenInfo(
                mintTokenCollection: MintTokenCollection(false, 231, 300, 0),
                data: _data,
              ),
              AccountDescriptionRow(
                data: _data,
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
                  SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomActionBar(
          subTitleAbove: "Jumlah Token: 3",
          titleBottom: "Rp${NumberFormat.decimalPattern('id').format(750000)}",
          textButton: "Beli Sekarang",
          onClickButton: () => Navigator.pushNamed(
              context, '/collection_review',
              arguments: <String, dynamic>{
                'codeSale': 0,
              }),
        ),
      ),
    );
  }
}
