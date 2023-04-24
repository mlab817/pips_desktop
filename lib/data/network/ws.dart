import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/cupertino.dart';
import 'package:pips/app/config.dart';

enum ChannelType { presenceChannel, publicChannel, privateChannel }

abstract class WebsocketClient {
  void init();

  void connect();

  void disconnect();

  void dispose();
}

class PusherWebsocketClient implements WebsocketClient {
  static final PusherWebsocketClient _instance =
      PusherWebsocketClient._internal();

  factory PusherWebsocketClient() {
    return _instance;
  }

  late PusherChannelsClient _client;

  PusherWebsocketClient._internal();

  static Uri get authEndPoint =>
      Uri.parse('${Config.baseApiUrl}/broadcasting/auth');

  @override
  PusherChannelsClient init() {
    // enable logs for pusher channels
    PusherChannelsPackageLogger.enableLogs();

    const hostOptions = PusherChannelsOptions.fromHost(
      scheme: 'wss',
      host: Config.wsHost,
      // port: 443,
      key: '1b421e8d437e47b9eee3',
    );

    final client = PusherChannelsClient.websocket(
      options: hostOptions,
      connectionErrorHandler: (exception, trace, refresh) {
        debugPrint("exception: ${exception.toString()}");
        refresh();
      },
    );

    return client;
  }

  @override
  void connect() {
    _client.connect();
  }

  @override
  void dispose() {
    _client.dispose();
  }

  @override
  void disconnect() {
    _client.disconnect();
  }
}
