import 'dart:convert';

import 'package:pips/data/data_source/local_data_source.dart';
import 'package:pips/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String bearerToken = 'SHARED_PREFS_BEARER_TOKEN';
const String loggedInUser = 'SHARED_PREFS_LOGGED_IN_USER';
const String isOnboardingScreenViewed =
    'SHARED_PREFS_IS_ONBOARDING_SCREEN_VIEWED';

abstract class AppPreferences {
  void setBearerToken(String value);

  Future<String> getBearerToken();

  Future<bool> getIsUserLoggedIn();

  Future<bool> getIsOnboardingScreenViewed();

  Future<UserModel?> getLoggedInUser();

  Future<bool> setLoggedInUser(UserModel userModel);

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

  @override
  Future<bool> getIsUserLoggedIn() async {
    return _sharedPreferences.getBool(sharedPrefsIsUserLoggedIn) ?? false;
  }

  @override
  Future<UserModel?> getLoggedInUser() async {
    var userJson = _sharedPreferences.getString(loggedInUser);
    if (userJson == null) {
      return null;
    }
    var userMap = jsonDecode(userJson);
    return UserModel.fromJson(userMap);
  }

  @override
  Future<bool> getIsOnboardingScreenViewed() async {
    return _sharedPreferences.getBool(isOnboardingScreenViewed) ?? false;
  }

  @override
  Future<bool> setLoggedInUser(UserModel userModel) async {
    return _sharedPreferences.setString(loggedInUser, jsonEncode(userModel));
  }
}
