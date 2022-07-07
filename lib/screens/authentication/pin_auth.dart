import 'package:artefak/logic/pin/pin.dart';
import 'package:artefak/widgets/input_pin_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          PinAuthCubit(context.read<PinService>())..pinRetrieved(),
      child: BlocListener<PinAuthCubit, PinAuthState>(
        listenWhen: (previous, current) =>
            current.pinAuthStatus == PinAuthStatus.success,
        listener: (context, state) {
          context.read<PinStatusCubit>().pinAuthenticated();
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                title: const Text("PIN"),
              ),
              body:
              // SingleChildScrollView(
              //   child:
              Stack(
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
                    InputPinWidget(
                      bodytitle: 'Masuk Artefak',
                      phoneNumber: '+62817739337238',
                      bodySubTitle:
                          'Masukkan 6 digit PIN untuk masuk ke akunmu',
                      appBarTitle: 'PIN',
                      onCompleteFunction: loginPinOnComplete,
                      onSubmittedFunction: loginPinOnSubmitted,
                      onChangedFunction: (value, context) {},
                      blocBuildNotify: BlocBuilder<PinAuthCubit, PinAuthState>(
                        buildWhen: (previous, current) =>
                            current.pinAuthStatus == PinAuthStatus.failure ||
                            previous.pinAuthStatus == PinAuthStatus.failure,
                        builder: (context, state) {
                          if (state.pinAuthStatus == PinAuthStatus.failure) {
                            return Text(
                              "Incorrect PIN",
                              style: _textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: _themeData.errorColor,
                              ),
                            );
                          } else {
                            return const Text("");
                          }
                        },
                      ),
                      blocBuildButton: BlocBuilder<PinAuthCubit, PinAuthState>(
                        buildWhen: (previous, current) =>
                            current.pinAuthStatus == PinAuthStatus.filled ||
                            previous.pinAuthStatus == PinAuthStatus.filled,
                        builder: (context, state) {
                          if (state.pinAuthStatus == PinAuthStatus.filled) {
                            return ElevatedButton(
                              child: Text(
                                'Masuk',
                                style: _textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(size.width * 0.9, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                              ),
                              onPressed: () =>
                                  context.read<PinAuthCubit>().pinVerified(),
                            );
                            // );
                          } else {
                            return ElevatedButton(
                              child: Text(
                                'Masuk',
                                style: _textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(size.width * 0.9, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                              ),
                              onPressed: null,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              // ),
            );
          },
        ),
      ),
    );
  }
}
