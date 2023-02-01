import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pips/presentation/about/about.dart';
import 'package:pips/presentation/main/dashboard/dashboard.dart';
import 'package:pips/presentation/main/messages/messages.dart';
import 'package:pips/presentation/main/offices/offices.dart';
import 'package:pips/presentation/main/projects/projects.dart';
import 'package:pips/presentation/main/settings/settings.dart';
import 'package:pips/presentation/main/users/users.dart';
import 'package:pips/presentation/resources/color_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<NavigationRailDestination> _destinations = [
    NavigationRailDestination(
      icon: Icon(
        Icons.dashboard_outlined,
        color: ColorManager.blue,
      ),
      label: const Text('Dashboard'),
    ),
    NavigationRailDestination(
      icon: Icon(
        Icons.build_circle_outlined,
        color: ColorManager.blue,
      ),
      label: const Text('Offices'),
    ),
    NavigationRailDestination(
      icon: Icon(
        Icons.view_column_outlined,
        color: ColorManager.blue,
      ),
      label: const Text('Projects'),
    ),
    NavigationRailDestination(
      icon: Icon(
        Icons.chat_bubble_outline,
        color: ColorManager.blue,
      ),
      label: const Text('Chat'),
    ),
    NavigationRailDestination(
      icon: Icon(
        Icons.settings_outlined,
        color: ColorManager.blue,
      ),
      label: const Text('Settings'),
    ),
    NavigationRailDestination(
      icon: Icon(
        Icons.info_outline,
        color: ColorManager.blue,
      ),
      label: const Text('About'),
    ),
    NavigationRailDestination(
      icon: Icon(
        Icons.exit_to_app_outlined,
        color: ColorManager.blue,
      ),
      label: const Text('Logout'),
    ),
  ];

  final List<Widget> _views = [
    const DashboardView(),
    const OfficesView(),
    const ProjectsView(),
    const MessagesView(),
    const SettingsView(),
    const DashboardView(),
    const AboutView(),
    const DashboardView(),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          if (Platform.isMacOS) _getNavigationRail(),
          Expanded(child: _views[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: (Platform.isIOS || Platform.isAndroid)
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_column),
                  label: 'Projects',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline),
                  label: 'About',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            )
          : null,
    );
  }

  Widget _getNavigationRail() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: ColorManager.lightGray,
          ),
        ),
      ),
      child: Column(
        children: [
          // _getSearchField(),
          Expanded(
            child: NavigationRail(
              // extended: true,
              destinations: _destinations,
              onDestinationSelected: _onDestinationSelected,
              selectedIndex: _selectedIndex,
              // labelType: NavigationRailLabelType.all,
            ),
          ),
        ],
      ),
    );
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
