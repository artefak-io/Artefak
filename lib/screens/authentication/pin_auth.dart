import 'package:artefak/logic/pin/pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinAuth extends StatelessWidget {
  const PinAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PinAuthCubit(context.read<PinService>())..pinRetrieved(),
      child: BlocListener<PinAuthCubit, PinAuthState>(
        listenWhen: (previous, current) =>
            current.pinAuthStatus == PinAuthStatus.success,
        listener: (context, state) {
          context.read<PinStatusCubit>().pinAuthenticated();
        },
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: const Text("Input Pin"),
            ),
            body: BlocListener<PinAuthCubit, PinAuthState>(
              listenWhen: (previous, current) =>
                  current.pinAuthStatus == PinAuthStatus.error,
              listener: (context, state) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      content: Text(state.errorMessage ?? "Error happens")));
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      onChanged: (value) {},
                      onCompleted: (value) =>
                          context.read<PinAuthCubit>().pinFilled(value),
                      onSubmitted: (value) =>
                          context.read<PinAuthCubit>().pinVerified(),
                      autoFocus: true,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                    ),
                    BlocBuilder<PinAuthCubit, PinAuthState>(
                      buildWhen: (previous, current) =>
                          current.pinAuthStatus == PinAuthStatus.failure ||
                          previous.pinAuthStatus == PinAuthStatus.failure,
                      builder: (context, state) {
                        if (state.pinAuthStatus == PinAuthStatus.failure) {
                          return const Text("Incorrect PIN");
                        } else {
                          return const Text("");
                        }
                      },
                    ),
                    // BlocBuilder<PinAuthCubit, PinAuthState>(
                    //   buildWhen: (previous, current) =>
                    //       current.pinAuthStatus != PinAuthStatus.filled,
                    //   builder: (context, state) {
                    //     return const ElevatedButton(
                    //       onPressed: null,
                    //       child: Text("Input Pin"),
                    //     );
                    //   },
                    // ),
                    BlocBuilder<PinAuthCubit, PinAuthState>(
                      buildWhen: (previous, current) =>
                          current.pinAuthStatus == PinAuthStatus.filled ||
                          previous.pinAuthStatus == PinAuthStatus.filled,
                      builder: (context, state) {
                        if (state.pinAuthStatus == PinAuthStatus.filled) {
                          return ElevatedButton(
                            onPressed: () =>
                                context.read<PinAuthCubit>().pinVerified(),
                            child: const Text("Input Pin"),
                          );
                        } else {
                          return const ElevatedButton(
                            onPressed: null,
                            child: Text("Input Pin"),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
