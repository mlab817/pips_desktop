import 'dart:io';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pips/app/app.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:pips/presentation/resources/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_size/window_size.dart';

import 'firebase_options.dart';

void main(List<String> args) async {
  // debugPaintSizeEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  if (runWebViewTitleBarWidget(args)) {
    return;
  }

  if (UniversalPlatform.isDesktop) {
    setWindowTitle(AppStrings.appName);
    setWindowMinSize(const Size(960, 600));
  }

  // override for bad certificate
  HttpOverrides.global = MyHttpOverrides();

  if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    await Firebase.initializeApp(
      name: 'default',
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    //
    // print("is messaging supported: ${await messaging.isSupported()}");
    //
    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );
    //
    // final fcmToken = await messaging.getToken().onError((error, stackTrace) {
    //   print(error.toString());
    //   return null;
    // });
    //
    // print("fcmToken $fcmToken");
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print(message.toString());
    // });
  }

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.landscapeRight]);

  // initialize dependency injection
  await initAppModule();

  runApp(
    ChangeNotifierProvider(
      create: (_) => CustomTheme(),
      child: const MyApp(),
    ),
  );
}

// override for bad certificate
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
  }
}
