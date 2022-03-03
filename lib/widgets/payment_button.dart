import 'package:artefak/services/auth.dart';
import 'package:artefak/services/payment_service_firestore.dart';
import 'package:artefak/services/payment_service_oy.dart';
import 'package:artefak/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    Key? key,
    required this.price,
    required this.assetName,
    required this.assetId,
    required this.bankLogo,
    required this.bankCode,
  }) : super(key: key);

  final int price;
  final String assetName;
  final String assetId;
  final Image bankLogo;
  final String bankCode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: bankLogo,
      iconSize: 50,
      onPressed: () async {
        Future<Map<String, dynamic>> result = PaymentServiceOy()
            .testVirtualAccount(AuthService.user!.uid, bankCode, price)
            .then((value1) => PaymentFirestore().newPayment(value1))
            .then((value2) =>
                TransactionService().newTransaction(assetId, assetName, value2))
            .catchError((error) => print(error));
        return showDialog(
          context: context,
          builder: (BuildContext context) => FutureBuilder(
            future: result,
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return AlertDialog(
                  title: Text(assetName),
                  content: Column(
                    children: <Widget>[
                      const Text("Account Holder"),
                      Text(snapshot.data!["username_display"]),
                      const Text("Account Number"),
                      Text(
                        '${TransactionService().getBankNameVA(snapshot.data!["bank_code"])} ${snapshot.data!["va_number"]}',
                      ),
                      const Text("Amount"),
                      Text(NumberFormat.currency(locale: 'id')
                          .format(snapshot.data!["amount"])),
                      const Text("Due date"),
                      Text(DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data!["expiration_time"])
                          .toLocal()
                          .toString()),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Center(
                    child: Text("Something has going wrong"),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    ),
                  ],
                );
              } else {
                return const SimpleDialog(
                  title: Text("Please Wait"),
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}
