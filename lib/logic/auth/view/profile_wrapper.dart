import 'package:artefak/logic/auth/auth.dart';
import 'package:artefak/logic/pin/pin.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.authenticationStatus == AuthenticationStatus.authenticated) {
          return const ProfilePinWrapper();
        } else {
          return const Authenticate();
        }
      },
    );
  }
}
