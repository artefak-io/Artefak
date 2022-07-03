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
                      builder: (context) =>
                          ConfirmPin(pin: state.pinInput.value),
                    ))
                .then(
                    (value) => context.read<CreatePinCubit>().pinCreateValid(),
            );
          },
          child: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBar(title: const Text("Buat PIN")),
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
                        phoneNumber: '+62817739337238',
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
                              return const Text("Input must be a number");
                            } else if (state.invalid ==
                                PinInputValidationError.insufficientLength) {
                              return const Text("Input must be 6 digits");
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
                            if (state.createPinStatus ==
                                CreatePinStatus.inputValid) {
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<CreatePinCubit>().pinSucceed();
                                },
                                child: const Text("Input PIN"),
                              );
                            } else {
                              return const ElevatedButton(
                                onPressed: null,
                                child: Text("Input PIN"),
                              );
                            }
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
