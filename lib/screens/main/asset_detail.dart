import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/widgets/account_description_row.dart';
import 'package:artefak/widgets/appbar_actions_button.dart';
import 'package:artefak/widgets/asset_preview.dart';
import 'package:artefak/widgets/bottom_action_bar.dart';
import 'package:artefak/widgets/card_item_custom.dart';
import 'package:artefak/widgets/qr_ticket_sliding_panel.dart';
import 'package:artefak/widgets/sub_head_title.dart';
import 'package:artefak/widgets/title_mint_token_info.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SalePackages {
  final int code;
  final double price;

  SalePackages(this.code, this.price);
}

class AssetDetail extends StatelessWidget {
  AssetDetail({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _assetStream =
      FirebaseFirestore.instance.collection('Asset').snapshots();

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.5,
            maxChildSize: 0.6,
            builder:
                (BuildContext context, ScrollController scrollController) =>
                    QrTicketSlidingPanel(
              scrollController: scrollController,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Map<String, dynamic> _dataAssetDetail =
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
                data: _dataAssetDetail,
              ),
              TitleMintTokenInfo(
                mintTokenCollection: MintTokenCollection(true, 0, 0, 888),
                data: _dataAssetDetail,
              ),
              AccountDescriptionRow(
                data: _dataAssetDetail,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: SubHeadTitle(
                      title: "Menarik Lainnya",
                      isSeeAll: true,
                    ),
                  ),
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
                ],
              ),
              SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomActionBar(
          subTitleAbove: "No. Akses",
          titleBottom: "#888",
          textButton: "Akses Tiket",
          onClickButton: () => _showDialog(context),
        ),
      ),
    );
  }
}
