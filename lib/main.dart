import 'dart:io';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pips/app/app.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/data/responses/users/users_response.dart';
import 'package:pips/domain/models/user.dart';
import 'package:pips/domain/usecase/users_usecase.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:window_size/window_size.dart';

import 'domain/usecase/base_usecase.dart';
import 'firebase_options.dart';

void main() async {
  // debugPaintSizeEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(AppStrings.appName);
    setWindowMinSize(const Size(960, 600));
  }

  // initialize dependency injection
  await initAppModule();

  // loadDataFromCsv();
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(dataLoader, receivePort.sendPort);

  runApp(const MyApp());
}

void dataLoader(SendPort sendPort) async {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  final UsersUseCase useCase = instance<UsersUseCase>();

  //
  int last = 0;
  int currentPage = 1;

  final Result<UsersResponse> usersResponse =
  await useCase.execute(GetUsersRequest(perPage: 25, page: currentPage));

  // get last page
  if (usersResponse.success) {
    last = usersResponse.data?.meta.pagination.last ?? 0;
  }

  // iterate from first to last page
  while (currentPage <= last) {
    //
    final Result<UsersResponse> usersResponse =
    await useCase.execute(GetUsersRequest(perPage: 25, page: currentPage));

    if (usersResponse.success) {
      List<UserModel>? users = usersResponse.data?.data;
      last = usersResponse.data?.meta.pagination.last ?? 0;

      for (UserModel user in users!) {
        // save to realm
      }
    }
  }
}
