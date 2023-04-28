import 'package:flutter/material.dart';
import 'package:pips/common/widgets/web_layout.dart';

import '../../common/resources/sizes_manager.dart';
import '../../common/resources/strings_manager.dart';
import '../../common/widgets/responsive.dart';
import '../../routing/routing.dart';

class SettingsMenu {
  final String title;
  final Icon icon;
  final String route;

  SettingsMenu({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int _selectedListMenu = 0;

  final _listMenu = <SettingsMenu>[
    SettingsMenu(
      title: AppStrings.profile,
      icon: const Icon(Icons.person),
      route: Routes.updateProfileRoute,
    ),
    SettingsMenu(
      title: AppStrings.accountRecovery,
      icon: const Icon(Icons.lock_reset),
      route: Routes.updatePasswordRoute,
    ),
    SettingsMenu(
      title: AppStrings.changePassword,
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
  Widget build(BuildContext context) {
    return WebLayout(child: _buildMainBody());
  }

  Widget _buildMainBody() {
    return Expanded(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (ResponsiveWidget.isLargeScreen(context)) _buildSidePanel(),
              // Main Body
              const Divider(),
              // main content, PageView builder
              const Expanded(child: Placeholder()),
              // extra space at the right side
              const SizedBox(
                width: AppSize.md,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidePanel() {
    return SizedBox(
      width: AppSize.s240,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _listMenu.length,
            itemBuilder: (context, index) {
              return ListTile(
                selected: _selectedListMenu == index,
                leading: _listMenu[index].icon,
                title: Text(
                  _listMenu[index].title,
                  style: _selectedListMenu == index
                      ? const TextStyle(
                          fontSize: AppSize.s14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        )
                      : const TextStyle(
                          fontSize: AppSize.s14,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                        ),
                ),
                dense: true,
                visualDensity: VisualDensity.compact,
                onTap: () {
                  setState(() {
                    _selectedListMenu = index;
                  });
                },
              );
            }),
      ),
    );
  }
}
