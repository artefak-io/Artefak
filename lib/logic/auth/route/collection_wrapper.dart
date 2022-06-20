import 'package:artefak/logic/auth/auth.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/screens/main/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionWrapper extends StatelessWidget {
  const CollectionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.authenticationStatus == AuthenticationStatus.authenticated) {
          return Collection();
        } else {
          return const Authenticate();
        }
      },
    );
  }
}
