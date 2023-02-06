import 'package:flutter/material.dart';
import 'package:pips/presentation/main/settings/screens/about.dart';
import 'package:pips/presentation/main/settings/screens/developer_notice.dart';
import 'package:pips/presentation/main/settings/screens/notifications.dart';
import 'package:pips/presentation/main/settings/screens/update_password.dart';
import 'package:pips/presentation/main/settings/screens/update_profile.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int _selectedIndex = 0;

  final List<Widget> _children = <Widget>[
    const UpdateProfile(),
    const UpdatePassword(),
    const Notifications(),
    const DeveloperNotice(),
    const AboutView(),
  ];

  final _listMenu = <SettingsMenu>[
    SettingsMenu(title: 'Update Profile', icon: const Icon(Icons.person)),
    SettingsMenu(title: 'Update Password', icon: const Icon(Icons.key)),
    SettingsMenu(title: 'Notifications', icon: const Icon(Icons.notifications)),
    SettingsMenu(
        title: 'Developer Notice', icon: const Icon(Icons.document_scanner)),
    SettingsMenu(title: 'About', icon: const Icon(Icons.info_outline)),
  ];

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: ColorManager.darkGray,
                  width: AppSize.s0_5,
                ),
              ),
            ),
            child: Column(
              children: [
                AppBar(
                  title: const Text('Settings'),
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.s8),
                    child: ListView.builder(
                      itemCount: _listMenu.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          selected: _selectedIndex == index,
                          selectedColor: ColorManager.white,
                          selectedTileColor: ColorManager.blue,
                          leading: _listMenu[index].icon,
                          title: Text(_listMenu[index].title),
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
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
//
// children: [
// ListTile(
// dense: true,
// leading: const Icon(Icons.person),
// title: const Text('Update Profile'),
// selected: _selectedIndex == 0,
// selectedColor: ColorManager.white,
// selectedTileColor: ColorManager.blue,
// onTap: () {
// setState(() {
// _selectedIndex = 0;
// });
// },
// ),
// ListTile(
// dense: true,
// leading: const Icon(Icons.key),
// title: const Text('Update Password'),
// onTap: () {
// setState(() {
// _selectedIndex = 1;
// });
// },
// ),
// ListTile(
// dense: true,
// leading: const Icon(Icons.notifications),
// title: const Text('Notifications'),
// onTap: () {
// setState(() {
// _selectedIndex = 2;
// });
// },
// ),
// const Divider(),
// ListTile(
// dense: true,
// leading: const Icon(Icons.document_scanner),
// title: const Text('Developer Notice'),
// onTap: () {
// setState(() {
// _selectedIndex = 3;
// });
// },
// ),
// ListTile(
// dense: true,
// leading: const Icon(Icons.info_outline),
// title: const Text('About'),
// onTap: () {
// setState(() {
// _selectedIndex = 4;
// });
// },
// ),
// const Divider(),
// Padding(
// padding: const EdgeInsets.all(AppSize.s8),
// child: Text(
// 'PIPS v.1.0.0+6',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: ColorManager.darkGray,
// fontSize: AppSize.s10,
// ),
// ),
// ),
// ],
