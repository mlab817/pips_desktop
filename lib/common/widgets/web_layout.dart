import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routing/routing.dart';
import '../resources/assets_manager.dart';
import '../resources/sizes_manager.dart';
import '../resources/strings_manager.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  int _currentIndex = 0;

  final List<NavigationRailDestination> _destinations = [
    const NavigationRailDestination(
      icon: Icon(Icons.home),
      label: Text('Home'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.chat),
      label: Text('Chat'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.notifications),
      label: Text('Notifs'),
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
        elevation: AppElevation.none,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.md),
              child: Image.asset(
                AssetsManager.logo,
                height: AppSize.s40,
              ),
            ),
            const SizedBox(
              width: AppSize.md,
            ),
            Text(
              AppStrings.pips,
              style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.w500,
                fontSize: AppSize.s36,
                color: Theme.of(context).primaryColor,
                letterSpacing: AppSize.s4,
              ),
            ),
            const SizedBox(
              width: AppSize.md,
            ),
            CircleAvatar(
              child: IconButton(
                iconSize: AppSize.s20,
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: open settings
              Navigator.pushNamed(context, Routes.notificationRoute);
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              // TODO: open settings
              Navigator.pushNamed(context, Routes.settingsRoute);
            },
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            onPressed: () {
              // TODO: open account options
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: Row(
        children: [
          _buildNavigationRail(),
          _buildDivider(),
          _buildMainBody(),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const VerticalDivider(
      width: AppSize.s1,
      thickness: AppSize.s1,
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      destinations: _destinations,
      elevation: AppSize.s2,
      labelType: NavigationRailLabelType.none,
      onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      selectedIndex: _currentIndex,
      trailing: Expanded(
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                // TODO: implement logout
              },
            ),
          ],
        ),
      ),
      selectedLabelTextStyle: Theme.of(context).textTheme.bodySmall,
      unselectedLabelTextStyle: Theme.of(context).textTheme.bodySmall,
    );
  }

  List<Widget> _buildTopMenu() {
    return [
      const Spacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    ];
  }

  Widget _buildTitle() {
    return SizedBox(
      width: AppSize.s240,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.md),
              child: const Image(
                image: ResizeImage(
                  AssetImage(
                    AssetsManager.logo,
                  ),
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            const SizedBox(
              width: AppSize.s8,
            ),
            Text(
              AppStrings.pips,
              style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.w500,
                fontSize: AppSize.s36,
                color: Theme.of(context).primaryColor,
                letterSpacing: AppSize.s4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainBody() {
    return Expanded(
      child: Column(
        children: [
          // Row(children: [
          //   _buildTitle(),
          //   ..._buildTopMenu(),
          // ]),
          const SizedBox(
            height: AppPadding.md,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.child,
              const SizedBox(
                width: AppSize.sm,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
