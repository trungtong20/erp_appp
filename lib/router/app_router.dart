import 'dart:async';

import 'package:erp_appp/core/utils/navigation_service.dart';
import 'package:erp_appp/cubit/auth/auth_cubit.dart';
import 'package:erp_appp/router/user_role.dart';
import 'package:erp_appp/ui/screens/admin/admin_home_page.dart';
import 'package:erp_appp/ui/screens/home/home.dart';
import 'package:erp_appp/ui/screens/login/login.dart';
import 'package:erp_appp/ui/screens/user/user_home_screen.dart';
import 'package:erp_appp/ui/screens/vendor/vendor_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class RouteUri {
  static const String splash = '/';
  static const String login = '/login';
  static const String logout = '/logout';
  static const String home = '/home';
  static const String admin = '/admin';
  static const String vendor = '/vendor';
  static const String userHome = '/userHome';
}

class AppRouter {
  final AuthCubit authCubit;

  AppRouter(this.authCubit);

  late final GoRouter router = GoRouter(
    navigatorKey: GetIt.instance<NavigationService>().navigatorKey,
    routerNeglect: true,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const SizedBox(),
    routes: <GoRoute>[
      GoRoute(
        path: RouteUri.splash,
        redirect: (_, state) => RouteUri.home,
      ),
      GoRoute(
        path: RouteUri.login,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.home,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.admin,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const AdminHomePage(),
        ),
      ),
      GoRoute(
        path: RouteUri.vendor,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const VendorMainPage(),
        ),
      ),
      GoRoute(
        path: RouteUri.userHome,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const UserHomeScreen(),
        ),
      ),
    ],
redirect: (_, state) {
  final isLogin = authCubit.state.isLogin;
  final role = authCubit.state.userRole;
  final isOnLoginPage = state.matchedLocation == RouteUri.login;
  final isOnSplash = state.matchedLocation == RouteUri.splash;

  if (!isLogin) return isOnLoginPage ? null : RouteUri.login;

  // Nếu ở Splash, chuyển hướng theo role
  if (isOnSplash) {
    switch (role) {
      case UserRole.admin:
        return RouteUri.admin;
      case UserRole.vendor:
        return RouteUri.vendor;
      case UserRole.user:
      default:
        return RouteUri.userHome;
    }
  }

  return null;
},

    refreshListenable: GoRouterRefreshSteram(authCubit.stream),
  );
}

class GoRouterRefreshSteram extends ChangeNotifier {
  GoRouterRefreshSteram(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
