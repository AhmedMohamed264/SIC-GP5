import 'dart:ui';

import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();

  static final mainNavigatorkey = GlobalKey<NavigatorState>();
  static final homeNavigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        throw const FormatException("Route not found");
    }
  }

  // Create a sliding route
  static PageRouteBuilder slidingRoute(Widget route) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1, 0);
        var tween = Tween(begin: begin, end: Offset.zero).chain(
          CurveTween(curve: Curves.ease),
        );

        var blurTween = Tween(begin: 0.0, end: 15.0)
            .animate(CurvedAnimation(parent: animation, curve: Curves.ease));
        return AnimatedBuilder(
          animation: blurTween,
          builder: (context, child2) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurTween.value,
                sigmaY: blurTween.value,
              ),
              child: FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
