import 'package:artefak/logic/pin/pin.dart';
import 'package:artefak/widgets/input_pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPin extends StatelessWidget {
  const ConfirmPin({required this.pin, Key? key}) : super(key: key);

  final String pin;

  void confirmPinOnComplete(String value, BuildContext context) {
    context.read<ConfirmPinCubit>().pinValidatedOnCompleted(value, pin);
  }

  void confirmPinOnSubmitted(BuildContext context) {
    context.read<ConfirmPinCubit>().pinCreated();
  }

  void confirmPinOnChanged(String value, BuildContext context) {
    context.read<ConfirmPinCubit>().pinValidatedOnChange(value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return WillPopScope(
      onWillPop: (() async => false),
      child: BlocProvider(
        create: (context) => ConfirmPinCubit(context.read<PinService>()),
        child: BlocListener<ConfirmPinCubit, ConfirmPinState>(
          listenWhen: (previous, current) =>
              current.confirmPinStatus == ConfirmPinStatus.success,
          listener: (context, state) {
            context.read<PinStatusCubit>().pinAuthenticated();
            Navigator.pop(context);
          },
          child: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBar(
                  title: Text(
                    "Buat PIN",
                    style: _textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
                body: BlocListener<ConfirmPinCubit, ConfirmPinState>(
                  listenWhen: (previous, current) =>
                      current.confirmPinStatus == ConfirmPinStatus.error,
                  listener: (context, state) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content:
                              Text(state.errorMessage ?? 'Error happens')));
                  },
                  child: BlocListener<ConfirmPinCubit, ConfirmPinState>(
                    listenWhen: (previous, current) =>
                        current.confirmPinStatus == ConfirmPinStatus.loading,
                    listener: (context, state) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(const SnackBar(
                            content: Text("Please wait a minute")));
                    },
                    child: SingleChildScrollView(
                      child: Stack(
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
                            bodytitle: 'Kunci Akses Baru',
                            bodySubTitle:
                                'Ulangi sekali lagi, masukkan 6 digit PIN yang sama seperti sebelumnya.',
                            appBarTitle: 'Buat PIN',
                            onCompleteFunction: confirmPinOnComplete,
                            onSubmittedFunction: confirmPinOnSubmitted,
                            onChangedFunction: confirmPinOnChanged,
                            blocBuildNotify:
                                BlocBuilder<ConfirmPinCubit, ConfirmPinState>(
                              buildWhen: (previous, current) =>
                                  (current.confirmPinStatus ==
                                          ConfirmPinStatus.inputInvalid &&
                                      previous.pinInputValidationError !=
                                          current.pinInputValidationError) ||
                                  previous.confirmPinStatus ==
                                      ConfirmPinStatus.inputInvalid,
                              builder: (context, state) {
                                if (state.pinInputValidationError ==
                                    PinInputValidationError.nonNumberInput) {
                                  return Text(
                                    "Input must be a number",
                                    style: _textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: _themeData.errorColor,
                                    ),
                                  );
                                } else if (state.pinInputValidationError ==
                                    PinInputValidationError
                                        .insufficientLength) {
                                  return Text(
                                    "Input must be 6 digits",
                                    style: _textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: _themeData.errorColor,
                                    ),
                                  );
                                } else if (state.pinInputValidationError ==
                                    PinInputValidationError.inputDoesntMatch) {
                                  return Text(
                                    "Input pin doesn't match",
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
                            blocBuildButton:
                                BlocBuilder<ConfirmPinCubit, ConfirmPinState>(
                              buildWhen: (previous, current) =>
                                  current.confirmPinStatus ==
                                      ConfirmPinStatus.inputValid ||
                                  previous.confirmPinStatus ==
                                      ConfirmPinStatus.inputValid,
                              builder: (context, state) {
                                bool isPinValid = state.confirmPinStatus ==
                                    ConfirmPinStatus.inputValid;
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(size.width * 0.9, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  onPressed: () => isPinValid
                                      ? context
                                          .read<CreatePinCubit>()
                                          .pinSucceed()
                                      : null,
                                  child: Text(
                                    "Input PIN",
                                    style: _textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: isPinValid
                                          ? _themeData.textSelectionColor
                                          : _themeData.textSelectionColor
                                              .withOpacity(0.5),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
