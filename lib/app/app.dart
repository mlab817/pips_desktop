import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/presentation/mobile/login/login.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:pips/presentation/resources/theme_manager.dart';
import 'package:provider/provider.dart';

import '../presentation/main/main.dart';
import 'dep_injection.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Repository _repository = instance<Repository>();
  bool _isUserLoggedIn = false;

  Future<void> _getIsUserLoggedIn() async {
    final isUserLoggedIn = await _repository.getIsUserLoggedIn();

    if (!mounted) return;

    setState(() {
      _isUserLoggedIn = isUserLoggedIn;
    });
  }

  @override
  void initState() {
    super.initState();

    _getIsUserLoggedIn();
  }

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
          darkTheme: CustomTheme.darkTheme,
          themeMode: Provider.of<CustomTheme>(context).currentTheme,
          onGenerateRoute: kIsWeb || Platform.isMacOS || Platform.isWindows
              ? RouteGenerator.onWebGenerateRoute
              : RouteGenerator.onGenerateRoute,
          initialRoute: Routes.splashRoute,
          home: _isUserLoggedIn ? const MainView() : const LoginView(),
        );
      },
    );
  }
}
