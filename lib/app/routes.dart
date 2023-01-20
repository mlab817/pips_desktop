import 'package:flutter/material.dart';
import 'package:pips/presentation/about/about.dart';
import 'package:pips/presentation/main/home/home.dart';
import 'package:pips/presentation/main/main.dart';
import 'package:pips/presentation/splash/splash.dart';

import '../presentation/auth/forgot_password/forgot_password.dart';
import '../presentation/auth/login/login.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String forgotPasswordRoute = "/forgot-password";
  static const String mainRoute = "/main";
  static const String aboutRoute = "/about";
}

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutView());
      default:
        // return null
        return MaterialPageRoute(builder: (_) => const HomeView());
    }
  }
}
