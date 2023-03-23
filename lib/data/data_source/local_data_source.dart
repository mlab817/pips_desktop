import 'dart:convert';

import 'package:pips/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String sharedPrefsBearerToken = "SHARED_PREFS_BEARER_TOKEN";
const String sharedPrefsDatabaseLoaded = "SHARED_PREFS_DATABASE_LOADED";
const String sharedPrefsIsUserLoggedIn = "SHARED_PREFS_IS_USER_LOGGED_IN";
const String sharedPrefsIsOnboardingScreenViewed =
    "SHARED_PREFS_IS_ONBOARDING_SCREEN_VIEWED";
const String sharedPrefsImageUrl = 'SHARED_PREFS_IMAGE_URL';
const String loggedInUser = 'SHARED_PREFS_LOGGED_IN_USER';
const String notificationAllowed = 'SHARED_PREFS_NOTIFICATION_ALLOWED';

abstract class LocalDataSource {
  Future<String> getBearerToken();

  Future<void> setBearerToken(String value);

  Future<void> setIsUserLoggedIn();

  Future<void> setImageUrl(String value);

  Future<String?> getImageUrl();

  Future<void> setIsOnboardingScreenViewed(bool value);

  Future<bool> getIsOnboardingScreenViewed();

  Future<bool> getIsUserLoggedIn();

  Future<bool> getDatabaseLoaded();

  Future<void> setDatabaseLoaded();

  Future<void> resetDatabaseLoaded();

  Future<void> setLoggedInUser(User value);

  Future<User?> getLoggedInUser();

  Future<void> setNotificationAllowed(bool value);

  Future<bool> getNotificationAllowed();

  Future<void> clear();
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
  Future<void> setIsOnboardingScreenViewed(value) async {
    _sharedPreferences.setBool(sharedPrefsIsOnboardingScreenViewed, value);
  }

  @override
  Future<bool> getIsOnboardingScreenViewed() async {
    return _sharedPreferences.getBool(sharedPrefsIsOnboardingScreenViewed) ??
        false;
  }

  @override
  Future<void> setLoggedInUser(User value) async {
    _sharedPreferences.setString(loggedInUser, jsonEncode(value));
  }

  @override
  Future<User?> getLoggedInUser() async {
    String? storedUser = _sharedPreferences.getString(loggedInUser);

    return storedUser != null ? User.fromJson(jsonDecode(storedUser)) : null;
  }

  @override
  Future<String?> getImageUrl() async {
    return _sharedPreferences.getString(sharedPrefsImageUrl);
  }

  @override
  Future<void> setImageUrl(String value) async {
    _sharedPreferences.setString(sharedPrefsImageUrl, value);
  }

  @override
  Future<bool> getNotificationAllowed() async {
    return _sharedPreferences.getBool(notificationAllowed) ?? false;
  }

  @override
  Future<void> setNotificationAllowed(bool value) async {
    _sharedPreferences.setBool(notificationAllowed, value);
  }

  @override
  Future<void> clear() async {
    _sharedPreferences.clear();
  }
}
