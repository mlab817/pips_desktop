import 'package:flutter/cupertino.dart';
import 'package:pips_desktop/presentation/home/home.dart';

import '../presentation/auth/login/login.dart';

class Routes {
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
}

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return CupertinoPageRoute(builder: (_) => const HomeView());
      case Routes.loginRoute:
        return CupertinoPageRoute(builder: (_) => const LoginView());
      default:
        // return null
        return CupertinoPageRoute(builder: (_) => const HomeView());
    }
  }
}