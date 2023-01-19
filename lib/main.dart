import 'package:flutter/material.dart';
import 'package:pips_desktop/app/app.dart';
import 'package:pips_desktop/app/dep_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize dependency injection
  await initAppModule();

  runApp(const MyApp());
}
