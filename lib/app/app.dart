import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/presentation/logout_listener/logout_listener.dart';
import 'package:pips/presentation/main/main.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:pips/presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown
              },
            ),
            theme: ThemeManager.getApplicationTheme(ThemeMode.light),
            darkTheme: ThemeManager.getApplicationTheme(ThemeMode.dark),
            themeMode: currentMode,
            onGenerateRoute: RouteGenerator.onGenerateRoute,
            initialRoute: Routes.splashRoute,
            // Routes.splashRoute
            home: const LogoutListener(
              child: MainView(),
            ),
          );
        });
  }
}
