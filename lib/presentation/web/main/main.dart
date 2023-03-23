import 'package:flutter/material.dart';

import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

class MainWebView extends StatefulWidget {
  const MainWebView({Key? key}) : super(key: key);

  @override
  State<MainWebView> createState() => _MainWebViewState();
}

class _MainWebViewState extends State<MainWebView> {
  int _currentIndex = 0;

  final List<NavigationRailDestination> _destinations = [
    const NavigationRailDestination(
      icon: Icon(Icons.home),
      label: Text('Home'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.settings),
      label: Text('Settings'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
            tooltip: 'User',
          ),
        ],
      ),
      body: Row(
        children: [
          _buildNavigationRail(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      destinations: _destinations,
      elevation: AppSize.s2,
      onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      selectedIndex: _currentIndex,
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: AppSize.s280,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.md),
                  child: SizedBox(
                    height: AppSize.s36,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('New'),
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: [Container()],
                ),
              ],
            ),
          ),
          const Expanded(
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
