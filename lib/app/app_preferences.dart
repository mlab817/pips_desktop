import 'package:shared_preferences/shared_preferences.dart';

const String bearerToken = 'SHARED_PREFS_BEARER_TOKEN';

abstract class AppPreferences {
  void setBearerToken(String value);

  Future<String> getBearerToken();

  Future<bool> clear();
}

class AppPreferencesImplementer implements AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferencesImplementer(this._sharedPreferences);

  @override
  void setBearerToken(String value) async {
    await _sharedPreferences.setString(bearerToken, value);
  }

  @override
  Future<String> getBearerToken() async {
    return _sharedPreferences.getString(bearerToken) ?? "";
  }

  @override
  Future<bool> clear() async {
    return _sharedPreferences.clear();
  }
}