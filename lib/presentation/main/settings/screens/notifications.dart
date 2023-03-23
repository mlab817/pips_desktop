import 'package:flutter/material.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../../app/dep_injection.dart';
import '../../../resources/strings_manager.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final Repository _repository = instance<Repository>();

  bool _notificationsEnabled = false;
  bool? _isOnboardingScreenViewable;

  Future<void> _toggleOnboardingScreen(bool value) async {
    // Update shared preferences value here
    await _repository.setIsOnboardingScreenViewed(value);

    setState(() {
      _isOnboardingScreenViewable = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _repository.getIsOnboardingScreenViewed().then((value) {
      setState(() {
        _isOnboardingScreenViewable = value;
      });
    });
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
