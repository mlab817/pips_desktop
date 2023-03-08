import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/presentation/common/layout.dart';
import 'package:pips/presentation/main/chat/chat.dart';
import 'package:pips/presentation/main/notifications/notifications.dart';
import 'package:pips/presentation/main/offices/offices.dart';
import 'package:pips/presentation/main/projects/projects.dart';
import 'package:pips/presentation/main/settings/settings.dart';

import '../../app/dep_injection.dart';
import 'downloads/downloads.dart';

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
    const ProjectsView(),
    const OfficesView(),
    const ChatView(),
    const NotificationsView(),
    const DownloadsView(),
    const SettingsView(),
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
    return MainLayout(
      onChange: _onDestinationSelected,
      activeIndex: _selectedIndex,
      child: _views[_selectedIndex],
    );
  }

  void _onDestinationSelected(int index) {
    if (index == 6) {
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
