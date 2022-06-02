import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const String idnCode = "+62";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Authentication"),
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
                const Text(
                  idnCode,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 100,
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
                    await _auth.verifyPhoneNumber(
                      phoneNumber: idnCode + _phoneNumberController.text,
                      verificationCompleted:
                          (PhoneAuthCredential userCredential) {
                        _auth.signInWithCredential(userCredential);
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                      verificationFailed: (FirebaseAuthException error) {
                        print(error.message);
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Text("Enter SMS Code"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  controller: _codeController,
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Done"),
                                onPressed: () {
                                  FirebaseAuth auth = FirebaseAuth.instance;

                                  String smsCode = _codeController.text.trim();

                                  PhoneAuthCredential _credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: smsCode);
                                  auth
                                      .signInWithCredential(_credential)
                                      .then((UserCredential result) {
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/'));
                                  }).catchError((e) {
                                    print(e);
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        print(verificationId);
                        print("Timout");
                      },
                    );
                  }
                },
                child: const Text("Confirm"))
          ],
        ),
      )),
    );
  }
}
