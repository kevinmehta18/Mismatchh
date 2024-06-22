import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mismatchh/main.dart';

import 'app_router.dart';

class RouteTransitions {
  // Global navigator key

  // Navigate using the global navigator key
  static void navigateToGlobal(Widget page,
      {Duration duration = kThemeAnimationDuration,
      SharedAxisTransitionType transitionType =
          SharedAxisTransitionType.horizontal}) {
    // Check if the top of the navigation stack is the same as the desired page
    if (!isCurrentRoute(page.runtimeType.toString())) {
      navigatorKey.currentState?.push(
        PageRouteBuilder(
          settings: RouteSettings(name: page.runtimeType.toString()),
          transitionDuration: duration,
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: transitionType,
              child: child,
            );
          },
        ),
      );
    }
  }

  // Navigate to a new route and remove all previous routes
  static void navigateAndRemoveUntilGlobal(Widget page, String routeName) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      PageRouteBuilder(
        settings: RouteSettings(name: page.runtimeType.toString()),
        transitionDuration: const Duration(seconds: 1),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => route.settings.name == routeName,
    );
  }

  // Check if the current top route matches a specific route
  static bool isCurrentRoute(String routeName) {
    var currentRoute = navigatorKey.currentState?.overlay?.context;
    if (currentRoute != null) {
      var route = ModalRoute.of(currentRoute);
      if (route?.settings.name == routeName) {
        return true;
      }
    }
    return false;
  }

  static void navigateTo(BuildContext context, Widget page,
      {int? duration, SharedAxisTransitionType? transitionType}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: duration ?? 1000),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType:
                transitionType ?? SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
      ),
    );
  }

  static void navigateAndRemoveUntil(
      BuildContext context, Widget page, String routeName) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => route.settings.name == routeName,
    );
  }
}
