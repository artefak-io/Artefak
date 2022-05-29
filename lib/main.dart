import 'package:artefak/screens/main/collection_review.dart';
import 'package:artefak/themes/artefak_theme.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/screens/authentication/update_profile.dart';
import 'package:artefak/screens/main/product_detail.dart';
import 'package:artefak/screens/main/mint.dart';
import 'package:artefak/screens/main/payment.dart';
import 'package:artefak/screens/main/profile.dart';
import 'package:artefak/screens/main/transaction.dart';
import 'package:artefak/screens/main/home.dart';
import 'package:artefak/screens/splash.dart';
import 'package:artefak/themes/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return MaterialApp(
            theme: lightTheme,
            themeMode: _themeManager.themeMode,
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
              '/': (context) => Home(),
              '/home': (context) => Home(),
              '/profile': (context) => Profile(),
              '/bill': (context) => Transaction(),
              '/update_profile': (context) => const UpdateProfile(),
              '/asset/product_detail': (context) => ProductDetail(),
              '/asset/product_detail/collection_review': (context) =>
                  CollectionReview(),
              '/auth': (context) => const Authenticate(),
              '/payment': (context) => const Payment(),
              '/mint': (context) => const Mint(),
            },
            initialRoute: '/',
          );
        }
      },
    );
  }
}
