import 'dart:convert';

import 'package:pips/app/app_preferences.dart';
import 'package:pips/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String sharedPrefsBearerToken = "BEARER_TOKEN";
const String sharedPrefsDatabaseLoaded = "DATABASE_LOADED";
const String sharedPrefsIsUserLoggedIn = "IS_USER_LOGGED_IN";
const String sharedPrefsIsOnboardingScreenViewed =
    "IS_ONBOARDING_SCREEN_VIEWED";

abstract class LocalDataSource {
  Future<String> getBearerToken();

  Future<void> setBearerToken(String value);

  Future<void> setIsUserLoggedIn();

  Future<void> setIsOnboardingScreenViewed();

  Future<bool> getIsOnboardingScreenViewed();

  Future<bool> getIsUserLoggedIn();

  Future<bool> getDatabaseLoaded();

  Future<void> setDatabaseLoaded();

  Future<void> resetDatabaseLoaded();

  Future<void> setLoggedInUser(UserModel value);
}

class LocalDataSourceImplementer implements LocalDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDataSourceImplementer(this._sharedPreferences);

  @override
  Future<String> getBearerToken() async {
    return _sharedPreferences.getString(sharedPrefsBearerToken) ?? "";
  }

  @override
  Future<bool> getDatabaseLoaded() async {
    return _sharedPreferences.getBool(sharedPrefsDatabaseLoaded) ?? false;
  }

  @override
  Future<void> setDatabaseLoaded() async {
    _sharedPreferences.setBool(sharedPrefsDatabaseLoaded, true);
  }

  @override
  Future<void> resetDatabaseLoaded() async {
    _sharedPreferences.remove(
        sharedPrefsDatabaseLoaded); //setBool(sharedPrefsDatabaseLoaded, false);
  }

  @override
  Future<void> setBearerToken(String value) async {
    _sharedPreferences.setString(sharedPrefsBearerToken, value);
  }

  @override
  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(sharedPrefsIsUserLoggedIn, true);
  }

  @override
  Future<bool> getIsUserLoggedIn() async {
    return _sharedPreferences.getBool(sharedPrefsIsUserLoggedIn) ?? false;
  }

  @override
  Future<void> setIsOnboardingScreenViewed() async {
    _sharedPreferences.setBool(sharedPrefsIsOnboardingScreenViewed, true);
  }

  @override
  Future<bool> getIsOnboardingScreenViewed() async {
    return _sharedPreferences.getBool(sharedPrefsIsOnboardingScreenViewed) ??
        false;
  }

  @override
  Future<void> setLoggedInUser(UserModel value) async {
    _sharedPreferences.setString(loggedInUser, jsonEncode(value));
  }
}
