import 'package:artefak/screens/app_layout.dart';
import 'package:artefak/screens/authentication/verify_email.dart';
import 'package:artefak/services/auth.dart';
import 'package:artefak/widgets/scroll_view_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final ScrollController _scrollController = ScrollController();
  String _emailText = "";

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  List movies1 = ['image-1.png', 'image-2.png', 'image-3.png'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      double minScrollExtent1 = _scrollController.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController.position.maxScrollExtent;
      //
      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 25,
          _scrollController);
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
        appBar: AppBar(
          title: const Text('Masuk'),
        ),
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
                                left: 16, top: 60, bottom: 40),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Sapa Masa Depanmu',
                            style: _textTheme.headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Text(
                            'Kita percaya masa depan selalu lebih baik, miliki dan mulai sekarang!',
                            style: _textTheme.displaySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 18),
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
                              border:
                                  Border.all(width: 1, color: Colors.black26),
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
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: Text(
                                'Mulai Sekarang!',
                                style: _textTheme.labelMedium?.copyWith(
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
                                    builder: (context) => const VerifyEmail(
                                        email: "rzr@gmail.com"),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: [
                            ScrollViewSignIn(
                              scrollController: _scrollController,
                              images: movies1,
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
          ],
        ),
      ),
    );
  }
}
