

import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'create_pin.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState(){
    super.initState();

    // isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkVerified());
    }
  }

  Future checkVerified() async {
    // await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      // isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future sendVerificationEmail() async {
    try{
      // final user = FirebaseAuth.instance.currentUser!;
      // await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      // Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              _themeData.backgroundColor,
              _themeData.shadowColor
            ],
          )),
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
                          child:
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width - 10,
                            height: 140,

                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 85, bottom: 32),
                              child: SvgPicture.asset('assets/logo.svg',width: 150, fit: BoxFit.scaleDown),
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
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child:
                              Text('Cek E-mail',
                                  style: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700,),
                                  textAlign: TextAlign.start
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child:
                          Text('E-mail verifikasi telah dikirimkan ke akun kamu dengan e-mail, ',
                              style: _textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          child: ElevatedButton(
                            child: Text('Buka E-mail Saya', style: _textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400),),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(size.width * 0.9, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                            onPressed: () {

                            },
                            // onPressed: (){},
                            // onPressed: () async {
                            //   if (_formKey.currentState!.validate()) {
                            //     User? result = await AuthService().signInEmailPass(
                            //         _emailController.text,
                            //     );
                            //     if (result == null) {
                            //       print('error signing in');
                            //     } else {
                            //       print(result);
                            //     }
                            //   }
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Text('Apakah ingin mengganti alamat e-mail?',
                              style: _textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400,),
                              textAlign: TextAlign.start
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          alignment: Alignment.centerLeft,
                            child: OutlinedButton(
                              child: Text('Ubah E-mail', style: _textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400),),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.transparent,
                                minimumSize: Size(size.width * 0.3, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                ),
                                side: BorderSide(color: Colors.white70)
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const CreatePin(phoneNumber: '+8837392732', title: 'Kunci Akses Baru', subTitle: 'Masukkan 6 digit Pin yang dibuat untuk memudahkan akses dan keamanan yang lebih baik.')),
                                );
                              },
                            ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
