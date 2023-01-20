import 'package:flutter/material.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/presentation/auth/login/login.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeManager.getApplicationTheme(),
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      initialRoute: Routes.splashRoute,
      home: const LoginView(),
    );
  }
}
