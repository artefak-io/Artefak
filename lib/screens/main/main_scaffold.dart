import 'package:artefak/logic/auth/auth.dart';
import 'package:artefak/routes/router.gr.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      bottomNavigationBuilder: (_, tabsRouter) {
        return BotNavBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
