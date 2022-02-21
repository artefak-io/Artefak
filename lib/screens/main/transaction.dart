import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/services/transaction_service.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  Transaction({Key? key}) : super(key: key);

  static const index = 1;

  late final Stream<QuerySnapshot> _transactionStream;

  @override
  Widget build(BuildContext context) {
    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      _transactionStream =
          TransactionService().personalTransaction(AuthService.user!.uid);
      return Scaffold(
        appBar: AppBar(
          title: const Text('Transaction'),
        ),
        body: StreamBuilder(
          stream: _transactionStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card();
                  });
            } else {
              return const Center(
                child: Text("You haven't made any transaction yet"),
              );
            }
          },
        ),
        bottomNavigationBar: const BotNavBar(
          currentIndex: index,
        ),
      );
    }
  }
}
