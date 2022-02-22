import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/screens/authentication/update_profile.dart';
import 'package:artefak/screens/main/asset.dart';
import 'package:artefak/screens/main/payment.dart';
import 'package:artefak/screens/main/profile.dart';
import 'package:artefak/screens/main/transaction.dart';
import 'package:artefak/screens/main/home.dart';
import 'package:artefak/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('id', ''),
      ],
      routes: {
        '/': (context) => const SplashScreen(),
        // '/home' still unused, don't route to '/home' yet route to '/' instead
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/bill': (context) => Transaction(),
        '/updateProfile': (context) => const UpdateProfile(),
        '/asset': (context) => const Asset(),
        '/auth': (context) => const Authenticate(),
        '/payment': (context) => const Payment(),
      },
      initialRoute: '/',
    );
  }
}
