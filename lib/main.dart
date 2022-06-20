import 'package:artefak/logic/auth/auth.dart';
import 'package:artefak/logic/bloc_observer.dart';
import 'package:artefak/screens/main/collection.dart';
import 'package:artefak/screens/main/collection_review.dart';
import 'package:artefak/screens/main/payment_process.dart';
import 'package:artefak/screens/main/privacy_policy.dart';
import 'package:artefak/themes/artefak_theme.dart';
import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/screens/authentication/update_profile.dart';
import 'package:artefak/screens/main/product_detail.dart';
import 'package:artefak/screens/main/mint.dart';
import 'package:artefak/screens/main/payment.dart';
import 'package:artefak/screens/main/transaction.dart';
import 'package:artefak/screens/main/home.dart';
import 'package:artefak/screens/splash.dart';
import 'package:artefak/themes/theme_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(const MyApp());
    },
    blocObserver: AppBlocObserver(),
  );
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _firebaseAuth,
        ),
        RepositoryProvider(
          create: (_) => AuthenticationRepository(_firebaseAuth),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocProvider(
          create: (_) => AuthBloc(context.read<AuthenticationRepository>()),
          lazy: false,
          child: FutureBuilder(
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
                    '/profile': (context) => const ProfileWrapper(),
                    '/collection': (context) => Collection(),
                    '/transaction': (context) => TransactionWrapper(),
                    '/updateProfile': (context) => const UpdateProfile(),
                    '/asset/product_detail': (context) => ProductDetail(),
                    '/asset/product_detail/collection_review': (context) =>
                        CollectionReview(),
                    '/asset/product_detail/payment_process': (context) =>
                        PaymentProcess(),
                    '/auth': (context) => const Authenticate(),
                    '/payment': (context) => const Payment(),
                    '/mint': (context) => const Mint(),
                    '/policy': (context) => const PrivacyPolicy(),
                  },
                  initialRoute: '/',
                );
              }
            },
          ),
        );
      }),
    );
  }
}
