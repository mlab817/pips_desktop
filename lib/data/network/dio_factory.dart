import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pips/data/data_source/local_data_source.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/config.dart';

const String applicationJson = 'application/json';
const String applicationXml = 'application/xml';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'language';
const String bearer = 'Bearer';

class DioFactory {
  // final AppPreferences _appPreferences;
  final LocalDataSource _localDataSource;

  // initialize with sharedPrefs, sharedPrefs is inserted in di
  DioFactory(this._localDataSource);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    // retrieve token from shared prefs
    String token = await _localDataSource.getBearerToken();

    //
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: "$bearer $token",
    };

    dio.options = BaseOptions(
      baseUrl: Config.baseUrl,
      headers: headers,
    );

    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
        request: true,
        // requestHeader: true,
        // requestBody: true,
        responseBody: false,
        // responseHeader: true,
        // responseBody: true,
        compact: true,
        error: true,
      ));
    }

    return dio;
  }
}
