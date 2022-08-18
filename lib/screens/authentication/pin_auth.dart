import 'dart:ui';

import 'package:artefak/logic/pin/pin.dart';
import 'package:artefak/widgets/login_pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinAuth extends StatefulWidget {
  const PinAuth({Key? key}) : super(key: key);

  @override
  State<PinAuth> createState() => _PinAuthState();
}

class _PinAuthState extends State<PinAuth> with TickerProviderStateMixin {
  final TextEditingController textController = TextEditingController();

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  void loginPinOnComplete(String value, BuildContext context) {
    context.read<PinAuthCubit>().pinFilled(value);
  }

  void loginPinOnSubmitted(BuildContext context) {
    context.read<PinAuthCubit>().pinVerified();
  }

  void loginPinOnChanged(String value, BuildContext context) {
    context.read<PinAuthCubit>().pinFilled(value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });

    return BlocProvider(
      create: (context) =>
          PinAuthCubit(context.read<PinService>())..pinRetrieved(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<PinAuthCubit, PinAuthState>(
              listenWhen: (previous, current) =>
                  current.pinAuthStatus == PinAuthStatus.success,
              listener: (context, state) {
                context.read<PinStatusCubit>().pinAuthenticated();
              }),
          BlocListener<PinAuthCubit, PinAuthState>(
              listenWhen: (previous, current) =>
                  current.pinAuthStatus == PinAuthStatus.error,
              listener: (context, state) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      content: Text(state.errorMessage ?? "Error happens")));
              }),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Theme.of(context).primaryColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(64.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: AppBar(
                          toolbarHeight: 64.0,
                          automaticallyImplyLeading: false,
                          title: Text(
                            'PIN',
                            style: _textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Stack(
                children: <Widget>[
                  Positioned(
                    left: 20,
                    top: -165,
                    child: Image.asset(
                      'assets/bggrad.png',
                      fit: BoxFit.fitHeight,
                      height: 350,
                    ),
                  ),
                  LoginPinWidget(
                    bodytitle: 'Masuk Artefak',
                    bodySubTitle: 'Masukkan 6 digit PIN untuk masuk ke akunmu',
                    appBarTitle: 'PIN',
                    onCompleteFunction: loginPinOnComplete,
                    onSubmittedFunction: loginPinOnSubmitted,
                    onChangedFunction: loginPinOnChanged,
                    blocBuildNotify: BlocBuilder<PinAuthCubit, PinAuthState>(
                      builder: (context, state) {
                        bool isPinFailure =
                            state.pinAuthStatus == PinAuthStatus.failure;
                        return Text(
                          isPinFailure ? 'Incorrect PIN' : '',
                          style: _textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: _themeData.errorColor,
                          ),
                        );
                      },
                    ),
                    blocBuildButton: BlocBuilder<PinAuthCubit, PinAuthState>(
                      builder: (context, state) {
                        bool isPinFilled =
                            state.pinAuthStatus == PinAuthStatus.filled;
                        return ElevatedButton(
                          child: Text(
                            'Masuk',
                            style: _textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: isPinFilled
                                    ? _themeData.textSelectionColor
                                    : _themeData.textSelectionColor
                                        .withOpacity(0.5)),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(size.width * 0.9, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                          onPressed: () => isPinFilled
                              ? context.read<PinAuthCubit>().pinVerified()
                              : null,
                        );
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedBuilder(
                          animation: offsetAnimation,
                          builder: (buildContext, child) {
                            if (offsetAnimation.value < 0.0)
                              print('${offsetAnimation.value + 8.0}');
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 24.0),
                              padding: EdgeInsets.only(
                                  left: offsetAnimation.value + 24.0,
                                  right: 24.0 - offsetAnimation.value),
                              child: Center(
                                  child: TextField(
                                controller: textController,
                              )),
                            );
                          }),
                      RaisedButton(
                        onPressed: () {
                          if (textController.value.text.isEmpty)
                            controller.forward(from: 0.0);
                        },
                        child: Text('Enter'),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
