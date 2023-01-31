import 'package:flutter/material.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/data/providers/logout_notifier.dart';
import 'package:provider/provider.dart';

class LogoutListener extends StatelessWidget {
  const LogoutListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<LogoutNotifier>(builder: (context, notifier, _) {
      //
      if (notifier.hasLoggedOut) {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
        return Container();
      }

      return child;
    });
  }
}
