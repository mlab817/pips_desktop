import 'package:flutter/material.dart';
import 'package:pips/app/functions.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/presentation/main/settings/screens/about.dart';
import 'package:pips/presentation/main/settings/screens/developer_notice.dart';
import 'package:pips/presentation/main/settings/screens/logins.dart';
import 'package:pips/presentation/main/settings/screens/notifications.dart';
import 'package:pips/presentation/main/settings/screens/update_password.dart';
import 'package:pips/presentation/main/settings/screens/update_profile.dart';
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
  final Repository _repository = instance<Repository>();

  int? _selectedIndex;

  final List<Widget> _children = <Widget>[
    const UpdateProfileView(),
    const UpdatePassword(),
    const NotificationsView(),
    const LoginsView(),
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
      title: AppStrings.logins,
      icon: const Icon(Icons.format_list_numbered),
      route: Routes.activityLogRoute,
    ),
    SettingsMenu(
      title: AppStrings.settings,
      icon: const Icon(Icons.settings),
      route: Routes.notificationRoute,
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
        body: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _listMenu.length,
            itemBuilder: (context, index) {
              return ListTile(
                selected: _selectedIndex == index,
                leading: _listMenu[index].icon,
                title: Text(_listMenu[index].title),
                onTap: () {
                  Navigator.pushNamed(context, _listMenu[index].route);
                },
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              logout(context);
            },
            child: const Text(AppStrings.logout),
          )
        ]));
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
