import 'dart:async';

import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/common/shared_prefs.dart';
import 'package:pips/data/data_source/local_data_source.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/config.dart';
import '../../../app/dep_injection.dart';

const String applicationJson = 'application/json';
const String applicationXml = 'application/xml';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'language';
const String bearer = 'Bearer';

class DioFactory {
  // final AppPreferences _appPreferences;
  final SharedPreferences _sharedPreferences;

  // initialize with sharedPrefs, sharedPrefs is inserted in di
  DioFactory(this._sharedPreferences);

  Dio getDio() {
    Dio dio = Dio();

    // retrieve token from shared prefs
    String? token = _sharedPreferences.getString(sharedPrefsBearerToken);

    //
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: "$bearer $token",
    };

    dio.options = BaseOptions(
      baseUrl: Config.baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 30),
    );

    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
        request: true,
        // requestHeader: true,
        requestBody: true,
        // responseBody: false,
        // responseHeader: true,
        responseBody: true,
        compact: true,
        error: true,
      ));
    }

    dio.interceptors.add(LogoutInterceptor());

    return dio;
  }
}

class LogoutEvent {
  bool loggedOut = false;

  LogoutEvent({required this.loggedOut});
}

EventBus eventBus = EventBus(sync: true);

class LogoutInterceptor extends InterceptorsWrapper {
  final LocalDataSource _appPreferences = instance<LocalDataSource>();

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    print("error ${err.message}");

    if (err.response?.statusCode == 401) {
      // clear shared prefs
      _appPreferences.clear();

      print("encountered error 401: event bus should fire soon");

      eventBus.fire(LogoutEvent(loggedOut: true));
    }

    if (err.response?.statusCode == 422) {
      // if validation error occurred
      // throwError(err.response?.data?.message ?? 'Validation error');
    }

    handler.next(err);
  }
}

final dioProvider = Provider<Dio>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);

  final dioFactory = DioFactory(sharedPreferences);

  return dioFactory.getDio();
});
