import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../../app/app.dart';
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
    debugPrint(MyApp.themeNotifier.value.toString());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.appName),
        elevation: AppSize.s4,
        actions: [
          IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              })
        ],
      ),
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
                  ),
                  label: const Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 1
                        ? Icons.build_circle
                        : Icons.build_circle_outlined,
                  ),
                  label: const Text('Offices'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 2
                        ? Icons.chat_bubble
                        : Icons.chat_bubble_outline,
                  ),
                  label: const Text('Chat'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 4
                        ? Icons.notifications
                        : Icons.notifications_outlined,
                  ),
                  label: const Text('Notifications'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 3
                        ? Icons.settings
                        : Icons.settings_outlined,
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
