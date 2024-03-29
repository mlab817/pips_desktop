import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:pips/features/dashboard/presentation/views/home.dart';
import 'package:pips/features/notifications/presentation/notifications.dart';
import 'package:pips/features/settings/settings.dart';
import 'package:pips/routing/routing.dart';

import '../../app/config.dart';
import '../../app/dep_injection.dart';
import '../../common/domain/repository/repository.dart';
import '../../common/widgets/layout.dart';
import '../chats/presentation/views/chat.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final Repository _repository = instance<Repository>();
  final PusherChannelsClient _client = instance<PusherChannelsClient>();

  late PresenceChannel _presenceChannel;

  StreamSubscription<ChannelReadEvent>? _streamSubscription;

  StreamSubscription<ChannelReadEvent>? _allEventsSubs;

  int _selectedIndex = 0;

  final List<Widget> _views = [
    const HomeView(),
    const ChatView(),
    // const NewProjectView(),
    // const OfficesView(),
    const NotificationsView(),
    // const DownloadsView(),
    const SettingsView(),
  ];

  Future<void> _subscribeToChannel() async {
    String token = await _repository.getBearerToken();

    _presenceChannel = _client.presenceChannel(
      'online-users',
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate
              .forPresenceChannel(
        authorizationEndpoint: Uri.parse(Config.authEndpoint),
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    _presenceChannel.subscribeIfNotUnsubscribed();

    _allEventsSubs = _presenceChannel.bindToAll().listen((event) {
      //
    });

    if (_presenceChannel.state?.status == ChannelStatus.subscribed) {
      _presenceChannel.trigger(eventName: 'login', data: {
        'message': 'hello world!',
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _subscribeToChannel();
  }

  @override
  void dispose() {
    super.dispose();

    _presenceChannel.unsubscribe();

    // cancel subscription
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }
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
      _repository.clear();
      resetModules();

      Navigator.pushReplacementNamed(context, Routes.loginRoute);
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }
}
