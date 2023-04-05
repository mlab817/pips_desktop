import 'package:flutter/material.dart';
import 'package:pips/presentation/web/common/web_layout.dart';

import '../../../app/routes.dart';
import '../../common/responsive.dart';
import '../../main/settings/settings.dart';
import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

class WebSettingsView extends StatefulWidget {
  const WebSettingsView({Key? key}) : super(key: key);

  @override
  State<WebSettingsView> createState() => _WebSettingsViewState();
}

class _WebSettingsViewState extends State<WebSettingsView> {
  final _listMenu = <SettingsMenu>[
    SettingsMenu(
      title: AppStrings.profile,
      icon: const Icon(Icons.person),
      route: Routes.updateProfileRoute,
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
    return const WebLayout(child: Placeholder());
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
              const Expanded(child: Placeholder()),
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
    return Padding(
      padding: const EdgeInsets.all(AppPadding.md),
      child: ListView.builder(
          itemCount: _listMenu.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: _listMenu[index].icon,
              title: Text(_listMenu[index].title),
            );
          }),
    );
  }
}
