import 'package:firebase_messaging/firebase_messaging.dart';

class FbMessaging {
  static Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    final String fcmToken = await FirebaseMessaging.instance.getToken() ?? '';

    print("fcmToken: $fcmToken");
  }
}
