// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i17;

import '../screens/authentication/authenticate.dart' as _i2;
import '../screens/authentication/confirm_pin.dart' as _i16;
import '../screens/authentication/create_pin.dart' as _i15;
import '../screens/authentication/pin_auth.dart' as _i8;
import '../screens/main/collection.dart' as _i10;
import '../screens/main/collection_review.dart' as _i5;
import '../screens/main/favorite.dart' as _i11;
import '../screens/main/home.dart' as _i9;
import '../screens/main/main_scaffold.dart' as _i1;
import '../screens/main/mint.dart' as _i7;
import '../screens/main/payment_process.dart' as _i14;
import '../screens/main/privacy_policy.dart' as _i4;
import '../screens/main/product_detail.dart' as _i3;
import '../screens/main/profile.dart' as _i12;
import '../screens/main/transaction.dart' as _i13;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i17.GlobalKey<_i17.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainScaffold.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainScaffold());
    },
    Authenticate.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.Authenticate());
    },
    ProductDetail.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductDetailArgs>(
          orElse: () => ProductDetailArgs(
              collectionId: pathParams.getString('collectionId')));
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProductDetail(
              key: args.key, collectionId: args.collectionId));
    },
    PrivacyPolicy.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PrivacyPolicy());
    },
    CollectionReview.name: (routeData) {
      final args = routeData.argsAs<CollectionReviewArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.CollectionReview(
              key: args.key, collectionId: args.collectionId));
    },
    EmptyRouterRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.EmptyRouterPage());
    },
    Mint.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.Mint());
    },
    PinAuth.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.PinAuth());
    },
    HomeRouter.name: (routeData) {
      final args = routeData.argsAs<HomeRouterArgs>(
          orElse: () => const HomeRouterArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.Home(key: args.key));
    },
    CollectionRouter.name: (routeData) {
      final args = routeData.argsAs<CollectionRouterArgs>(
          orElse: () => const CollectionRouterArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i10.Collection(key: args.key));
    },
    FavoriteRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.Favorite());
    },
    TransactionRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.EmptyRouterPage());
    },
    UserRouter.name: (routeData) {
      final args = routeData.argsAs<UserRouterArgs>(
          orElse: () => const UserRouterArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i12.Profile(key: args.key));
    },
    Transaction.name: (routeData) {
      final args = routeData.argsAs<TransactionArgs>(
          orElse: () => const TransactionArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i13.Transaction(key: args.key));
    },
    PaymentProcess.name: (routeData) {
      final args = routeData.argsAs<PaymentProcessArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i14.PaymentProcess(
              key: args.key, transactionId: args.transactionId));
    },
    CreatePin.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.CreatePin());
    },
    ConfirmPin.name: (routeData) {
      final args = routeData.argsAs<ConfirmPinArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i16.ConfirmPin(pin: args.pin, key: args.key));
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(MainScaffold.name, path: '/', children: [
          _i6.RouteConfig(HomeRouter.name, path: '', parent: MainScaffold.name),
          _i6.RouteConfig(CollectionRouter.name,
              path: 'collection', parent: MainScaffold.name),
          _i6.RouteConfig(FavoriteRouter.name,
              path: 'favorite', parent: MainScaffold.name),
          _i6.RouteConfig(TransactionRouter.name,
              path: 'transaction',
              parent: MainScaffold.name,
              children: [
                _i6.RouteConfig(Transaction.name,
                    path: '', parent: TransactionRouter.name),
                _i6.RouteConfig(PaymentProcess.name,
                    path: 'payment_process', parent: TransactionRouter.name)
              ]),
          _i6.RouteConfig(UserRouter.name,
              path: 'user', parent: MainScaffold.name)
        ]),
        _i6.RouteConfig(Authenticate.name, path: '/login'),
        _i6.RouteConfig(ProductDetail.name, path: '/collection/:collectionId'),
        _i6.RouteConfig(PrivacyPolicy.name, path: '/policy'),
        _i6.RouteConfig(CollectionReview.name, path: '/collecion_review'),
        _i6.RouteConfig(EmptyRouterRoute.name, path: '/create_pin', children: [
          _i6.RouteConfig(CreatePin.name,
              path: '', parent: EmptyRouterRoute.name),
          _i6.RouteConfig(ConfirmPin.name,
              path: 'confirmPin', parent: EmptyRouterRoute.name)
        ]),
        _i6.RouteConfig(Mint.name, path: '/mint'),
        _i6.RouteConfig(PinAuth.name, path: '/input_pin'),
        _i6.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.MainScaffold]
class MainScaffold extends _i6.PageRouteInfo<void> {
  const MainScaffold({List<_i6.PageRouteInfo>? children})
      : super(MainScaffold.name, path: '/', initialChildren: children);

  static const String name = 'MainScaffold';
}

/// generated route for
/// [_i2.Authenticate]
class Authenticate extends _i6.PageRouteInfo<void> {
  const Authenticate() : super(Authenticate.name, path: '/login');

  static const String name = 'Authenticate';
}

/// generated route for
/// [_i3.ProductDetail]
class ProductDetail extends _i6.PageRouteInfo<ProductDetailArgs> {
  ProductDetail({_i17.Key? key, required String collectionId})
      : super(ProductDetail.name,
            path: '/collection/:collectionId',
            args: ProductDetailArgs(key: key, collectionId: collectionId),
            rawPathParams: {'collectionId': collectionId});

  static const String name = 'ProductDetail';
}

class ProductDetailArgs {
  const ProductDetailArgs({this.key, required this.collectionId});

  final _i17.Key? key;

  final String collectionId;

  @override
  String toString() {
    return 'ProductDetailArgs{key: $key, collectionId: $collectionId}';
  }
}

/// generated route for
/// [_i4.PrivacyPolicy]
class PrivacyPolicy extends _i6.PageRouteInfo<void> {
  const PrivacyPolicy() : super(PrivacyPolicy.name, path: '/policy');

  static const String name = 'PrivacyPolicy';
}

/// generated route for
/// [_i5.CollectionReview]
class CollectionReview extends _i6.PageRouteInfo<CollectionReviewArgs> {
  CollectionReview({_i17.Key? key, required String collectionId})
      : super(CollectionReview.name,
            path: '/collecion_review',
            args: CollectionReviewArgs(key: key, collectionId: collectionId));

  static const String name = 'CollectionReview';
}

class CollectionReviewArgs {
  const CollectionReviewArgs({this.key, required this.collectionId});

  final _i17.Key? key;

  final String collectionId;

  @override
  String toString() {
    return 'CollectionReviewArgs{key: $key, collectionId: $collectionId}';
  }
}

/// generated route for
/// [_i6.EmptyRouterPage]
class EmptyRouterRoute extends _i6.PageRouteInfo<void> {
  const EmptyRouterRoute({List<_i6.PageRouteInfo>? children})
      : super(EmptyRouterRoute.name,
            path: '/create_pin', initialChildren: children);

  static const String name = 'EmptyRouterRoute';
}

/// generated route for
/// [_i7.Mint]
class Mint extends _i6.PageRouteInfo<void> {
  const Mint() : super(Mint.name, path: '/mint');

  static const String name = 'Mint';
}

/// generated route for
/// [_i8.PinAuth]
class PinAuth extends _i6.PageRouteInfo<void> {
  const PinAuth() : super(PinAuth.name, path: '/input_pin');

  static const String name = 'PinAuth';
}

/// generated route for
/// [_i9.Home]
class HomeRouter extends _i6.PageRouteInfo<HomeRouterArgs> {
  HomeRouter({_i17.Key? key})
      : super(HomeRouter.name, path: '', args: HomeRouterArgs(key: key));

  static const String name = 'HomeRouter';
}

class HomeRouterArgs {
  const HomeRouterArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'HomeRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.Collection]
class CollectionRouter extends _i6.PageRouteInfo<CollectionRouterArgs> {
  CollectionRouter({_i17.Key? key})
      : super(CollectionRouter.name,
            path: 'collection', args: CollectionRouterArgs(key: key));

  static const String name = 'CollectionRouter';
}

class CollectionRouterArgs {
  const CollectionRouterArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'CollectionRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.Favorite]
class FavoriteRouter extends _i6.PageRouteInfo<void> {
  const FavoriteRouter() : super(FavoriteRouter.name, path: 'favorite');

  static const String name = 'FavoriteRouter';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class TransactionRouter extends _i6.PageRouteInfo<void> {
  const TransactionRouter({List<_i6.PageRouteInfo>? children})
      : super(TransactionRouter.name,
            path: 'transaction', initialChildren: children);

  static const String name = 'TransactionRouter';
}

/// generated route for
/// [_i12.Profile]
class UserRouter extends _i6.PageRouteInfo<UserRouterArgs> {
  UserRouter({_i17.Key? key})
      : super(UserRouter.name, path: 'user', args: UserRouterArgs(key: key));

  static const String name = 'UserRouter';
}

class UserRouterArgs {
  const UserRouterArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'UserRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.Transaction]
class Transaction extends _i6.PageRouteInfo<TransactionArgs> {
  Transaction({_i17.Key? key})
      : super(Transaction.name, path: '', args: TransactionArgs(key: key));

  static const String name = 'Transaction';
}

class TransactionArgs {
  const TransactionArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'TransactionArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.PaymentProcess]
class PaymentProcess extends _i6.PageRouteInfo<PaymentProcessArgs> {
  PaymentProcess({_i17.Key? key, required String transactionId})
      : super(PaymentProcess.name,
            path: 'payment_process',
            args: PaymentProcessArgs(key: key, transactionId: transactionId));

  static const String name = 'PaymentProcess';
}

class PaymentProcessArgs {
  const PaymentProcessArgs({this.key, required this.transactionId});

  final _i17.Key? key;

  final String transactionId;

  @override
  String toString() {
    return 'PaymentProcessArgs{key: $key, transactionId: $transactionId}';
  }
}

/// generated route for
/// [_i15.CreatePin]
class CreatePin extends _i6.PageRouteInfo<void> {
  const CreatePin() : super(CreatePin.name, path: '');

  static const String name = 'CreatePin';
}

/// generated route for
/// [_i16.ConfirmPin]
class ConfirmPin extends _i6.PageRouteInfo<ConfirmPinArgs> {
  ConfirmPin({required String pin, _i17.Key? key})
      : super(ConfirmPin.name,
            path: 'confirmPin', args: ConfirmPinArgs(pin: pin, key: key));

  static const String name = 'ConfirmPin';
}

class ConfirmPinArgs {
  const ConfirmPinArgs({required this.pin, this.key});

  final String pin;

  final _i17.Key? key;

  @override
  String toString() {
    return 'ConfirmPinArgs{pin: $pin, key: $key}';
  }
}
