import 'package:flutter/material.dart';

class LogoutNotifier with ChangeNotifier {
  bool hasLoggedOut = false;

  //
  void logout() {
    //
    hasLoggedOut = true;

    notifyListeners();
  }
}
