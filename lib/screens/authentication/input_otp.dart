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

  void setTokenId(int token, String id) {
    setState(() {
      resendToken = token;
      verificationId = id;
    });
  }

  void inputOtpOnComplete(){

  }

  void inputOtpOnSubmitted(){

  }

  void inputOtpOnChanged(){

  }

  @override
  void initState() {
    super.initState();
    AuthService()
        .requestOTP(phoneNumber: widget.phoneNumber, setTokenId: setTokenId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Input SMS Code"),
      ),
      body: SingleChildScrollView(
          child:
        //   BlocListener<AuthBloc, AuthState>(
        // listenWhen: (previous, current) =>
        //     previous != current &&
        //     current.authenticationStatus == AuthenticationStatus.authenticated,
        // listener: (context, state) {
        //   Navigator.pop(context);
        // },
        // child: Stack(
        //   children: <Widget>[
        //     Positioned(
        //       left: 20,
        //       top: -165,
        //       child: Image.asset(
        //         'assets/bggrad.png',
        //         fit: BoxFit.fitHeight,
        //         height: 350,
        //       ),
        //     ),
            // InputOtpWidget(
            //   bodytitle: 'Cek Kode OTP',
            //   bodySubTitle:
            //   'Kami telah mengirimkan Kode OTP ke nomor +62 85643099280 , Silahkan cek dan masukkan kode OTP-nya',
            //   appBarTitle: 'Verifikasi Nomor HP',
            //   onCompleteFunction: inputOtpOnComplete,
            //   onSubmittedFunction: inputOtpOnSubmitted,
            //   onChangedFunction: inputOtpOnChanged,
            //   blocBuildNotify:
            //   BlocBuilder<InputOtpCubit, InputOtpState>(
            //     buildWhen: (previous, current) =>
            //     (current.createPinStatus ==
            //         InputOtpStatus.inputInvalid &&
            //         previous.invalid != current.invalid) ||
            //         previous.createPinStatus ==
            //             InputOtpStatus.inputInvalid,
            //     builder: (context, state) {
            //       if (state.invalid ==
            //           OtpInputValidationError.nonNumberInput) {
            //         return Text(
            //           "Input must be a number",
            //           style: _textTheme.bodyLarge?.copyWith(
            //             fontWeight: FontWeight.w400,
            //             color: _themeData.errorColor,
            //           ),
            //         );
            //       } else if (state.invalid ==
            //           OtpInputValidationError.insufficientLength) {
            //         return Text(
            //           "Input must be 6 digits",
            //           style: _textTheme.bodyLarge?.copyWith(
            //             fontWeight: FontWeight.w400,
            //             color: _themeData.errorColor,
            //           ),
            //         );
            //       } else {
            //         return const Text("");
            //       }
            //     },
            //   ),
            //   blocBuildButton:
            //   BlocBuilder<InputOtpCubit, InputOtpState>(
            //     buildWhen: (previous, current) =>
            //     previous != current &&
            //         (current.createPinStatus ==
            //             InputOtpStatus.inputValid ||
            //             previous.createPinStatus ==
            //                 InputOtpStatus.inputValid),
            //     builder: (context, state) {
            //       bool isPinValid = state.createPinStatus ==
            //           InputOtpStatus.inputValid;
            //       return ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           minimumSize: Size(size.width * 0.9, 48),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(100.0),
            //           ),
            //         ),
            //         onPressed: () => isPinValid
            //             ? context.read<InputOtpCubit>().pinSucceed()
            //             : null,
            //         child: Text(
            //           "Input PIN",
            //           style: _textTheme.bodyLarge?.copyWith(
            //             fontWeight: FontWeight.w400,
            //             color: isPinValid
            //                 ? _themeData.textSelectionColor
            //                 : _themeData.textSelectionColor
            //                 .withOpacity(0.5),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
        //   ],
        // ),
        Column(
          children: <Widget>[
            Row(
              children: [
                Text(widget.phoneNumber),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Wrong Number"),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _codeController,
                    decoration: const InputDecoration(
                      hintText: "Input OTP Code",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '*please input phone number';
                      } else if (int.tryParse(value) == null) {
                        return '*please input valid phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await AuthService().loginWithPhone(
                                verificationId: verificationId,
                                smsCode: _codeController.text);
                          }
                        },
                        child: const Text("Confirm"),
                      ),
                      // needs countdown counter for 30 seconds
                      ElevatedButton(
                        onPressed: () {
                          AuthService().requestOTP(
                            phoneNumber: widget.phoneNumber,
                            setTokenId: setTokenId,
                            resendToken: resendToken,
                          );
                        },
                        child: const Text("Resend Code"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
