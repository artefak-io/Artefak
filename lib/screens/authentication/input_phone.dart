import 'package:artefak/screens/authentication/input_otp.dart';
import 'package:flutter/material.dart';

class InputPhone extends StatefulWidget {
  const InputPhone({Key? key}) : super(key: key);

  @override
  State<InputPhone> createState() => _InputPhoneState();
}

class _InputPhoneState extends State<InputPhone> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const String idnCode = "+62";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Input Phone Number"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('Enter your phone number'),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(idnCode),
                  Expanded(
                    child: TextFormField(
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return '*please input phone number';
                        } else if (int.tryParse(value) == null) {
                          return '*please input valid phone number';
                        } else {
                          return null;
                        }
                      },
                      controller: _phoneNumberController,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => InputOTP(
                                phoneNumber:
                                    idnCode + _phoneNumberController.text,
                              )),
                        ),
                      );
                    }
                  },
                  child: const Text("Send OTP Code"))
            ],
          ),
        ),
      ),
    );
  }
}
