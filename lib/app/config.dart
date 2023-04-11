import 'package:pips/presentation/resources/theme_manager.dart';

class Config {
  static const String baseUrl = "https://pipsv2.test";
  static const String baseApiUrl = "$baseUrl/api";
  static const String authEndpoint = "$baseApiUrl/broadcasting/auth";

  // static const String wsHost = 'pips.da.gov.ph';
  static const String wsHost = 'pipsv2.test';
  static const String oneSignalAppId = "248df894-4145-4507-97c9-4a279924177e";
}

CustomTheme currentTheme = CustomTheme();
