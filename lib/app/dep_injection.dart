import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/data/data_source/local_data_source.dart';
import 'package:pips/data/data_source/remote_data_source.dart';
import 'package:pips/data/network/app_api.dart';
import 'package:pips/data/network/dio_factory.dart';
import 'package:pips/data/repository/repository_implementer.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/login_usecase.dart';
import 'package:pips/domain/usecase/office_usecase.dart';
import 'package:pips/domain/usecase/offices_usecase.dart';
import 'package:pips/domain/usecase/project_usecase.dart';
import 'package:pips/domain/usecase/projects_usecase.dart';
import 'package:pips/domain/usecase/users_usecase.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/schemas/population.dart';
import '../data/schemas/poverty_incidence.dart';

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

  final db = FirebaseFirestore.instance;

  instance.registerLazySingleton<FirebaseFirestore>(() => db);

  var config = Configuration.local([
    PovertyIncidence.schema,
    Population.schema,
  ]);

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

  instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
}

initLoginModule() {
  // if (!GetIt.I.isRegistered<LoginUseCase>()) {
  //   instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
  // }
}

initProjectsModule() {
  if (!GetIt.I.isRegistered<ProjectsUseCase>()) {
    instance
        .registerFactory<ProjectsUseCase>(() => ProjectsUseCase(instance()));
  }
}

initOfficesModule() {
  if (!GetIt.I.isRegistered<OfficesUseCase>()) {
    instance.registerFactory<OfficesUseCase>(() => OfficesUseCase(instance()));
  }

  if (!GetIt.I.isRegistered<OfficeUseCase>()) {
    instance.registerFactory<OfficeUseCase>(() => OfficeUseCase(instance()));
  }
}

initProjectModule() {
  if (!GetIt.I.isRegistered<ProjectUseCase>()) {
    instance.registerFactory<ProjectUseCase>(() => ProjectUseCase(instance()));
  }
}

initUsersModule() {
  if (!GetIt.I.isRegistered<UsersUseCase>()) {
    instance.registerFactory<UsersUseCase>(() => UsersUseCase(instance()));
  }
}

resetModules() {
  instance.reset(dispose: false);
  initAppModule();
}
