import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String sharedPrefsBearerToken = "BEARER_TOKEN";

abstract class LocalDataSource {
  Future<String> getBearerToken();
}

class LocalDataSourceImplementer implements LocalDataSource {
  final SharedPreferences _sharedPreferences;
  final Realm _realm;

  LocalDataSourceImplementer(this._sharedPreferences, this._realm);

  @override
  Future<String> getBearerToken() async {
    return _sharedPreferences.getString(sharedPrefsBearerToken) ?? "";
  }
}
