import 'package:artefak/screens/authentication/input_otp.dart';
import 'package:flutter/material.dart';

Widget SignInUpSlidingPanel(ValueChanged<int> page, BuildContext context,
    TextEditingController _emailController, String _emailPhoneText) {
  Size size = MediaQuery.of(context).size;
  TextTheme _textTheme = Theme.of(context).textTheme;
  ThemeData _themeData = Theme.of(context);

  const String idnCode = "+62";
  var emailRex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneNumberRex = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: _themeData.canvasColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 8.0,
                width: 55.0,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              height: size.height * 0.55 - 24.0,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Masuk / Daftar Akun Dulu',
                        style: _textTheme.displaySmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                        'Sapa masa depanmu! Kita percaya masa depan selalu lebih baik, miliki dan mulai sekarang!',
                        style: _textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: _themeData.focusColor),
                        textAlign: TextAlign.start),
                  ),
                  Container(
                    child: Text('Masukkan email / nomor HP aktifmu',
                        style: _textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: _themeData.indicatorColor),
                        textAlign: TextAlign.start),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          decoration: BoxDecoration(
                            color: _themeData.primaryColorDark,
                            border: Border.all(width: 1, color: Colors.black26),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: const Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              suffixIcon: _emailPhoneText.isEmpty
                                  ? null
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => _emailController.clear(),
                                    ),
                              labelText: 'Email / no HP',
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                            style: const TextStyle(color: Colors.white),
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        ElevatedButton(
                          child: Text(
                            'Mulai Sekarang!',
                            style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(size.width * 0.9, 48.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              alignment: Alignment.center),
                          onPressed: () async {
                              if (emailRex.hasMatch(_emailPhoneText)) {
                                // add open gmail and wait for authenticated status
                                page(1);
                              } else if (phoneNumberRex
                                  .hasMatch(_emailPhoneText)) {
                                print(idnCode + _emailPhoneText);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => InputOTP(
                                          phoneNumber:
                                              idnCode + _emailPhoneText,
                                        )),
                                  ),
                                );
                              }
                          },
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Dengan masuk atau mendaftar, saya menyetujui ',
                            style: _textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Syarat dan Ketentuan ',
                            style: _textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.hintColor,
                            ),
                          ),
                          TextSpan(
                            text: 'serta ',
                            style: _textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Kebijakan Privasi',
                            style: _textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
