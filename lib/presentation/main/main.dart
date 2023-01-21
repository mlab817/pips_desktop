import 'package:flutter/material.dart';
import 'package:pips/presentation/main/home/home.dart';
import 'package:pips/presentation/resources/color_manager.dart';

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
          _getNavigationRail(),
          const HomeView(),
        ],
      ),
    );
  }

  Widget _getNavigationRail() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
        color: ColorManager.lightGray,
      ))),
      child: NavigationRail(
        destinations: _destinations,
        onDestinationSelected: _onDestinationSelected,
        selectedIndex: _selectedIndex,
      ),
    );
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
