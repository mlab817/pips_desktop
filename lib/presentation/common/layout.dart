import 'package:flutter/material.dart';
import 'package:pips/app/config.dart';
import 'package:pips/app/functions.dart';
import 'package:pips/data/requests/notifications/notifications_request.dart';
import 'package:pips/domain/usecase/notifications_usecase.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:pips/presentation/resources/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../app/dep_injection.dart';
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
  final NotificationsUseCase _notificationsUseCase =
      instance<NotificationsUseCase>();

  int? _notifications;

  //
  Future<void> _getNotifications() async {
    (await _notificationsUseCase.execute(NotificationsRequest()))
        .fold((failure) {}, (response) {
      setState(() {
        _notifications = response.meta.pagination.total;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    currentTheme.addListener(() {});

    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(UniversalPlatform.isWeb.toString());

    return Scaffold(
      body: Row(
        children: [
          if (UniversalPlatform.isWeb) _buildNavigationRail(),
          Expanded(child: widget.child),
        ],
      ),
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
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  ),
                  label: const Text(AppStrings.home),
                ),
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
                    selectedIndex == 2
                        ? Icons.notifications
                        : Icons.notifications_outlined,
                  ),
                  label: const Text(AppStrings.notifications),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    selectedIndex == 3
                        ? Icons.settings
                        : Icons.settings_outlined,
                  ),
                  label: const Text(AppStrings.settings),
                ),
              ],
              onDestinationSelected: widget.onChange,
              selectedIndex: selectedIndex,
              labelType: NavigationRailLabelType.none,
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
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppStrings.home,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: AppStrings.chat,
        ),
        BottomNavigationBarItem(
          icon: Badge(
            label:
                _notifications != null ? Text(_notifications.toString()) : null,
            child: const Icon(Icons.notifications),
          ),
          label: AppStrings.notifications,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: AppStrings.settings,
        ),
      ],
    );
  }
}
