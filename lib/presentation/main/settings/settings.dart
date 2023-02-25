import 'package:flutter/material.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/presentation/main/settings/screens/about.dart';
import 'package:pips/presentation/main/settings/screens/activity_logs.dart';
import 'package:pips/presentation/main/settings/screens/developer_notice.dart';
import 'package:pips/presentation/main/settings/screens/notifications.dart';
import 'package:pips/presentation/main/settings/screens/update_password.dart';
import 'package:pips/presentation/main/settings/screens/update_profile.dart';
import 'package:pips/presentation/resources/color_schemes.g.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../../../app/dep_injection.dart';
import '../../../app/routes.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  int _selectedIndex = 0;

  final List<Widget> _children = <Widget>[
    const UpdateProfile(),
    const UpdatePassword(),
    const Notifications(),
    const ActivityLogView(),
    const DeveloperNotice(),
    const AboutView(),
  ];

  final _listMenu = <SettingsMenu>[
    SettingsMenu(
        title: AppStrings.updateProfile, icon: const Icon(Icons.person)),
    SettingsMenu(title: AppStrings.updatePassword, icon: const Icon(Icons.key)),
    SettingsMenu(
        title: AppStrings.notifications, icon: const Icon(Icons.notifications)),
    SettingsMenu(
        title: AppStrings.activityLogs,
        icon: const Icon(Icons.format_list_numbered)),
    SettingsMenu(
        title: AppStrings.developerNotice,
        icon: const Icon(Icons.document_scanner)),
    SettingsMenu(title: AppStrings.about, icon: const Icon(Icons.info_outline)),
    SettingsMenu(title: AppStrings.logout, icon: const Icon(Icons.exit_to_app)),
  ];

  @override
  Widget build(BuildContext context) {
    return Flex(
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
                AppBar(
                  title: const Text(AppStrings.settings),
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.md),
                    child: ListView.builder(
                      itemCount: _listMenu.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          selected: _selectedIndex == index,
                          selectedColor: lightColorScheme.onPrimary,
                          selectedTileColor: lightColorScheme.primary,
                          leading: _listMenu[index].icon,
                          title: Text(_listMenu[index].title),
                          onTap: () {
                            if (index == 6) {
                              // handle logout
                              _appPreferences.clear();
                              resetModules();

                              Navigator.pushReplacementNamed(
                                  context, Routes.loginRoute);
                              return;
                            }

                            setState(
                              () {
                                _selectedIndex = index;
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _children[_selectedIndex],
        ),
      ],
    );
  }
}

class SettingsMenu {
  String title;

  Icon icon;

  SettingsMenu({
    required this.title,
    required this.icon,
  });
}
