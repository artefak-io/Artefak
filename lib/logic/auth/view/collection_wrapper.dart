import 'package:artefak/logic/auth/auth.dart';
import 'package:artefak/logic/pin/pin.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionWrapper extends StatelessWidget {
  const CollectionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.authenticationStatus == AuthenticationStatus.authenticated) {
          return const CollectionPinWrapper();
        } else {
          return const Authenticate();
        }
      },
    );
  }
}
