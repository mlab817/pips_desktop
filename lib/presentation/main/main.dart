import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/presentation/main/chat/chat.dart';
import 'package:pips/presentation/main/dashboard/dashboard.dart';
import 'package:pips/presentation/main/notifications/notifications.dart';
import 'package:pips/presentation/main/offices/offices.dart';
import 'package:pips/presentation/main/settings/settings.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:universal_io/io.dart';

import '../../app/dep_injection.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  // final Repository _repository = instance<Repository>();
  // final PusherChannelsClient _client = instance<PusherChannelsClient>();

  // late PresenceChannel _presenceChannel;

  // late StreamSubscription<ChannelReadEvent> _streamSubscription;

  // late StreamSubscription<ChannelReadEvent> _allEventsSubs;

  int _selectedIndex = 0;

  final List<Widget> _views = [
    const DashboardView(),
    const OfficesView(),
    const ChatView(),
    const SettingsView(),
    const NotificationsView(),
  ];

  Future<void> _subscribeToChannel() async {
    // String token = await _repository.getBearerToken();

    // _presenceChannel = _client.presenceChannel(
    //   'online-users',
    //   authorizationDelegate:
    //       EndpointAuthorizableChannelTokenAuthorizationDelegate
    //           .forPresenceChannel(
    //     authorizationEndpoint: Uri.parse(Config.authEndpoint),
    //     headers: {"Authorization": "Bearer $token"},
    //   ),
    // );

    // _presenceChannel.subscribeIfNotUnsubscribed();

    // _allEventsSubs = _presenceChannel.bindToAll().listen((event) {
    //   debugPrint(event.toString());
    // });

    // if (_presenceChannel.state?.status == ChannelStatus.subscribed) {
    //   _presenceChannel.trigger(eventName: 'login', data: {
    //     'message': 'hello world!',
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();

    _subscribeToChannel();
  }

  @override
  void dispose() {
    super.dispose();

    // _presenceChannel.unsubscribe();

    // // cancel subscription
    // _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (Platform.isMacOS) _getNavigationRail(),
          Expanded(child: _views[_selectedIndex]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.newProjectRoute);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: (Platform.isIOS || Platform.isAndroid)
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
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
              destinations: [
                NavigationRailDestination(
                  icon: Icon(
                    _selectedIndex == 0
                        ? Icons.dashboard
                        : Icons.dashboard_outlined,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    _selectedIndex == 1
                        ? Icons.build_circle
                        : Icons.build_circle_outlined,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Offices'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    _selectedIndex == 2
                        ? Icons.chat_bubble
                        : Icons.chat_bubble_outline,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Chat'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    _selectedIndex == 3
                        ? Icons.settings
                        : Icons.settings_outlined,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Settings'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    _selectedIndex == 4
                        ? Icons.notifications
                        : Icons.notifications_outlined,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Notifications'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.exit_to_app_outlined,
                    color: ColorManager.blue,
                  ),
                  label: const Text('Logout'),
                ),
              ],
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
    if (index == 5) {
      _appPreferences.clear();
      resetModules();

      Navigator.pushReplacementNamed(context, Routes.loginRoute);
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }
}
