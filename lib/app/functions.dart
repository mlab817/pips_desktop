import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/routing/routing.dart';
import 'package:pips/common/domain/repository/repository.dart';

void logout(BuildContext context) {
  final Repository repository = instance<Repository>();
  //
  repository.clear();

  resetModules();

  Navigator.pushReplacementNamed(context, Routes.loginRoute);
}

String formatDate(String date) {
  DateTime now = DateTime.now();

  var parsedDate = DateTime.parse(date);

  // date is within the 24 hrs
  if (parsedDate.year == now.year &&
      parsedDate.month == now.month &&
      parsedDate.day == now.day) {
    return DateFormat.jm().format(parsedDate);
  }

  return DateFormat.yMMMd().format(parsedDate);
}
