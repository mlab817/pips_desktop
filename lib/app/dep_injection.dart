import 'package:get_it/get_it.dart';
import 'package:pips_desktop/app/app_preferences.dart';
import 'package:pips_desktop/data/data_source/remote_data_source.dart';
import 'package:pips_desktop/data/network/app_api.dart';
import 'package:pips_desktop/data/network/dio_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// dependency injection for the app
final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferencesImplementer(instance()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  // add dio to client
}
