import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/domain/repository/repository.dart';

void logout(BuildContext context) {
  final Repository repository = instance<Repository>();
  //
  repository.clear();

  resetModules();

  Navigator.pushReplacementNamed(context, Routes.loginRoute);
}
