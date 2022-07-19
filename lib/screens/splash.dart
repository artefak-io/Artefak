import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveToHome() async {
    await Future.delayed(const Duration(seconds: 5));
    context.router.replaceNamed('/');
  }

  @override
  void initState() {
    super.initState();
    moveToHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Center(
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: -120,
                  top: -10,
                  child: Image.asset('assets/splash_2.png', width: 50)),
              Positioned(
                  bottom: 0,
                  left: -110,
                  right: 0,
                  top: 150,
                  child: Image.asset('assets/splash_1.png', width: 50)),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: SvgPicture.asset(
                  'assets/logo_white.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
