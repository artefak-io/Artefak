import 'dart:ui';

import 'package:artefak/logic/auth/auth.dart';
import 'package:flutter/material.dart';

import 'auth_sliding_panel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  final int currentIndex;

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: _themeData.highlightColor,
            selectedItemColor: _themeData.textSelectionColor,
            unselectedItemColor: _themeData.unselectedWidgetColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2),
                label: 'Koleksi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded),
                label: 'Suka',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Akun',
              ),
            ],
            currentIndex: currentIndex,
            onTap: (index) {
              if (context.read<AuthBloc>().state.authenticationStatus !=
                  AuthenticationStatus.authenticated) {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.55,
                      minChildSize: 0.5,
                      maxChildSize: 0.55,
                      builder: (BuildContext context,
                              ScrollController scrollController) =>
                          AuthSlidingPanel(
                        scrollController: scrollController,
                      ),
                    );
                  },
                );
              } else {
                onTap(index);
              }
            },
          ),
        ),
      ),
    );
  }
}
