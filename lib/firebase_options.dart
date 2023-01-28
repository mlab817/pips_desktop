// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBFHcJusZVvH6AKWFclOMa5m6OlQbzZOvM',
    appId: '1:3358513712:web:27b7ee21212a7d3a29abf5',
    messagingSenderId: '3358513712',
    projectId: 'pips-mobile',
    authDomain: 'pips-mobile.firebaseapp.com',
    storageBucket: 'pips-mobile.appspot.com',
    measurementId: 'G-EVCN16D45C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzqU0baahJdTFTmudUI4dro_6NjxKfB6o',
    appId: '1:3358513712:android:59ba247ef51d862029abf5',
    messagingSenderId: '3358513712',
    projectId: 'pips-mobile',
    storageBucket: 'pips-mobile.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_9Ei3lc703Ma_SSNPgUYkB--W632yCAk',
    appId: '1:3358513712:ios:40b02cb86d5a064a29abf5',
    messagingSenderId: '3358513712',
    projectId: 'pips-mobile',
    storageBucket: 'pips-mobile.appspot.com',
    iosClientId: '3358513712-73e4ghfoarspd45fpse1n59sdmh36a9v.apps.googleusercontent.com',
    iosBundleId: 'com.example.pipsDesktop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_9Ei3lc703Ma_SSNPgUYkB--W632yCAk',
    appId: '1:3358513712:ios:f3eb2ccdca5cba2129abf5',
    messagingSenderId: '3358513712',
    projectId: 'pips-mobile',
    storageBucket: 'pips-mobile.appspot.com',
    iosClientId: '3358513712-esi1tcd05f0eqp0okru3os4kus7gfnvt.apps.googleusercontent.com',
    iosBundleId: 'com.mlab817.pipsDesktop',
  );
}
