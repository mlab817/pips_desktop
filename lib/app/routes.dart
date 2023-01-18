import 'package:flutter/cupertino.dart';
import 'package:pips_desktop/presentation/home/home.dart';

class Routes {
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return CupertinoPageRoute(builder: (_) => const HomeView());

      default:
        // return null
        return CupertinoPageRoute(builder: (_) => const HomeView());
    }
  }
}