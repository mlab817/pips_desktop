import 'package:flutter/material.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/presentation/auth/login/login.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:realm/realm.dart';

import '../presentation/resources/theme_manager.dart';
import 'dep_injection.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final Realm _realm = instance<Realm>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _realm.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _realm.close();
    }
  }

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
