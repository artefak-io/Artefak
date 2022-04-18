import 'package:artefak/widgets/input_pin_widget.dart';
import 'package:flutter/material.dart';

class RetypePin extends StatefulWidget {
  final String phoneNumber;
  final String title;
  final String subTitle;
  const RetypePin(
      {Key? key,
      required this.phoneNumber,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  State<RetypePin> createState() => _RetypePinState();
}

class _RetypePinState extends State<RetypePin> {
  @override
  Widget build(BuildContext context) {
    const String subTitle = 'Ulangi 6 digit PIN anda sebelumnya.';
    const String title = 'Kunci Akses Baru';
    const String phoneNumber = '6291883928';

    return const InputPinWidget(
      phoneNumber: phoneNumber,
      title: title,
      subTitle: subTitle,
    ); //TODO: function passing
  }
}
