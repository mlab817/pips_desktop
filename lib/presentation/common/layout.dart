import 'package:flutter/material.dart';
import 'package:pips/app/config.dart';
import 'package:pips/app/functions.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:pips/presentation/resources/theme_manager.dart';
import 'package:provider/provider.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();

    currentTheme.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (UniversalPlatform.isDesktopOrWeb) _buildNavigationRail(),
          Expanded(child: widget.child),
        ],
      ),
      // floatingActionButton: UniversalPlatform.isDesktopOrWeb
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, Routes.newProjectRoute);
      //         },
      //         child: const Icon(Icons.add),
      //       )
      //     : null,
      floatingActionButton: UniversalPlatform.isDesktopOrWeb
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.newProjectRoute);
              },
              child: const Icon(Icons.add),
            )
          : null,
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
                  label: const Text(AppStrings.home),
                ),
                // NavigationRailDestination(
                //   icon: Icon(
                //     selectedIndex == 1
                //         ? Icons.work
                //         : Icons.work_outline_outlined,
                //   ),
                //   label: const Text(AppStrings.offices),
                // ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 1
                        ? Icons.chat_bubble
                        : Icons.chat_bubble_outline,
                  ),
                  label: const Text(AppStrings.chat),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 2 ? Icons.add : Icons.add_outlined,
                  ),
                  label: const Text(AppStrings.newProgramProject),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 3
                        ? Icons.notifications
                        : Icons.notifications_outlined,
                  ),
                  label: const Text(AppStrings.notifications),
                ),
                // NavigationRailDestination(
                //   icon: Icon(
                //     selectedIndex == 4
                //         ? Icons.download
                //         : Icons.download_outlined,
                //   ),
                //   label: const Text(AppStrings.downloads),
                // ),
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
              labelType: NavigationRailLabelType.none,
              extended: true,
            ),
          ),
          Consumer<CustomTheme>(builder: (context, currentTheme, child) {
            return IconButton(
              icon: Icon(
                Provider.of<CustomTheme>(context).isDarkTheme
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () => Provider.of<CustomTheme>(context, listen: false)
                  .toggleTheme(),
            );
          }),

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
      elevation: AppSize.s10,
      onTap: widget.onChange,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
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
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
