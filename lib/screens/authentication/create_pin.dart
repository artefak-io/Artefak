import 'package:artefak/widgets/input_pin_widget.dart';
import 'package:flutter/material.dart';

class CreatePin extends StatefulWidget {
  final String phoneNumber;
  final String title;
  final String subTitle;
  const CreatePin(
      {Key? key,
      required this.phoneNumber,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  @override
  Widget build(BuildContext context) {
    const String subTitle =
        'Masukkan 6 digit Pin yang dibuat untuk memudahkan akses dan keamanan yang lebih baik.';
    const String title = 'Kunci Akses Baru';
    const String phoneNumber = '6291883928';

    return const InputPinWidget(
      phoneNumber: phoneNumber,
      title: title,
      subTitle: subTitle,
    ); //TODO: function passing
  }
}
