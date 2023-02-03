import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pips/app/app.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:window_size/window_size.dart';

import 'firebase_options.dart';

void main() async {
  // debugPaintSizeEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(AppStrings.appName);
    setWindowMinSize(const Size(960, 600));
  }

  // initialize dependency injection
  await initAppModule();

  // loadDataFromCsv();

  runApp(const MyApp());
}
