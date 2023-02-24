import 'dart:io';

import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../resources/color_manager.dart';

class MainLayout extends StatefulWidget {
  const MainLayout(
      {Key? key,
      required this.child,
      required this.activeIndex,
      required this.onChange})
      : super(key: key);

  final Widget child;
  final int activeIndex;
  final Function(int index) onChange;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (Platform.isMacOS || Platform.isLinux || Platform.isWindows)
            _getNavigationRail(),
          Expanded(child: widget.child),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.newProjectRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getNavigationRail() {
    int selectedIndex = widget.activeIndex;

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
              destinations: [
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 0
                        ? Icons.dashboard
                        : Icons.dashboard_outlined,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 1
                        ? Icons.build_circle
                        : Icons.build_circle_outlined,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Offices'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 2
                        ? Icons.chat_bubble
                        : Icons.chat_bubble_outline,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Chat'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 4
                        ? Icons.notifications
                        : Icons.notifications_outlined,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Notifications'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 3
                        ? Icons.settings
                        : Icons.settings_outlined,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Settings'),
                ),
              ],
              onDestinationSelected: widget.onChange,
              selectedIndex: selectedIndex,
              // labelType: NavigationRailLabelType.all,
            ),
          ),
        ],
      ),
    );
  }
}
