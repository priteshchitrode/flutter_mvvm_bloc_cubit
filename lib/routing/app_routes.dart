import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/features/home/home_screen.dart';
import 'package:flutter_mvvm_bloc_cubit/features/splash/splash_screen.dart';
import 'package:flutter_mvvm_bloc_cubit/routing/app_route_name.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_global_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/default_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  AppRoutes._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRouteName.splash,
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      // Splash
      GoRoute(
        path: AppRouteName.splash,
        builder: (BuildContext context, GoRouterState state) {
          return SplashScreen();
        },
      ),

      // Home
      GoRoute(
        path: AppRouteName.home,
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
      ),

      // Default Screen
      GoRoute(
        path: AppRouteName.notFound,
        builder: (BuildContext context, GoRouterState state) {
          return const DefaultScreen();
        },
      ),
    ],
  );
}
