import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class InputOtpWidget extends StatefulWidget {
  final String appBarTitle;
  final String bodytitle;
  final String bodySubTitle;
  final Function onCompleteFunction;
  final Function onSubmittedFunction;
  final Function onChangedFunction;
  final Widget? textError;
  final Widget buildButton;
  final Widget textCountdown;

  const InputOtpWidget(
      {Key? key,
      required this.appBarTitle,
      required this.bodytitle,
      required this.bodySubTitle,
      required this.onCompleteFunction,
      required this.onSubmittedFunction,
      required this.onChangedFunction,
      required this.textError,
      required this.buildButton,
      required this.textCountdown})
      : super(key: key);

  @override
  State<InputOtpWidget> createState() => _InputOtpWidgetState();
}

class _InputOtpWidgetState extends State<InputOtpWidget> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
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
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: size.height - 100,
      width: size.width,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30),
          Column(children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 18.0),
                  child: Text(widget.bodytitle,
                      style: _textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 48.0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Kami telah mengirimkan Kode OTP ke nomor ',
                      style: _textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: _themeData.indicatorColor,
                      ),
                    ),
                    TextSpan(
                      text: widget.bodySubTitle,
                      style: _textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: _themeData.hintColor,
                      ),
                    ),
                    TextSpan(
                      text: ', Silahkan cek dan masukkan kode OTP-nya',
                      style: _textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: _themeData.indicatorColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          PinCodeTextField(
            appContext: context,
            onCompleted: (value) => widget.onCompleteFunction(value, context),
            onSubmitted: (value) => widget.onSubmittedFunction(context),
            onChanged: (value) => widget.onChangedFunction(value, context),
            pastedTextStyle: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            length: 6,
            obscureText: true,
            controller: textEditingController,
            keyboardType: TextInputType.number,
            autoFocus: true,
            // obscuringCharacter: '*',
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(15),
              fieldHeight: 50,
              fieldWidth: 45,
              activeFillColor:
                  hasError ? Colors.orange : _themeData.primaryColorDark,
              selectedFillColor: _themeData.primaryColorDark,
              activeColor: _themeData.primaryColorDark,
              selectedColor: _themeData.primaryColorDark,
              inactiveColor: _themeData.primaryColorDark,
              inactiveFillColor: _themeData.primaryColorDark,
            ),
            cursorColor: Colors.white70,
            animationDuration: const Duration(milliseconds: 300),
            textStyle: const TextStyle(fontSize: 14, height: 1.6),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            errorAnimationController: errorController,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0),
                child: widget.textError,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: widget.textCountdown,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: widget.buildButton,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              "Masih tidak dapat Kode OTP?",
              style: _textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: _themeData.indicatorColor,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Row(
            children: [
              Container(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(165, 47.0),
                    maximumSize: Size(170, 48.0),
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                      color: _themeData.focusColor,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  child: Text(
                    "Ganti Nomor HP",
                    style: _textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
