import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/verify_email.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/widgets/scroll_view_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  final VoidCallback toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final ScrollController _scrollControllerTop = ScrollController();
  final ScrollController _scrollControllerBottom = ScrollController();
  String _emailText = "";

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  List movies1 = ['image_1.png', 'image_2.png', 'image_3.png'];
  List movies2 = ['image_3.png', 'image_1.png', 'image_2.png'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      double minScrollExtentTop = _scrollControllerTop.position.minScrollExtent;
      double maxScrollExtentTop = _scrollControllerTop.position.maxScrollExtent;
      double minScrollExtentBottom =
          _scrollControllerBottom.position.minScrollExtent;
      double maxScrollExtentBottom =
          _scrollControllerBottom.position.maxScrollExtent;
      //
      animateToMaxMin(maxScrollExtentTop, minScrollExtentTop,
          maxScrollExtentTop, 25, _scrollControllerTop);
      animateToMaxMin(maxScrollExtentBottom, minScrollExtentBottom,
          maxScrollExtentBottom, 15, _scrollControllerBottom);
    });

    _emailController.addListener(() {
      setState(() {
        _emailText = _emailController.text;
      });
    });
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    return AppLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: -120,
                    top: -100,
                    child: Image.asset(
                      'assets/bggrad.png',
                      fit: BoxFit.fitHeight,
                      height: 350,
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 56, bottom: 24),
                            child: Image.asset('assets/logo_color.png',
                                width: 215, fit: BoxFit.fitWidth),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Sapa Masa Depanmu',
                            style: _textTheme.displayLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 8, left: 16, right: 16),
                        child: Text(
                            'Kita percaya masa depan selalu lebih baik, miliki dan mulai sekarang!',
                            style: _textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            Text('Masukkan email aktifmu',
                                style: _textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      decoration: BoxDecoration(
                          color: _themeData.primaryColor,
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          suffixIcon: _emailText.isEmpty
                              ? null
                              : IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _emailController.clear();
                                    });
                                  },
                                ),
                          labelText: 'E-mail',
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
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: Text(
                            'Mulai Sekarang!',
                            style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(size.width * 0.4, 54),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const VerifyEmail(email: "rzr@gmail.com"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 54,
                    ),
                    Column(
                      children: [
                        ScrollViewSignIn(
                          scrollController: _scrollControllerTop,
                          images: movies1,
                        ),
                        ScrollViewSignIn(
                          scrollController: _scrollControllerBottom,
                          images: movies2,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          child: Text(
                            'Sign In Anonymous',
                            style: _textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () async {
                            User? result = await AuthService().signInAnon();
                            if (result == null) {
                              print('error signing in anonymously');
                            } else {
                              print(result);
                            }
                          },
                        ),
                        ElevatedButton(
                          child: Text('Sign In',
                              style: _textTheme.button?.copyWith(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFFFFFF))),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(size.width * 0.9, 54),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              User? result = await AuthService()
                                  .signInEmailPass(
                                      "razor1@gmail.com", "123qwe");
                              if (result == null) {
                                print('error signing in');
                              } else {
                                print(result);
                              }
                            }
                          },
                        ),
                        ElevatedButton(
                          onPressed: () => widget.toggleView,
                          child: Text(
                            'Sign Up',
                            style: _textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
