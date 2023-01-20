import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pips/app/app.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(AppStrings.appName);
    setWindowMinSize(const Size(960, 600));
  }

  // initialize dependency injection
  await initAppModule();

  runApp(const MyApp());
}
