import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../src/view/auth/login.dart';
import '../../src/view/home/home_page.dart';
import '../../src/view/splash/splash.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginForm();
          },
        ),
      ],
    ),
  ],
);
