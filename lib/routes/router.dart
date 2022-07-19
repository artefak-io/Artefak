import 'package:artefak/screens/authentication/authenticate.dart';
import 'package:artefak/screens/authentication/confirm_pin.dart';
import 'package:artefak/screens/authentication/create_pin.dart';
import 'package:artefak/screens/authentication/pin_auth.dart';
import 'package:artefak/screens/main/collection.dart';
import 'package:artefak/screens/main/collection_review.dart';
import 'package:artefak/screens/main/favorite.dart';
import 'package:artefak/screens/main/home.dart';
import 'package:artefak/screens/main/main_scaffold.dart';
import 'package:artefak/screens/main/mint.dart';
import 'package:artefak/screens/main/payment_process.dart';
import 'package:artefak/screens/main/privacy_policy.dart';
import 'package:artefak/screens/main/product_detail.dart';
import 'package:artefak/screens/main/profile.dart';
import 'package:artefak/screens/main/transaction.dart';
import 'package:artefak/screens/splash.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: SplashScreen, initial: true),
  AutoRoute(path: '/', page: MainScaffold, children: [
    AutoRoute(path: '', page: Home, name: 'HomeRouter'),
    AutoRoute(path: 'collection', page: Collection, name: 'CollectionRouter'),
    AutoRoute(path: 'favorite', page: Favorite, name: 'FavoriteRouter'),
    AutoRoute(
        path: 'transaction', page: Transaction, name: 'TransactionRouter'),
    AutoRoute(path: 'user', page: Profile, name: 'UserRouter'),
  ]),
  AutoRoute(path: '/login', page: Authenticate),
  AutoRoute(path: '/asset/:assetId', page: ProductDetail),
  AutoRoute(path: '/policy', page: PrivacyPolicy),
  AutoRoute(path: '/collecion_review', page: CollectionReview),
  AutoRoute(path: '/payment_process', page: PaymentProcess),
  AutoRoute(path: '/create_pin', page: EmptyRouterPage, children: [
    AutoRoute(path: '', page: CreatePin),
    AutoRoute(path: 'confirmPin', page: ConfirmPin),
  ]),
  AutoRoute(path: '/mint', page: Mint),
  AutoRoute(path: '/input_pin', page: PinAuth),
  RedirectRoute(path: '*', redirectTo: '/'),
])
class $AppRouter {}
