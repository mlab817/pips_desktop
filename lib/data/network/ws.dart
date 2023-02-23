import 'package:dart_pusher_channels/dart_pusher_channels.dart';

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
      Uri.parse('https://beta.pips.da.gov.ph/api/broadcasting/auth');

  @override
  PusherChannelsClient init() {
    // enable logs for pusher channels
    PusherChannelsPackageLogger.enableLogs();

    const hostOptions = PusherChannelsOptions.fromHost(
      scheme: 'wss',
      // host: 'pips.da.gov.ph',
      // TODO: update settings
      host: 'pips.da.gov.ph',
      port: 443,
      key: '1b421e8d437e47b9eee3',
    );

    final client = PusherChannelsClient.websocket(
      options: hostOptions,
      connectionErrorHandler: (exception, trace, refresh) {
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
