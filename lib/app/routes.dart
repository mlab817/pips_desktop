import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/presentation/main/dashboard/dashboard.dart';
import 'package:pips/presentation/main/main.dart';
import 'package:pips/presentation/main/settings/screens/about.dart';
import 'package:pips/presentation/new_project/new_project.dart';
import 'package:pips/presentation/onboarding/onboarding.dart';
import 'package:pips/presentation/project/project.dart';
import 'package:pips/presentation/splash/splash.dart';
import 'package:pips/presentation/view_project/view_project.dart';

import '../presentation/auth/forgot_password/forgot_password.dart';
import '../presentation/auth/login/login.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";
  static const String dashboardRoute = "/dashboard";
  static const String loginRoute = "/login";
  static const String forgotPasswordRoute = "/forgot-password";
  static const String mainRoute = "/main";
  static const String projectRoute = "/project";
  static const String aboutRoute = "/about";
  static const String onboardingRoute = "/onboarding";
  static const String viewProjectRoute = "/view-project";
  static const String newProjectRoute = "/new-project";
}

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case Routes.dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initProjectsModule();
        initOfficesModule();
        initUsersModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.projectRoute:
        initProjectModule();
        String uuid = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ProjectView(
                  uuid: uuid,
                ));
      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case Routes.viewProjectRoute:
        String uuid = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => ViewProjectView(uuid: uuid));
      case Routes.newProjectRoute:
        return MaterialPageRoute(builder: (_) => const NewProjectView());
      default:
        // return null
        return MaterialPageRoute(builder: (_) => const DashboardView());
    }
  }
}
