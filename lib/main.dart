import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pips/app/app.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:universal_io/io.dart';
import 'package:window_size/window_size.dart';

import 'firebase_options.dart';

void main() async {
  // debugPaintSizeEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowTitle(AppStrings.appName);
    setWindowMinSize(const Size(960, 600));
  }

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'my-app',
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (Platform.isAndroid) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      print("is messaging supported: ${await messaging.isSupported()}");

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      final fcmToken = await messaging.getToken().onError((error, stackTrace) {
        print(error.toString());
        return null;
      });

      print("fcmToken $fcmToken");

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(message.toString());
      });
    }
  }

  // initialize dependency injection
  await initAppModule();

  runApp(const MyApp());
}
