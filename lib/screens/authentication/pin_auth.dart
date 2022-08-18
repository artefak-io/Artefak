import 'dart:ui';

import 'package:artefak/logic/pin/pin.dart';
import 'package:artefak/widgets/login_pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinAuth extends StatelessWidget {
  const PinAuth({Key? key}) : super(key: key);

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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
