import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pips/common/domain/repository/repository.dart';
import 'package:pips/common/resources/sizes_manager.dart';
import 'package:pips/common/resources/strings_manager.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../app/dep_injection.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final Repository _repository = instance<Repository>();

  bool? _notificationsEnabled;
  bool? _isOnboardingScreenViewable;

  Future<void> _toggleOnboardingScreen(bool value) async {
    // Update shared preferences value here
    await _repository.setIsOnboardingScreenViewed(value);

    setState(() {
      _isOnboardingScreenViewable = value;
    });
  }

  Future<void> _requestNotificationPermission() async {
    print("Prompting for Permission");
    final permitted =
        await OneSignal.shared.promptUserForPushNotificationPermission();

    setState(() {
      _notificationsEnabled = permitted;
    });
  }

  @override
  void initState() {
    super.initState();

    _repository.getIsOnboardingScreenViewed().then((value) {
      setState(() {
        _isOnboardingScreenViewable = value;
      });
    });

    _requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !UniversalPlatform.isDesktopOrWeb,
        title: const Text(AppStrings.settings),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.md),
            child: ListTile(
              dense: false,
              onTap: () {
                _toggleOnboardingScreen(
                    !(_isOnboardingScreenViewable ?? false));
              },
              title: const Text(AppStrings.showOnboardingScreen),
              subtitle:
                  const Text(AppStrings.showOnboardingScreenWhenAppStarts),
              trailing: Switch(
                value: _isOnboardingScreenViewable ?? false,
                onChanged: _toggleOnboardingScreen,
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).dividerColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.md),
            child: ListTile(
              dense: false,
              onTap: () {
                setState(() {
                  _notificationsEnabled = _notificationsEnabled ?? false;
                });
              },
              title: const Text(AppStrings.enableNotifications),
              subtitle: const Text('Supported for Android only'),
              trailing: Switch(
                value: _notificationsEnabled ?? false,
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
