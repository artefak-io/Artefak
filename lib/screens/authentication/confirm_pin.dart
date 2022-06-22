import 'package:artefak/logic/pin/pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmPin extends StatelessWidget {
  const ConfirmPin({required this.pin, Key? key}) : super(key: key);

  final String pin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmPinCubit(context.read<PinService>()),
      child: BlocListener<ConfirmPinCubit, ConfirmPinState>(
        listenWhen: (previous, current) =>
            current.confirmPinStatus == ConfirmPinStatus.success,
        listener: (context, state) {
          context.read<PinStatusCubit>().pinAuthenticated();
          Navigator.pop(context);
        },
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(title: const Text("Confirm PIN")),
            body: BlocListener<ConfirmPinCubit, ConfirmPinState>(
              listenWhen: (previous, current) =>
                  current.confirmPinStatus == ConfirmPinStatus.error,
              listener: (context, state) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      content: Text(state.errorMessage ?? 'Error happens')));
              },
              child: BlocListener<ConfirmPinCubit, ConfirmPinState>(
                listenWhen: (previous, current) =>
                    current.confirmPinStatus == ConfirmPinStatus.loading,
                listener: (context, state) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        const SnackBar(content: Text("Please wait a minute")));
                },
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      onChanged: (value) => context
                          .read<ConfirmPinCubit>()
                          .pinValidatedOnChange(value),
                      onCompleted: (value) => context
                          .read<ConfirmPinCubit>()
                          .pinValidatedOnCompleted(value, pin),
                      onSubmitted: (value) =>
                          context.read<ConfirmPinCubit>().pinCreated(),
                      autoFocus: true,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                    ),
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
                          return const Text("Input must be a number");
                        } else if (state.pinInputValidationError ==
                            PinInputValidationError.insufficientLength) {
                          return const Text("Input must be 6 digits");
                        } else if (state.pinInputValidationError ==
                            PinInputValidationError.inputDoesntMatch) {
                          return const Text("Input pin doesn't match");
                        } else {
                          return const Text("");
                        }
                      },
                    ),
                    // BlocBuilder<ConfirmPinCubit, ConfirmPinState>(
                    //   buildWhen: (previous, current) =>
                    //       current.confirmPinStatus !=
                    //       ConfirmPinStatus.inputValid,
                    //   builder: (context, state) {
                    //     return const ElevatedButton(
                    //       onPressed: null,
                    //       child: Text("Input PIN"),
                    //     );
                    //   },
                    // ),
                    BlocBuilder<ConfirmPinCubit, ConfirmPinState>(
                      buildWhen: (previous, current) =>
                          current.confirmPinStatus ==
                              ConfirmPinStatus.inputValid ||
                          previous.confirmPinStatus ==
                              ConfirmPinStatus.inputValid,
                      builder: (context, state) {
                        if (state.confirmPinStatus ==
                            ConfirmPinStatus.inputValid) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<ConfirmPinCubit>().pinCreated();
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
                  ],
                )),
              ),
            ),
          );
        }),
      ),
    );
  }
}
