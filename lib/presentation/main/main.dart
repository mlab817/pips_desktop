import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pips/presentation/main/home/home.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<NavigationRailDestination> _destinations = [
    const NavigationRailDestination(
      icon: Icon(
        Icons.home,
      ),
      label: Text('Home'),
    ),
    const NavigationRailDestination(
      icon: Icon(
        Icons.person,
      ),
      label: Text('Profile'),
    ),
    const NavigationRailDestination(
      icon: Icon(
        Icons.settings,
      ),
      label: Text('Settings'),
    ),
    const NavigationRailDestination(
      icon: Icon(
        Icons.info,
      ),
      label: Text('About'),
    ),
    const NavigationRailDestination(
      icon: Icon(
        Icons.exit_to_app,
      ),
      label: Text('Logout'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          if (Platform.isMacOS) _getNavigationRail(),
          const HomeView(),
        ],
      ),
      bottomNavigationBar: (Platform.isIOS || Platform.isAndroid)
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
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
      ))),
      child: Column(
        children: [
          // _getSearchField(),
          Expanded(
            child: NavigationRail(
              extended: true,
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

  Widget _getSearchField() {
    return const Padding(
      padding: EdgeInsets.all(AppSize.s12),
      child: SizedBox(
          // height: AppSize.s36,
          width: AppSize.s220,
          child: TextField(
            decoration: InputDecoration(
              label: Text('Search'),
              suffix: Icon(Icons.search_outlined),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AppSize.s2, horizontal: AppSize.s4),
            ),
          )),
    );
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
