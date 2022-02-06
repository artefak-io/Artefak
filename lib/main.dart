import 'package:artefak/screens/authentication/sign_in.dart';
import 'package:artefak/screens/authentication/sign_up.dart';
import 'package:artefak/screens/main/profile.dart';
import 'package:artefak/screens/main/transaction.dart';
import 'package:artefak/screens/main/home.dart';
import 'package:artefak/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red[900],
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        // '/home' still unused, don't route to '/home' yet route to '/' instead
        '/home': (context) => const Home(),
        '/profile': (context) => Profile(),
        '/transaction': (context) => const Transaction(),
        '/signin': (context) => const SignIn(),
        '/signup': (context) => const SignUp(),
      },
      initialRoute: '/',
    );
  }
}
