import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class InputPinWidget extends StatefulWidget {
  final String phoneNumber;
  final String title;
  final String subTitle;

  const InputPinWidget(
      {Key? key,
      required this.phoneNumber,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  State<InputPinWidget> createState() => _InputPinWidgetState();
}

class _InputPinWidgetState extends State<InputPinWidget> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
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
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Buat Pin',
            style:
                _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
        backgroundColor: _themeData.primaryColor,
      ),
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF434343), Color(0xFF000000)],
          )),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, bottom: 20, right: 16),
                      child: Text(widget.title,
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF3F4F6)),
                          textAlign: TextAlign.start),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                  child: Text(widget.subTitle,
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFD1D5DB)),
                      textAlign: TextAlign.start),
                ),
              ]),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      length: 6,
                      obscureText: true,
                      // obscuringCharacter: '*',
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15),
                          fieldHeight: 50,
                          fieldWidth: 45,
                          activeFillColor: hasError
                              ? Colors.orange
                              : const Color(0xFF333333),
                          selectedFillColor: const Color(0xFF3D3D3D),
                          activeColor: const Color(0xFF3D3D3D),
                          selectedColor: const Color(0xFF333333),
                          inactiveColor: const Color(0xFF3D3D3D),
                          inactiveFillColor: const Color(0xFF3D3D3D)),
                      cursorColor: Colors.white70,
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle: const TextStyle(fontSize: 14, height: 1.6),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      child: Text(
                        'Lanjut',
                        style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width * 0.9, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
