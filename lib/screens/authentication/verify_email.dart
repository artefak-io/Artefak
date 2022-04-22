import 'dart:async';

import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/create_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyEmail extends StatefulWidget {
  final String email;

  const VerifyEmail({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool _isVerified = false;
  bool canResendEmail = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    if (!_isVerified) {
      sendVerificationEmail();

      _timer =
          Timer.periodic(const Duration(seconds: 3), (_) => checkVerified());
    }
  }

  Future checkVerified() async {
    // await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      // _isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (_isVerified) _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      // final user = FirebaseAuth.instance.currentUser!;
      // await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      // Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;

    return AppLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
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
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Text('Cek E-mail',
                                style: _textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Text(
                            'E-mail verifikasi telah dikirimkan ke akun kamu dengan e-mail, ',
                            style: _textTheme.displaySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        child: Text(
                          'Buka E-mail Saya',
                          style: _textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(size.width * 0.9, 48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text('Apakah ingin mengganti alamat e-mail?',
                          style: _textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton(
                          child: Text(
                            'Ubah E-mail',
                            style: _textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.transparent,
                            minimumSize: Size(size.width * 0.3, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            side: const BorderSide(color: Colors.white70),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreatePin(
                                    phoneNumber: '+8837392732',
                                    title: 'Kunci Akses Baru',
                                    subTitle:
                                        'Masukkan 6 digit Pin yang dibuat untuk memudahkan akses dan keamanan yang lebih baik.'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
