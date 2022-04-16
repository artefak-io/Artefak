
import 'dart:async';

import 'package:artefak/widgets/input_pin_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CreatePin extends StatefulWidget {
  final String phoneNumber;
  final String title;
  final String subTitle;
  const CreatePin({Key? key, required this.phoneNumber, required this.title, required this.subTitle}) : super(key: key);

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final String subTitle = 'Masukkan 6 digit Pin yang dibuat untuk memudahkan akses dan keamanan yang lebih baik.';
    final String title = 'Kunci Akses Baru';
    final String phoneNumber = '6291883928';

    return InputPinWidget(phoneNumber: phoneNumber, title: title, subTitle: subTitle,); //TODO: function passing
  }
}
