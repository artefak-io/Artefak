import 'package:artefak/widgets/email_verif_sliding_panel.dart';
import 'package:artefak/widgets/signin_up_content_panel.dart';
import 'package:flutter/material.dart';

void showDialogAuth(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.5,
        maxChildSize: 0.55,
        builder: (BuildContext context, ScrollController scrollController) =>
            AuthSlidingPanel(
          scrollController: scrollController,
        ),
      );
    },
  );
}

class AuthSlidingPanel extends StatefulWidget {
  AuthSlidingPanel({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;


  @override
  State<AuthSlidingPanel> createState() => _AuthSlidingPanelState();
}

class _AuthSlidingPanelState extends State<AuthSlidingPanel> {
  final _emailController = TextEditingController();
  String _emailPhoneText = "";
  int currentView = 0;
  late List<Widget> pages;

  void onChangeCurrentView(int page) => setState(() {
    currentView = page;
  });

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    _emailController.addListener(() {
      setState(() {
        _emailPhoneText = _emailController.text;
      });
      print(_emailPhoneText);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      SignInUpSlidingPanel(onChangeCurrentView, context,
          _emailController, _emailPhoneText),
      EmailVerifSlidingPanel(onChangeCurrentView, context),
    ];
    return pages[currentView];
  }
}
