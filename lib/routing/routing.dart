import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/features/authentication/presentation/register/sign_up.dart';
import 'package:pips/features/dashboard/data/network/requests/filter_project/filterproject_request.dart';
import 'package:pips/features/dashboard/presentation/views/home.dart';
import 'package:pips/features/office/presentation/views/office.dart';
import 'package:pips/features/onboarding/onboarding.dart';
import 'package:pips/features/project/presentation/views/project.dart';
import 'package:pips/features/project/presentation/views/view_pdf.dart';
import 'package:pips/features/project/presentation/views/view_project.dart';
import 'package:pips/features/settings/settings.dart';
import 'package:pips/features/settings/views/about.dart';
import 'package:pips/features/settings/views/update_profile.dart';
import 'package:pips/features/splash/splash.dart';

import '../features/authentication/presentation/forgot_password/forgot_password.dart';
import '../features/authentication/presentation/login/login.dart';
import '../features/chats/presentation/views/chat_room.dart';
import '../features/dashboard/presentation/views/main.dart';
import '../features/dashboard/presentation/widgets/filter_by_property.dart';
import '../features/dashboard/presentation/widgets/filter_projects.dart';
import '../features/dashboard/presentation/widgets/search_results.dart';
import '../features/main/main.dart';
import '../features/notifications/presentation/notifications.dart';
import '../features/project/domain/models/presets.dart';
import '../features/project/presentation/views/new_pap.dart';
import '../features/settings/views/developer_notice.dart';
import '../features/settings/views/logins.dart';
import '../features/settings/views/update_password.dart';

class Routes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";
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
  static const String filterProjectsRoute = "/filter-projects";
  static const String filterByPropertyRoute = "/filter-by-property";
  static const String settingsRoute = "/settings";
  static const String newPapRoute = "/new-pap";
}

class RouteGenerator {
  static Route<dynamic> onWebGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
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
        initProjectModule();
        return MaterialPageRoute(builder: (_) => const MainWebView());
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
      case Routes.newPapRoute:
        Preset? preset = routeSettings.arguments as Preset?;
        return MaterialPageRoute(builder: (_) => NewPapView(preset: preset));
      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case Routes.updatePasswordRoute:
        return MaterialPageRoute(builder: (_) => const UpdatePassword());
      case Routes.developerNoticeRoute:
        return MaterialPageRoute(builder: (_) => const DeveloperNotice());
      case Routes.activityLogRoute:
        return MaterialPageRoute(builder: (_) => const LoginsView());
      case Routes.updateProfileRoute:
        return MaterialPageRoute(builder: (_) => const UpdateProfileView());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case Routes.viewProjectRoute:
        initProjectModule();
        String uuid = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => ViewProjectView(uuid: uuid));
      case Routes.newProjectRoute:
        return MaterialPageRoute(builder: (_) => const NewPapView());
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
      case Routes.filterProjectsRoute:
        GetProjectsRequest request =
            routeSettings.arguments as GetProjectsRequest;
        return MaterialPageRoute(
            builder: (_) => FilterProjectsView(request: request));
      case Routes.filterByPropertyRoute:
        FilterProjectRequest request =
            routeSettings.arguments as FilterProjectRequest;
        return MaterialPageRoute(
            builder: (_) => FilterByPropertyView(request: request));
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      default:
        // return null
        return MaterialPageRoute(builder: (_) => const MainWebView());
    }
  }

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
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
        return MaterialPageRoute(builder: (_) => const UpdateProfileView());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case Routes.viewProjectRoute:
        initProjectModule();
        String uuid = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => ViewProjectView(uuid: uuid));
      case Routes.newProjectRoute:
        return MaterialPageRoute(builder: (_) => const NewPapView());
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
      case Routes.filterProjectsRoute:
        GetProjectsRequest request =
            routeSettings.arguments as GetProjectsRequest;
        return MaterialPageRoute(
            builder: (_) => FilterProjectsView(request: request));
      case Routes.filterByPropertyRoute:
        FilterProjectRequest request =
            routeSettings.arguments as FilterProjectRequest;
        return MaterialPageRoute(
            builder: (_) => FilterByPropertyView(request: request));
      default:
        // return null
        return MaterialPageRoute(builder: (_) => const HomeView());
    }
  }
}
