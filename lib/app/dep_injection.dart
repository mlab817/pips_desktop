import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pips/data/data_source/local_data_source.dart';
import 'package:pips/data/data_source/remote_data_source.dart';
import 'package:pips/data/network/app_api.dart';
import 'package:pips/data/network/dio_factory.dart';
import 'package:pips/data/network/ws.dart';
import 'package:pips/data/repository/repository_implementer.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/alloffices_usecase.dart';
import 'package:pips/domain/usecase/allusers_usecase.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';
import 'package:pips/domain/usecase/createchatroom_usecase.dart';
import 'package:pips/domain/usecase/createmessage_usecase.dart';
import 'package:pips/domain/usecase/forgot_password_usecase.dart';
import 'package:pips/domain/usecase/login_usecase.dart';
import 'package:pips/domain/usecase/logins_usecase.dart';
import 'package:pips/domain/usecase/messages_usecase.dart';
import 'package:pips/domain/usecase/notifications_usecase.dart';
import 'package:pips/domain/usecase/office_usecase.dart';
import 'package:pips/domain/usecase/offices_usecase.dart';
import 'package:pips/domain/usecase/options_usecase.dart';
import 'package:pips/domain/usecase/project_usecase.dart';
import 'package:pips/domain/usecase/projects_usecase.dart';
import 'package:pips/domain/usecase/read_notification_usecase.dart';
import 'package:pips/domain/usecase/signup_usecase.dart';
import 'package:pips/domain/usecase/updatepassword_usecase.dart';
import 'package:pips/domain/usecase/updateprofile_usecase.dart';
import 'package:pips/domain/usecase/upload_avatar_usecase.dart';
import 'package:pips/domain/usecase/users_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usecase/chatroom_usecase.dart';

const hostOptions = PusherChannelsOptions.fromHost(
  scheme: 'ws',
  // host: 'pips.da.gov.ph',
  // TODO: update settings
  host: '127.0.0.1',
  port: 6001,
  key: '1b421e8d437e47b9eee3',
);

final client = PusherChannelsClient.websocket(
  options: hostOptions,
  connectionErrorHandler: (exception, trace, refresh) {
    refresh();
  },
);

/// dependency injection for the app
final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  instance.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplementer(instance()));

  instance.registerLazySingleton<Repository>(
      () => RepositoryImplementer(instance(), instance()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // need to pass context in getDio
  final dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<Dio>(() => dio);

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  // add dio to client

  instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));

  instance.registerFactory<OptionsUseCase>(() => OptionsUseCase(instance()));

  final PusherChannelsClient wsClient = PusherWebsocketClient().init();

  // connect the client
  wsClient.connect();

  instance.registerLazySingleton<PusherChannelsClient>(() => wsClient);

  initProjectsModule();

  instance
      .registerFactory<ChatRoomsUseCase>(() => ChatRoomsUseCase(instance()));

  instance.registerFactory<ChatRoomUseCase>(() => ChatRoomUseCase(instance()));

  instance.registerFactory<CreateChatRoomUseCase>(
      () => CreateChatRoomUseCase(instance()));

  instance.registerFactory<CreateMessageUseCase>(
      () => CreateMessageUseCase(instance()));

  instance.registerFactory<MessagesUseCase>(() => MessagesUseCase(instance()));

  instance.registerFactory<NotificationsUseCase>(
      () => NotificationsUseCase(instance()));

  // await FbMessaging.init();

  instance.registerFactory<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(instance()));

  instance.registerFactory<UploadAvatarUseCase>(
      () => UploadAvatarUseCase(instance()));

  instance.registerFactory<ReadNotificationUseCase>(
      () => ReadNotificationUseCase(instance()));

  instance.registerFactory<LoginsUseCase>(() => LoginsUseCase(instance()));

  instance.registerFactory<AllUsersUseCase>(() => AllUsersUseCase(instance()));

  instance.registerFactory<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(instance()));

  instance.registerFactory<UpdatePasswordUseCase>(
      () => UpdatePasswordUseCase(instance()));

  instance
      .registerFactory<AllOfficesUseCase>(() => AllOfficesUseCase(instance()));
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

initSignUpModule() {
  if (!GetIt.I.isRegistered<SignUpUseCase>()) {
    instance.registerFactory<SignUpUseCase>(() => SignUpUseCase(instance()));
  }
}

resetModules() {
  instance.reset(dispose: false);
  initAppModule();
  initOfficesModule();
  initProjectsModule();
  initUsersModule();
  initProjectModule();
}
