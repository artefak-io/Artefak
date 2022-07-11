import 'package:artefak/logic/pin/pin.dart';
import 'package:artefak/screens/authentication/confirm_pin.dart';
import 'package:artefak/widgets/input_pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CreatePin extends StatelessWidget {
  const CreatePin({Key? key}) : super(key: key);

  void createPinOnComplete(String value, BuildContext context) {
    context.read<CreatePinCubit>().pinValidatedOnCompleted(value);
  }

  void createPinOnSubmitted(BuildContext context) {
    context.read<CreatePinCubit>().pinSucceed();
  }

  void createPinOnChanged(String value, BuildContext context) {
    context.read<CreatePinCubit>().pinValidatedOnChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return WillPopScope(
      onWillPop: (() async => false),
      child: BlocProvider(
        create: (context) => CreatePinCubit(),
        child: BlocListener<CreatePinCubit, CreatePinState>(
          listenWhen: (previous, current) =>
              current.createPinStatus == CreatePinStatus.success,
          listener: (context, state) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmPin(pin: state.pinInput.value),
                )).then(
              (value) => context.read<CreatePinCubit>().pinCreateValid(),
            );
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
                body: SingleChildScrollView(
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
                            'Yey! Satu langkah lagi. Masukkan 6 digit PIN yang dibuat untuk memudahkan akses dan keamanan yang lebih mantul! ',
                        appBarTitle: 'Buat PIN',
                        onCompleteFunction: createPinOnComplete,
                        onSubmittedFunction: createPinOnSubmitted,
                        onChangedFunction: createPinOnChanged,
                        blocBuildNotify:
                            BlocBuilder<CreatePinCubit, CreatePinState>(
                          buildWhen: (previous, current) =>
                              (current.createPinStatus ==
                                      CreatePinStatus.inputInvalid &&
                                  previous.invalid != current.invalid) ||
                              previous.createPinStatus ==
                                  CreatePinStatus.inputInvalid,
                          builder: (context, state) {
                            if (state.invalid ==
                                PinInputValidationError.nonNumberInput) {
                              return Text(
                                "Input must be a number",
                                style: _textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: _themeData.errorColor,
                                ),
                              );
                            } else if (state.invalid ==
                                PinInputValidationError.insufficientLength) {
                              return Text(
                                "Input must be 6 digits",
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
                            BlocBuilder<CreatePinCubit, CreatePinState>(
                          buildWhen: (previous, current) =>
                              previous != current &&
                              (current.createPinStatus ==
                                      CreatePinStatus.inputValid ||
                                  previous.createPinStatus ==
                                      CreatePinStatus.inputValid),
                          builder: (context, state) {
                            bool isPinValid = state.createPinStatus ==
                                CreatePinStatus.inputValid;
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(size.width * 0.9, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                              onPressed: () => isPinValid
                                  ? context.read<CreatePinCubit>().pinSucceed()
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
              );
            },
          ),
        ),
      ),
    );
  }
}
