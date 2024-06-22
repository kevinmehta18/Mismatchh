import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/navigation/routes.dart';
import 'package:mismatchh/presentation/views/auth/login_screen.dart';
import 'package:mismatchh/presentation/views/dashboard/home_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: homeRoute,
  routes: [
    GoRoute(
        path: homeRoute,
        builder: (context, state) => const HomeScreen(),
        pageBuilder: (ctx, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: kNavigationDuration,
            reverseTransitionDuration: kNavigationDuration,
            child: const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeIn).animate(animation),
                child: child,
              );
            },
          );
        }),

    GoRoute(
      path: loginRoute,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
