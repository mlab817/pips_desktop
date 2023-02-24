import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/presentation/logout_listener/logout_listener.dart';
import 'package:pips/presentation/main/main.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
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
      theme: ThemeManager.getApplicationTheme(),
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      initialRoute: Routes.splashRoute,
      // Routes.splashRoute
      home: const LogoutListener(
        child: MainView(),
      ),
    );
  }
}
