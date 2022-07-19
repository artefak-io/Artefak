// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i18;

import '../screens/authentication/authenticate.dart' as _i3;
import '../screens/authentication/confirm_pin.dart' as _i17;
import '../screens/authentication/create_pin.dart' as _i16;
import '../screens/authentication/pin_auth.dart' as _i10;
import '../screens/main/collection.dart' as _i12;
import '../screens/main/collection_review.dart' as _i6;
import '../screens/main/favorite.dart' as _i13;
import '../screens/main/home.dart' as _i11;
import '../screens/main/main_scaffold.dart' as _i2;
import '../screens/main/mint.dart' as _i9;
import '../screens/main/payment_process.dart' as _i7;
import '../screens/main/privacy_policy.dart' as _i5;
import '../screens/main/product_detail.dart' as _i4;
import '../screens/main/profile.dart' as _i15;
import '../screens/main/transaction.dart' as _i14;
import '../screens/splash.dart' as _i1;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    MainScaffold.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.MainScaffold());
    },
    Authenticate.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.Authenticate());
    },
    ProductDetail.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductDetailArgs>(
          orElse: () =>
              ProductDetailArgs(assetId: pathParams.getString('assetId')));
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.ProductDetail(key: args.key, assetId: args.assetId));
    },
    PrivacyPolicy.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.PrivacyPolicy());
    },
    CollectionReview.name: (routeData) {
      final args = routeData.argsAs<CollectionReviewArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.CollectionReview(
              key: args.key, collectionId: args.collectionId));
    },
    PaymentProcess.name: (routeData) {
      final args = routeData.argsAs<PaymentProcessArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.PaymentProcess(
              key: args.key, transactionId: args.transactionId));
    },
    EmptyRouterRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.EmptyRouterPage());
    },
    Mint.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.Mint());
    },
    PinAuth.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.PinAuth());
    },
    HomeRouter.name: (routeData) {
      final args = routeData.argsAs<HomeRouterArgs>(
          orElse: () => const HomeRouterArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i11.Home(key: args.key));
    },
    CollectionRouter.name: (routeData) {
      final args = routeData.argsAs<CollectionRouterArgs>(
          orElse: () => const CollectionRouterArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i12.Collection(key: args.key));
    },
    FavoriteRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.Favorite());
    },
    TransactionRouter.name: (routeData) {
      final args = routeData.argsAs<TransactionRouterArgs>(
          orElse: () => const TransactionRouterArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i14.Transaction(key: args.key));
    },
    UserRouter.name: (routeData) {
      final args = routeData.argsAs<UserRouterArgs>(
          orElse: () => const UserRouterArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i15.Profile(key: args.key));
    },
    CreatePin.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i16.CreatePin());
    },
    ConfirmPin.name: (routeData) {
      final args = routeData.argsAs<ConfirmPinArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i17.ConfirmPin(pin: args.pin, key: args.key));
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(SplashScreen.name, path: '/'),
        _i8.RouteConfig(MainScaffold.name, path: '/', children: [
          _i8.RouteConfig(HomeRouter.name, path: '', parent: MainScaffold.name),
          _i8.RouteConfig(CollectionRouter.name,
              path: 'collection', parent: MainScaffold.name),
          _i8.RouteConfig(FavoriteRouter.name,
              path: 'favorite', parent: MainScaffold.name),
          _i8.RouteConfig(TransactionRouter.name,
              path: 'transaction', parent: MainScaffold.name),
          _i8.RouteConfig(UserRouter.name,
              path: 'user', parent: MainScaffold.name)
        ]),
        _i8.RouteConfig(Authenticate.name, path: '/login'),
        _i8.RouteConfig(ProductDetail.name, path: '/asset/:assetId'),
        _i8.RouteConfig(PrivacyPolicy.name, path: '/policy'),
        _i8.RouteConfig(CollectionReview.name, path: '/collecion_review'),
        _i8.RouteConfig(PaymentProcess.name, path: '/payment_process'),
        _i8.RouteConfig(EmptyRouterRoute.name, path: '/create_pin', children: [
          _i8.RouteConfig(CreatePin.name,
              path: '', parent: EmptyRouterRoute.name),
          _i8.RouteConfig(ConfirmPin.name,
              path: 'confirmPin', parent: EmptyRouterRoute.name)
        ]),
        _i8.RouteConfig(Mint.name, path: '/mint'),
        _i8.RouteConfig(PinAuth.name, path: '/input_pin'),
        _i8.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreen extends _i8.PageRouteInfo<void> {
  const SplashScreen() : super(SplashScreen.name, path: '/');

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i2.MainScaffold]
class MainScaffold extends _i8.PageRouteInfo<void> {
  const MainScaffold({List<_i8.PageRouteInfo>? children})
      : super(MainScaffold.name, path: '/', initialChildren: children);

  static const String name = 'MainScaffold';
}

/// generated route for
/// [_i3.Authenticate]
class Authenticate extends _i8.PageRouteInfo<void> {
  const Authenticate() : super(Authenticate.name, path: '/login');

  static const String name = 'Authenticate';
}

/// generated route for
/// [_i4.ProductDetail]
class ProductDetail extends _i8.PageRouteInfo<ProductDetailArgs> {
  ProductDetail({_i18.Key? key, required String assetId})
      : super(ProductDetail.name,
            path: '/asset/:assetId',
            args: ProductDetailArgs(key: key, assetId: assetId),
            rawPathParams: {'assetId': assetId});

  static const String name = 'ProductDetail';
}

class ProductDetailArgs {
  const ProductDetailArgs({this.key, required this.assetId});

  final _i18.Key? key;

  final String assetId;

  @override
  String toString() {
    return 'ProductDetailArgs{key: $key, assetId: $assetId}';
  }
}

/// generated route for
/// [_i5.PrivacyPolicy]
class PrivacyPolicy extends _i8.PageRouteInfo<void> {
  const PrivacyPolicy() : super(PrivacyPolicy.name, path: '/policy');

  static const String name = 'PrivacyPolicy';
}

/// generated route for
/// [_i6.CollectionReview]
class CollectionReview extends _i8.PageRouteInfo<CollectionReviewArgs> {
  CollectionReview({_i18.Key? key, required String collectionId})
      : super(CollectionReview.name,
            path: '/collecion_review',
            args: CollectionReviewArgs(key: key, collectionId: collectionId));

  static const String name = 'CollectionReview';
}

class CollectionReviewArgs {
  const CollectionReviewArgs({this.key, required this.collectionId});

  final _i18.Key? key;

  final String collectionId;

  @override
  String toString() {
    return 'CollectionReviewArgs{key: $key, collectionId: $collectionId}';
  }
}

/// generated route for
/// [_i7.PaymentProcess]
class PaymentProcess extends _i8.PageRouteInfo<PaymentProcessArgs> {
  PaymentProcess({_i18.Key? key, required String transactionId})
      : super(PaymentProcess.name,
            path: '/payment_process',
            args: PaymentProcessArgs(key: key, transactionId: transactionId));

  static const String name = 'PaymentProcess';
}

class PaymentProcessArgs {
  const PaymentProcessArgs({this.key, required this.transactionId});

  final _i18.Key? key;

  final String transactionId;

  @override
  String toString() {
    return 'PaymentProcessArgs{key: $key, transactionId: $transactionId}';
  }
}

/// generated route for
/// [_i8.EmptyRouterPage]
class EmptyRouterRoute extends _i8.PageRouteInfo<void> {
  const EmptyRouterRoute({List<_i8.PageRouteInfo>? children})
      : super(EmptyRouterRoute.name,
            path: '/create_pin', initialChildren: children);

  static const String name = 'EmptyRouterRoute';
}

/// generated route for
/// [_i9.Mint]
class Mint extends _i8.PageRouteInfo<void> {
  const Mint() : super(Mint.name, path: '/mint');

  static const String name = 'Mint';
}

/// generated route for
/// [_i10.PinAuth]
class PinAuth extends _i8.PageRouteInfo<void> {
  const PinAuth() : super(PinAuth.name, path: '/input_pin');

  static const String name = 'PinAuth';
}

/// generated route for
/// [_i11.Home]
class HomeRouter extends _i8.PageRouteInfo<HomeRouterArgs> {
  HomeRouter({_i18.Key? key})
      : super(HomeRouter.name, path: '', args: HomeRouterArgs(key: key));

  static const String name = 'HomeRouter';
}

class HomeRouterArgs {
  const HomeRouterArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'HomeRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.Collection]
class CollectionRouter extends _i8.PageRouteInfo<CollectionRouterArgs> {
  CollectionRouter({_i18.Key? key})
      : super(CollectionRouter.name,
            path: 'collection', args: CollectionRouterArgs(key: key));

  static const String name = 'CollectionRouter';
}

class CollectionRouterArgs {
  const CollectionRouterArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'CollectionRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.Favorite]
class FavoriteRouter extends _i8.PageRouteInfo<void> {
  const FavoriteRouter() : super(FavoriteRouter.name, path: 'favorite');

  static const String name = 'FavoriteRouter';
}

/// generated route for
/// [_i14.Transaction]
class TransactionRouter extends _i8.PageRouteInfo<TransactionRouterArgs> {
  TransactionRouter({_i18.Key? key})
      : super(TransactionRouter.name,
            path: 'transaction', args: TransactionRouterArgs(key: key));

  static const String name = 'TransactionRouter';
}

class TransactionRouterArgs {
  const TransactionRouterArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'TransactionRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.Profile]
class UserRouter extends _i8.PageRouteInfo<UserRouterArgs> {
  UserRouter({_i18.Key? key})
      : super(UserRouter.name, path: 'user', args: UserRouterArgs(key: key));

  static const String name = 'UserRouter';
}

class UserRouterArgs {
  const UserRouterArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'UserRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.CreatePin]
class CreatePin extends _i8.PageRouteInfo<void> {
  const CreatePin() : super(CreatePin.name, path: '');

  static const String name = 'CreatePin';
}

/// generated route for
/// [_i17.ConfirmPin]
class ConfirmPin extends _i8.PageRouteInfo<ConfirmPinArgs> {
  ConfirmPin({required String pin, _i18.Key? key})
      : super(ConfirmPin.name,
            path: 'confirmPin', args: ConfirmPinArgs(pin: pin, key: key));

  static const String name = 'ConfirmPin';
}

class ConfirmPinArgs {
  const ConfirmPinArgs({required this.pin, this.key});

  final String pin;

  final _i18.Key? key;

  @override
  String toString() {
    return 'ConfirmPinArgs{pin: $pin, key: $key}';
  }
}
