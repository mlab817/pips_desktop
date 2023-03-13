import 'package:pips/presentation/resources/theme_manager.dart';

class Config {
  static const String baseUrl = "https://beta.pips.da.gov.ph";
  static const String baseApiUrl = "$baseUrl/api";
  static const String authEndpoint = "$baseApiUrl/broadcasting/auth";
}

CustomTheme currentTheme = CustomTheme();
