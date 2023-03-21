import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/presentation/chat_room/chat_room.dart';
import 'package:pips/presentation/main/dashboard/dashboard.dart';
import 'package:pips/presentation/main/main.dart';
import 'package:pips/presentation/main/office/office.dart';
import 'package:pips/presentation/main/search_results/search_results.dart';
import 'package:pips/presentation/main/settings/screens/about.dart';
import 'package:pips/presentation/main/settings/screens/developer_notice.dart';
import 'package:pips/presentation/main/settings/screens/logins.dart';
import 'package:pips/presentation/main/settings/screens/notifications.dart';
import 'package:pips/presentation/main/settings/screens/update_password.dart';
import 'package:pips/presentation/main/settings/screens/update_profile.dart';
import 'package:pips/presentation/new_project/new_project.dart';
import 'package:pips/presentation/onboarding/onboarding.dart';
import 'package:pips/presentation/project/project.dart';
import 'package:pips/presentation/sign_up/sign_up.dart';
import 'package:pips/presentation/splash/splash.dart';
import 'package:pips/presentation/view_pdf/view_pdf.dart';
import 'package:pips/presentation/view_project/view_project.dart';

import '../presentation/forgot_password/forgot_password.dart';
import '../presentation/login/login.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";
  static const String dashboardRoute = "/dashboard";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/sign-up";
  static const String forgotPasswordRoute = "/forgot-password";
  static const String mainRoute = "/main";
  static const String projectRoute = "/project";
  static const String aboutRoute = "/about";
  static const String onboardingRoute = "/onboarding";
  static const String viewProjectRoute = "/view-project";
  static const String newProjectRoute = "/new-project";
  static const String officeRoute = "/office";
  static const String updateProfileRoute = "/update-profile";
  static const String updatePasswordRoute = "/update-password";
  static const String notificationRoute = "/notification";
  static const String activityLogRoute = "/activity-log";
  static const String developerNoticeRoute = "/developer-notice";
  static const String searchResultsPageRoute = "/search-results";
  static const String viewPdfRoute = "/view-pdf";
  static const String chatRoomRoute = "/chat-room";
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
      case Routes.signUpRoute:
        initSignUpModule();
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initProjectsModule();
        initOfficesModule();
        initUsersModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.officeRoute:
        initOfficesModule();
        String officeId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => OfficeView(officeId: officeId));
      case Routes.projectRoute:
        initProjectModule();
        String uuid = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ProjectView(
                  uuid: uuid,
                ));
      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case Routes.updatePasswordRoute:
        return MaterialPageRoute(builder: (_) => const UpdatePassword());
      case Routes.developerNoticeRoute:
        return MaterialPageRoute(builder: (_) => const DeveloperNotice());
      case Routes.activityLogRoute:
        return MaterialPageRoute(builder: (_) => const LoginsView());
      case Routes.updateProfileRoute:
        return MaterialPageRoute(builder: (_) => const UpdateProfile());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case Routes.viewProjectRoute:
        initProjectModule();
        String uuid = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => ViewProjectView(uuid: uuid));
      case Routes.newProjectRoute:
        return MaterialPageRoute(builder: (_) => const NewProjectView());
      case Routes.searchResultsPageRoute:
        String query = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => SearchResultsPage(query: query));
      case Routes.viewPdfRoute:
        String uuid = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => ViewPdfView(uuid: uuid));
      case Routes.chatRoomRoute:
        Object user = routeSettings.arguments as Object;
        return MaterialPageRoute(builder: (_) => ChatRoomView(user: user));
      default:
        // return null
        return MaterialPageRoute(builder: (_) => const DashboardView());
    }
  }
}
