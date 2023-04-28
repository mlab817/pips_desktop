import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/common/resources/theme_manager.dart';
import 'package:pips/features/authentication/data/providers/auth_provider.dart';
import 'package:pips/features/authentication/presentation/login/login.dart';
import 'package:pips/features/settings/data/providers/theme_provider.dart';
import 'package:pips/routing/routing.dart';

// import 'package:provider/provider.dart';

import '../common/resources/strings_manager.dart';
import '../features/main/main.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final customTheme = ref.watch(customThemeProvider);
    final auth = ref.watch(authState);

    debugPrint(auth.isLoggedIn.toString());

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
      themeMode: customTheme.currentTheme,
      //Provider.of<CustomTheme>(context).currentTheme,
      onGenerateRoute: kIsWeb || Platform.isMacOS || Platform.isWindows
          ? RouteGenerator.onWebGenerateRoute
          : RouteGenerator.onGenerateRoute,
      initialRoute: Routes.splashRoute,
      home: auth.isLoggedIn ? const MainView() : const LoginView(),
    );
  }
}
