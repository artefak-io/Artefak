import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/screens/main/transaction.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth.dart';

class TransactionWrapper extends StatelessWidget {
  const TransactionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.authenticationStatus == AuthenticationStatus.authenticated) {
          return Transaction();
        } else {
          return const Authenticate();
        }
      },
    );
  }
}
