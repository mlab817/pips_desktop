import 'package:pips/presentation/resources/theme_manager.dart';

class Config {
  static const String host = 'pips.da.gov.ph';
  static const String baseUrl = "https://$host";
  static const String baseApiUrl = "https://api.$host";
  static const String authEndpoint = "$baseApiUrl/broadcasting/auth";

  // static const String wsHost = 'pips.da.gov.ph';
  static const String wsHost = 'pips.da.gov.ph';
  static const String oneSignalAppId = "248df894-4145-4507-97c9-4a279924177e";
}

CustomTheme currentTheme = CustomTheme();
