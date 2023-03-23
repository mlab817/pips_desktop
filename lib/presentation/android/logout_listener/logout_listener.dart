import 'package:flutter/material.dart';
import 'package:pips/app/routes.dart';

import '../../../data/network/dio_factory.dart';

class LogoutListener extends StatelessWidget {
  const LogoutListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: eventBus.on<LogoutEvent>(),
      builder: (context, snapshot) {
        debugPrint(snapshot.toString());
        if (snapshot.hasData) {
          debugPrint("eventBus triggered");
          if (snapshot.data?.loggedOut == true) {
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            });
          }
          return Container();
        }
        debugPrint("no eventBus triggered");
        return child;
      },
    );
  }
}
