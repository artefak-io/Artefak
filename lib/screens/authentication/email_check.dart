import 'package:artefak/screens/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailCheck extends StatelessWidget {
  const EmailCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    return AppLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(children: <Widget>[
              Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: MediaQuery.of(context).size.width - 10,
                      height: 140,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 85, bottom: 32),
                        child: SvgPicture.asset('assets/logo.svg',
                            width: 150, fit: BoxFit.scaleDown),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text('Cek E-mail',
                        style: _textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                        'Kami telah mengirimkan e-mail verifikasi untuk akun kamu, wicaksonorc@gmail.com',
                        style: _textTheme.displaySmall
                            ?.copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start),
                  ),
                  ElevatedButton(
                    child: Text('Mulai Sekarang!',
                        style: _textTheme.button?.copyWith(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFFFFFF))),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(size.width * 0.4, 54),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onPressed: () {},
                  )
                ],
              )
            ]),
          )
        ]),
      ),
    );
  }
}
