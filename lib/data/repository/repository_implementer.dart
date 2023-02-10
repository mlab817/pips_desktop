import 'package:flutter/material.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/data/responses/chat_room/chat_room.dart';
import 'package:pips/data/responses/forgot_password/forgot_password.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/messages/messages_response.dart';
import 'package:pips/data/responses/office_response/office_response.dart';
import 'package:pips/data/responses/offices_response/offices_response.dart';
import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/data/responses/users/users_response.dart';
import 'package:pips/domain/models/message.dart';
import 'package:pips/domain/models/user.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:pips/domain/usecase/createmessage_usecase.dart';

import '../../domain/models/chat_room.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../responses/chat_rooms/chat_rooms.dart';
import '../responses/options/options_response.dart';

// repository implementer returns result class
class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImplementer(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<LoginResponse>> login(LoginRequest input) async {
    try {
      final LoginResponse response = await _remoteDataSource.login(input);

      return Result(data: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input) async {
    try {
      final ForgotPasswordResponse response =
          await _remoteDataSource.forgotPassword(input);

      return Result(data: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  @override
  Future<String> getBearerToken() async {
    return _localDataSource.getBearerToken();
  }

  @override
  Future<bool> getDatabaseLoaded() async {
    return _localDataSource.getDatabaseLoaded();
  }

  @override
  Future<void> setDatabaseLoaded() async {
    return _localDataSource.setDatabaseLoaded();
  }

  @override
  Future<void> resetDatabaseLoaded() {
    return _localDataSource.resetDatabaseLoaded();
  }

  @override
  Future<Result<ProjectsResponse>> getProjects(GetProjectsRequest input) async {
    try {
      final ProjectsResponse response =
          await _remoteDataSource.getProjects(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<void> setBearerToken(String value) async {
    await _localDataSource.setBearerToken(value);
  }

  @override
  Future<void> setIsUserLoggedIn() async {
    await _localDataSource.setIsUserLoggedIn();
  }

  @override
  Future<bool> getIsUserLoggedIn() async {
    return _localDataSource.getIsUserLoggedIn();
  }

  @override
  Future<Result<OfficesResponse>> getOffices(GetOfficesRequest input) async {
    try {
      final OfficesResponse response =
          await _remoteDataSource.getOffices(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<OfficeResponse>> getOffice(String input) async {
    try {
      final OfficeResponse response = await _remoteDataSource.getOffice(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<ProjectResponse>> getProject(String input) async {
    try {
      final ProjectResponse response =
          await _remoteDataSource.getProject(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<void> setLoggedInUser(UserModel value) async {
    await _localDataSource.setLoggedInUser(value);
  }

  @override
  Future<Result<UsersResponse>> getUsers(GetUsersRequest input) async {
    try {
      final UsersResponse response = await _remoteDataSource.getUsers(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<OptionsResponse>> getOptions() async {
    try {
      final OptionsResponse response = await _remoteDataSource.getOptions();

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<ChatRoomsResponse>> getChatRooms() async {
    try {
      final ChatRoomsResponse response = await _remoteDataSource.getChatRooms();

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<ChatRoomResponse>> getChatRoom(int input) async {
    try {
      final ChatRoomResponse response =
          await _remoteDataSource.getChatRoom(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<ChatRoom>> createChatRoom(int input) async {
    try {
      final ChatRoom response = await _remoteDataSource.createChatRoom(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<Message>> createMessage(CreateMessageUseCaseInput input) async {
    try {
      final Message response = await _remoteDataSource.createMessage(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("error from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<MessagesResponse>> listMessages(int input) async {
    try {
      final MessagesResponse response =
          await _remoteDataSource.listMessages(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("error from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }
}
