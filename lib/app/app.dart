import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:pips/presentation/resources/theme_manager.dart';
import 'package:provider/provider.dart';

import '../presentation/logout_listener/logout_listener.dart';
import '../presentation/main/main.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomTheme>(
      builder: (BuildContext context, customTheme, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
              PointerDeviceKind.trackpad,
            },
          ),
          theme: CustomTheme.lightTheme,
          // ThemeManager.getApplicationTheme(context, ThemeMode.light),
          darkTheme: CustomTheme.darkTheme,
          // ThemeManager.getApplicationTheme(context, ThemeMode.dark),
          themeMode: Provider.of<CustomTheme>(context).currentTheme,
          // currentTheme.currentTheme,
          onGenerateRoute: RouteGenerator.onGenerateRoute,
          initialRoute: Routes.splashRoute,
          // Routes.splashRoute
          home: const LogoutListener(
            child: MainView(),
          ),
        );
      },
    );
  }
}
