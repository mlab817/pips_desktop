import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  int? notifications;

  void setNotifications(int count) {
    notifications = count;

    notifyListeners();
  }
}