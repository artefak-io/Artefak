import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/services/transaction_service.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction extends StatelessWidget {
  Transaction({Key? key}) : super(key: key);

  static const index = 1;

  late final Stream<QuerySnapshot> _transactionStream;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    if (AuthService.user == null) {
      return const Authenticate();
    } else {
      _transactionStream =
          TransactionService().personalTransaction(AuthService.user!.uid);
      return AppLayout(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(
              'Transaction',
              style:
                  _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          body: StreamBuilder(
            stream: _transactionStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //should show something when null
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            snapshot.data!.docs[index]['assetName'],
                          ),
                          subtitle: Text(
                            "Status: ${snapshot.data!.docs[index]['status']}",
                          ),
                          onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                snapshot.data!.docs[index]['assetName'],
                              ),
                              content: Column(
                                children: <Widget>[
                                  const Text("Account Holder"),
                                  Text(snapshot.data!.docs[index]["vaHolder"]),
                                  const Text("Account Number"),
                                  Text(
                                    '${snapshot.data!.docs[index]["bankName"]} ${snapshot.data!.docs[index]["vaNumber"]}',
                                  ),
                                  const Text("Amount"),
                                  Text(NumberFormat.currency(locale: 'id')
                                      .format(
                                          snapshot.data!.docs[index]["price"])),
                                  const Text("Due date"),
                                  Text(DateTime.fromMillisecondsSinceEpoch(
                                          snapshot.data!.docs[index]["expTime"])
                                      .toLocal()
                                      .toString()),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Cancel Transaction",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Close"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          bottomNavigationBar: const BotNavBar(
            currentIndex: index,
          ),
        ),
      );
    }
  }
}
