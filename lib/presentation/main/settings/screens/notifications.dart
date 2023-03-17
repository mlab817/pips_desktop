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
      appBar: AppBar(
        automaticallyImplyLeading: !UniversalPlatform.isDesktopOrWeb,
        title: const Text(AppStrings.notifications),
      ),
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
              subtitle: const Text('Supported for Android only'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (bool? value) {
                  // TODO: make sure that this is handled by the device
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
