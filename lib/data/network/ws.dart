import 'package:dart_pusher_channels/dart_pusher_channels.dart';

class PusherServiceImplementer {
  static final PusherServiceImplementer _instance =
      PusherServiceImplementer._internal();

  factory PusherServiceImplementer() {
    return _instance;
  }

  PusherServiceImplementer._internal();

  PusherChannelsClient init() {
    // enable logs for pusher channels
    PusherChannelsPackageLogger.enableLogs();

    const hostOptions = PusherChannelsOptions.fromHost(
      scheme: 'ws',
      // host: 'pips.da.gov.ph',
      // TODO: update settings
      host: '127.0.0.1',
      port: 6001,
      key: '1b421e8d437e47b9eee3',
    );

    final client = PusherChannelsClient.websocket(
      options: hostOptions,
      connectionErrorHandler: (exception, trace, refresh) {
// here you can handle connection errors.
// refresh callback enables to reconnect the client
        refresh();
      },
    );

    return client;
  }
}
