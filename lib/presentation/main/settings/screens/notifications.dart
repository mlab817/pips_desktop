import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

import '../../../resources/strings_manager.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text(AppStrings.notifications),
          automaticallyImplyLeading: false,
          centerTitle: false,
        ),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.md),
                child: ListTile(
                  dense: false,
                  onTap: () {
                    setState(() {
                      _notificationsEnabled = !_notificationsEnabled;
                    });
                  },
                  title: const Text(AppStrings.enableNotifications),
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (bool? value) {
                      setState(() {
                        _notificationsEnabled = value ?? false;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
