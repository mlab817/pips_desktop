import 'package:get_it/get_it.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/data/data_source/local_data_source.dart';
import 'package:pips/data/data_source/remote_data_source.dart';
import 'package:pips/data/network/app_api.dart';
import 'package:pips/data/network/dio_factory.dart';
import 'package:pips/data/repository/repository_implementer.dart';
import 'package:pips/data/schemas/poverty_incidence.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// dependency injection for the app
final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<AppPreferences>(
          () => AppPreferencesImplementer(instance()));

  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImplementer(instance()));

  var config = Configuration.local([
    PovertyIncidence.schema,
  ], path: 'db');

  final realm = Realm(config);

  instance.registerLazySingleton<Realm>(() => realm);

  instance.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImplementer(instance(), instance()));

  instance.registerLazySingleton<Repository>(
          () => RepositoryImplementer(instance(), instance()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  // add dio to client
}
