import 'package:flutter/material.dart';
import 'package:pips/app/config.dart';
import 'package:pips/app/functions.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:universal_platform/universal_platform.dart';

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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text(AppStrings.appName),
      //   elevation: AppSize.s4,
      //   actions: [
      //     IconButton(
      //         icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
      //             ? Icons.dark_mode
      //             : Icons.light_mode),
      //         onPressed: () {
      //           MyApp.themeNotifier.value =
      //               MyApp.themeNotifier.value == ThemeMode.light
      //                   ? ThemeMode.dark
      //                   : ThemeMode.light;
      //         })
      //   ],
      // ),
      body: Row(
        children: [
          if (UniversalPlatform.isDesktopOrWeb) _buildNavigationRail(),
          Expanded(child: widget.child),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.newProjectRoute);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          (UniversalPlatform.isIOS || UniversalPlatform.isAndroid)
              ? _buildBottomNavigator()
              : null,
    );
  }

  Widget _buildNavigationRail() {
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
                  label: const Text(AppStrings.dashboard),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 1
                        ? Icons.work
                        : Icons.work_outline_outlined,
                  ),
                  label: const Text(AppStrings.offices),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 2
                        ? Icons.chat_bubble
                        : Icons.chat_bubble_outline,
                  ),
                  label: const Text(AppStrings.chats),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 3
                        ? Icons.notifications
                        : Icons.notifications_outlined,
                  ),
                  label: const Text(AppStrings.notifications),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 4
                        ? Icons.settings
                        : Icons.settings_outlined,
                  ),
                  label: const Text(AppStrings.settings),
                ),
              ],
              onDestinationSelected: widget.onChange,
              selectedIndex: selectedIndex,
              // labelType: NavigationRailLabelType.all,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () => currentTheme.toggleTheme(),
          ),
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigator() {
    return BottomNavigationBar(
      currentIndex: widget.activeIndex,
      onTap: widget.onChange,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Offices',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_vert),
          label: 'More',
        ),
      ],
    );
  }
}
