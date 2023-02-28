import 'package:flutter/material.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/app/routes.dart';

void logout(BuildContext context) {
  final AppPreferences appPreferences = instance<AppPreferences>();
  //
  appPreferences.clear();
  
  resetModules();

  Navigator.pushReplacementNamed(context, Routes.loginRoute);
}
