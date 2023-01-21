import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String sharedPrefsBearerToken = "BEARER_TOKEN";
const String sharedPrefsDatabaseLoaded = "DATABASE_LOADED";

abstract class LocalDataSource {
  Future<String> getBearerToken();

  Future<bool> getDatabaseLoaded();

  Future<void> setDatabaseLoaded();

  Future<void> resetDatabaseLoaded();
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
}
