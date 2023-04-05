import 'package:pips/presentation/resources/theme_manager.dart';

class Config {
  static const String baseUrl = "http://172.17.210.48:8080/pipsv2";
  static const String baseApiUrl = "$baseUrl/api";
  static const String authEndpoint = "$baseApiUrl/broadcasting/auth";

  // static const String wsHost = 'pips.da.gov.ph';
  static const String wsHost = '172.17.210.48:8080/pipsv2';
  static const String oneSignalAppId = "248df894-4145-4507-97c9-4a279924177e";
}

CustomTheme currentTheme = CustomTheme();
