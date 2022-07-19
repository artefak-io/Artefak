import 'package:artefak/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeRouter(),
        CollectionRouter(),
        const FavoriteRouter(),
        TransactionRouter(),
        UserRouter(),
      ],
    );
  }
}
