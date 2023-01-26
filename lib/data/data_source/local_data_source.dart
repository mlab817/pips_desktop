import 'package:pips/data/schemas/population.dart';
import 'package:pips/data/schemas/poverty_incidence.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String sharedPrefsBearerToken = "BEARER_TOKEN";
const String sharedPrefsDatabaseLoaded = "DATABASE_LOADED";
const String sharedPrefsIsUserLoggedIn = "IS_USER_LOGGED_IN";

abstract class LocalDataSource {
  Future<String> getBearerToken();

  Future<void> setBearerToken(String value);

  Future<void> setIsUserLoggedIn();

  Future<bool> getIsUserLoggedIn();

  Future<bool> getDatabaseLoaded();

  Future<void> setDatabaseLoaded();

  Future<void> resetDatabaseLoaded();

  RealmResults<Population> getPopulation();

  RealmResults<PovertyIncidence> getPovertyIncidence();
}

class LocalDataSourceImplementer implements LocalDataSource {
  final SharedPreferences _sharedPreferences;
  final Realm _realm;

  LocalDataSourceImplementer(this._sharedPreferences, this._realm);

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
  RealmResults<Population> getPopulation() {
    return _realm.all<Population>();
  }

  @override
  RealmResults<PovertyIncidence> getPovertyIncidence() {
    return _realm.all<PovertyIncidence>();
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
}
