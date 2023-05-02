import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/common/resources/theme_manager.dart';
import 'package:pips/features/main/main.dart';

// import 'package:provider/provider.dart';

import '../common/resources/strings_manager.dart';
import '../features/authentication/data/providers/auth_provider.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    // final customTheme = ref.watch(customThemeProvider);
    final auth = ref.watch(authStateProvider);

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
      // themeMode: customTheme.currentTheme,
      //Provider.of<CustomTheme>(context).currentTheme,
      // onGenerateRoute: kIsWeb || Platform.isMacOS || Platform.isWindows
      //     ? RouteGenerator.onWebGenerateRoute
      //     : RouteGenerator.onGenerateRoute,
      // initialRoute: Routes.splashRoute,
      // home: auth.isLoggedIn ? const MainView() : const LoginView(),
      home: const MainView(),
    );
  }
}
