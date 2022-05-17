import 'package:artefak/services/auth.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    AuthService()
        .requestOTP(phoneNumber: widget.phoneNumber, setTokenId: setTokenId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input SMS Code"),
      ),
      body: SingleChildScrollView(
          child: Column(
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
                          if (AuthService.user != null) {
                            Navigator.pop(context);
                          }
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
                        if (AuthService.user != null) {
                          Navigator.pop(context);
                        } else {
                          print("error in Resend Code button");
                        }
                      },
                      child: const Text("Resend Code"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
