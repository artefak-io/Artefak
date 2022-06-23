import 'package:artefak/logic/pin/pin.dart';
import 'package:artefak/screens/authentication/create_pin.dart';
import 'package:artefak/screens/authentication/pin_auth.dart';
import 'package:artefak/screens/main/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePinWrapper extends StatelessWidget {
  const ProfilePinWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinStatusCubit, PinStatusState>(
      builder: (context, state) {
        if (state.pinStatusStatus == PinStatusStatus.noPin) {
          return const CreatePin();
        } else if (state.pinStatusStatus == PinStatusStatus.hasPin) {
          return const PinAuth();
        } else if (state.pinStatusStatus == PinStatusStatus.authenticated) {
          return Profile();
        } else if (state.pinStatusStatus == PinStatusStatus.error) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
