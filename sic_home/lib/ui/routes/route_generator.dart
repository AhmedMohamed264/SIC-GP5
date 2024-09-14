import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sic_home/ui/routes/home.dart';
import 'package:sic_home/ui/routes/login.dart';
import 'package:sic_home/ui/routes/register.dart';
import 'package:sic_home/ui/routes/startup.dart';

class RouteGenerator {
  RouteGenerator._();

  static final mainNavigatorkey = GlobalKey<NavigatorState>();
  static final homeNavigatorKey = GlobalKey<NavigatorState>();

  static const startup = "startup";
  static const homePage = "home";
  static const loginPage = "login";
  static const registerPage = "register";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startup:
        return MaterialPageRoute(builder: (_) => const Startup());
      case loginPage:
        return MaterialPageRoute(builder: (_) => Login());
      case registerPage:
        return MaterialPageRoute(builder: (_) => Register());
      case homePage:
        return MaterialPageRoute(builder: (_) => const Home());
      default:
        throw const FormatException("Route not found");
    }
  }

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
