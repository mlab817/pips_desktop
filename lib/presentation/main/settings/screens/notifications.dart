import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../resources/strings_manager.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !UniversalPlatform.isDesktopOrWeb
          ? AppBar(
              title: const Text(AppStrings.notifications),
            )
          : null,
      body: ListView(
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
              subtitle: const Text('For mobile only'),
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
    );
  }
}
