import 'package:artefak/logic/pin/pin.dart';
import 'package:artefak/screens/authentication/confirm_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CreatePin extends StatelessWidget {
  const CreatePin({Key? key}) : super(key: key);

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
                    (value) => context.read<CreatePinCubit>().pinCreateValid());
          },
          child: Builder(builder: (context) {
            return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(title: const Text("Create Pin")),
              body: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      context
                          .read<CreatePinCubit>()
                          .pinValidatedOnChanged(value);
                    },
                    onCompleted: (value) {
                      context
                          .read<CreatePinCubit>()
                          .pinValidatedOnCompleted(value);
                    },
                    onSubmitted: (value) {
                      context.read<CreatePinCubit>().pinSucceed();
                    },
                    autoFocus: true,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),
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
                  // BlocBuilder<CreatePinCubit, CreatePinState>(
                  //   buildWhen: (previous, current) =>
                  //       current.createPinStatus != CreatePinStatus.inputValid,
                  //   builder: (context, state) {
                  //     return const ElevatedButton(
                  //       onPressed: null,
                  //       child: Text("Input PIN"),
                  //     );
                  //   },
                  // ),
                  BlocBuilder<CreatePinCubit, CreatePinState>(
                    buildWhen: (previous, current) =>
                        previous != current &&
                        (current.createPinStatus ==
                                CreatePinStatus.inputValid ||
                            previous.createPinStatus ==
                                CreatePinStatus.inputValid),
                    builder: (context, state) {
                      if (state.createPinStatus == CreatePinStatus.inputValid) {
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
                ],
              )),
            );
          }),
        ),
      ),
    );
  }
}
