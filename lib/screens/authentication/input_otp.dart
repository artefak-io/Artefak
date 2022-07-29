import 'dart:async';

import 'package:artefak/logic/auth/auth.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/widgets/input_otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputOTP extends StatefulWidget {
  const InputOTP({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  State<InputOTP> createState() => _InputOTPState();
}

class _InputOTPState extends State<InputOTP> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int resendToken;
  late String verificationId;
  bool isTextFieldNull = false;
  bool isNotInteger = false, isOtpValid = false;
  int _otpDuration = 60;
  late Timer _timer;

  void startOtpTimer() {
    _otpDuration = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_otpDuration == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _otpDuration--;
          });
        }
      },
    );
  }

  void setTokenId(int token, String id) {
    setState(() {
      resendToken = token;
      verificationId = id;
    });
  }

  void inputOtpOnComplete(String value, BuildContext context) async {
    if (value == null || value.isEmpty) {
      isTextFieldNull = true;
    } else if (int.tryParse(value) == null) {
      isNotInteger = true;
    } else {
      isTextFieldNull = false;
      isNotInteger = false;
    }
    if (!isTextFieldNull && !isNotInteger) {
      // TODO: this is backdoor, remove this
      if (value == '000000') {
        verificationId = '12345';
      }
      // TODO: if value false add return value
      await AuthService()
          .loginWithPhone(verificationId: verificationId, smsCode: value);
    }
  }

  void inputOtpOnSubmitted(BuildContext context) {
    if (!isTextFieldNull && !isNotInteger) {
      isOtpValid = true;
    }
  }

  void inputOtpOnChanged(String value, BuildContext context) {}

  @override
  void initState() {
    super.initState();
    startOtpTimer();
    AuthService()
        .requestOTP(phoneNumber: widget.phoneNumber, setTokenId: setTokenId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous != current &&
          current.authenticationStatus == AuthenticationStatus.authenticated,
      listener: (context, state) {
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Verifikasi Nomor HP",
            style: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 20,
                top: -165,
                child: Image.asset(
                  'assets/bggrad.png',
                  fit: BoxFit.fitHeight,
                  height: 350,
                ),
              ),
              InputOtpWidget(
                bodytitle: 'Cek Kode OTP',
                bodySubTitle: widget.phoneNumber,
                appBarTitle: 'Verifikasi Nomor HP',
                onCompleteFunction: inputOtpOnComplete,
                onSubmittedFunction: inputOtpOnSubmitted,
                onChangedFunction: inputOtpOnChanged,
                textCountdown: _otpDuration != 0
                    ? Text(
                        "Mohon tunggu dalam 00:$_otpDuration untuk kirim ulang",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).indicatorColor,
                            ),
                      )
                    : Row(
                        children: [
                          Text(
                            "Mau kirim ulang? ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).indicatorColor,
                                ),
                          ),
                          TextButton(
                            child: Text(
                              'Klik di sini',
                              style: _textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: _themeData.hintColor,
                              ),
                            ),
                            onPressed: () {
                              startOtpTimer();
                              AuthService().requestOTP(
                                phoneNumber: widget.phoneNumber,
                                setTokenId: setTokenId,
                                resendToken: resendToken,
                              );
                            },
                          ),
                        ],
                      ),
                textError: isTextFieldNull || isNotInteger
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          isTextFieldNull
                              ? "Input must be 6 digits"
                              : isNotInteger
                                  ? "Input must be a number"
                                  : "",
                          style: _textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: _themeData.errorColor,
                          ),
                        ),
                      )
                    : null,
                buildButton: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width * 0.9, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Verifikasi Sekarang",
                    style: _textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: isOtpValid
                          ? _themeData.textSelectionColor
                          : _themeData.textSelectionColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
