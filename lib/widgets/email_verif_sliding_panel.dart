import 'package:flutter/material.dart';

Widget EmailVerifSlidingPanel(ValueChanged<int> page, BuildContext context) {
  Size size = MediaQuery.of(context).size;
  TextTheme _textTheme = Theme.of(context).textTheme;
  ThemeData _themeData = Theme.of(context);

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
                  borderRadius: BorderRadius.circular(10.0),
                ),
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
                    child: Text('Verifikasi Email',
                        style: _textTheme.displaySmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start),
                  ),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                            'Kami telah mengirimkan link verifikasi ke alamat email ',
                            style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.indicatorColor,
                            ),
                          ),
                          TextSpan(
                            text: 'wicaksonorc@gmail.com',
                            style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.hintColor,
                            ),
                          ),
                          TextSpan(
                            text: ', Silahkan cek dan klik link verifikasinya',
                            style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.indicatorColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        child: Text(
                          'Buka Email Saya',
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
                        onPressed: () => page(0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: Text('Apakah mau ganti email?',
                        style: _textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w400, color: _themeData.indicatorColor,),
                        textAlign: TextAlign.start),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(size.width * 0.4, 48.0),
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: _themeData.focusColor,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      child: Text(
                        "Ganti Email",
                        style: _textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      onPressed: () => page(0),
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
