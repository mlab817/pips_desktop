import 'package:flutter/material.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/presentation/main/settings/screens/about.dart';
import 'package:pips/presentation/main/settings/screens/activity_logs.dart';
import 'package:pips/presentation/main/settings/screens/developer_notice.dart';
import 'package:pips/presentation/main/settings/screens/notifications.dart';
import 'package:pips/presentation/main/settings/screens/update_password.dart';
import 'package:pips/presentation/main/settings/screens/update_profile.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../app/dep_injection.dart';
import '../../../app/routes.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  int? _selectedIndex;

  final List<Widget> _children = <Widget>[
    const UpdateProfile(),
    const UpdatePassword(),
    const NotificationsView(),
    const ActivityLogView(),
    const DeveloperNotice(),
    const AboutView(),
  ];

  final _listMenu = <SettingsMenu>[
    SettingsMenu(
      title: AppStrings.updateProfile,
      icon: const Icon(Icons.person),
      route: Routes.updateProfileRoute,
    ),
    SettingsMenu(
      title: AppStrings.updatePassword,
      icon: const Icon(Icons.key),
      route: Routes.updatePasswordRoute,
    ),
    SettingsMenu(
      title: AppStrings.notifications,
      icon: const Icon(Icons.notifications),
      route: Routes.notificationRoute,
    ),
    SettingsMenu(
      title: AppStrings.activityLogs,
      icon: const Icon(Icons.format_list_numbered),
      route: Routes.activityLogRoute,
    ),
    SettingsMenu(
      title: AppStrings.developerNotice,
      icon: const Icon(Icons.document_scanner),
      route: Routes.developerNoticeRoute,
    ),
    SettingsMenu(
      title: AppStrings.about,
      icon: const Icon(Icons.info_outline),
      route: Routes.aboutRoute,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _selectedIndex = UniversalPlatform.isDesktopOrWeb ? 0 : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
        automaticallyImplyLeading: false,
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    // color: ColorManager.darkGray,
                    width: AppSize.s0_5,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _listMenu.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          selected: _selectedIndex == index,
                          leading: _listMenu[index].icon,
                          title: Text(_listMenu[index].title),
                          onTap: () {
                            if (UniversalPlatform.isDesktopOrWeb) {
                              setState(
                                () {
                                  _selectedIndex = index;
                                },
                              );
                            } else {
                              Navigator.pushNamed(
                                  context, _listMenu[index].route);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (UniversalPlatform.isDesktopOrWeb)
            Expanded(
              flex: 3,
              child: _children[_selectedIndex!],
            ),
        ],
      ),
    );
  }
}

class SettingsMenu {
  String title;

  Icon icon;

  String route;

  SettingsMenu({
    required this.title,
    required this.icon,
    required this.route,
  });
}
