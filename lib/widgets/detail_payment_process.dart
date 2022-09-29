import 'dart:async';

import 'package:artefak/screens/main/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DetailPaymentProcess extends StatefulWidget {
  const DetailPaymentProcess({
    required this.data,
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  State<DetailPaymentProcess> createState() => _DetailPaymentProcessState();
}

class _DetailPaymentProcessState extends State<DetailPaymentProcess> {
  late int secondCounter, minuteCounter, hourCounter;
  late Timer _myTimer;
  late String status;

  @override
  void initState() {
    super.initState();
    secondCounter =
        int.parse(DateTime.parse(widget.data['expiredAt']).second.toString());
    minuteCounter =
        int.parse(DateTime.parse(widget.data['expiredAt']).minute.toString());
    hourCounter =
        int.parse(DateTime.parse(widget.data['expiredAt']).hour.toString());
    startTimer();
    switch (widget.data['status']) {
      case 'pending':
        status = Status.pending;
        break;
      case 'completed':
        status = Status.completed;
        break;
      case 'missed':
        status = Status.missed;
        break;
      default:
        status = '';
    }
  }

  void startTimer() {
    _myTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondCounter--;
      });
      if (secondCounter == -1) {
        setState(() {
          secondCounter = 59;
          minuteCounter--;
        });
      }
      if (minuteCounter == -1) {
        setState(() {
          minuteCounter = 59;
          hourCounter--;
        });
      }
      if (hourCounter == 0 && minuteCounter == 0 && secondCounter == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _myTimer.cancel(); // Need dispose cancel to make the countdown works
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Selesaikan Pembayaran',
              style: _textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Pembayaran dapat dilakukan sebelum:',
              style: _textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400, color: _themeData.focusColor),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 25.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 6.0,
                ),
                Text(
                  hourCounter.toString() +
                      ' Jam ' +
                      minuteCounter.toString() +
                      ' menit ' +
                      secondCounter.toString() +
                      ' detik',
                  style: _textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _themeData.toggleableActiveColor),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: _themeData.shadowColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            height: 48,
            alignment: Alignment.centerLeft,
            child: Text(
              'Kepemilikan tokenmu akan resmi setelah proses pembayaran selesai sebelum batas waktu diatas!',
              style: _textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: _themeData.secondaryHeaderColor),
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Status',
                      style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: _themeData.focusColor),
                    ),
                    Spacer(),
                    Text(
                      status,
                      style: _textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Text(
                      'ID Pesanan Token',
                      style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: _themeData.focusColor),
                    ),
                    Spacer(),
                    Text(
                      'ARTE-8652314681',
                      style: _textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Text(
                      'Nama Tujuan',
                      style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: _themeData.focusColor),
                    ),
                    Spacer(),
                    Text(
                      widget.data['displayName'],
                      style: _textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No. Virtual Account ${widget.data['paymentMethodType'].replaceAll("va", "").toUpperCase()}',
                          style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                        ),
                        Text(
                          widget.data['paymentNumber'],
                          style: _textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: _themeData.focusColor,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.content_copy,
                            color: Colors.white,
                            size: 12.0,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "Salin",
                            style: _textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      onPressed: () => Clipboard.setData(
                              ClipboardData(text: widget.data['paymentNumber']))
                          .then(
                        (value) {
                          final snackBar = SnackBar(
                            content: Text('Copied to Clipboard'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Bayar',
                          style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                        ),
                        Text(
                          "Rp${NumberFormat.decimalPattern('id').format(widget.data['amount'])}",
                          style: _textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: _themeData.focusColor,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.content_copy,
                            color: Colors.white,
                            size: 12.0,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "Salin",
                            style: _textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      onPressed: () => Clipboard.setData(ClipboardData(
                              text: widget.data['amount'].toString()))
                          .then(
                        (value) {
                          final snackBar = SnackBar(
                            content: Text('Copied to Clipboard'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
