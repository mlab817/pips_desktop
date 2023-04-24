import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pips/data/requests/filter_project/filter_project_request.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/requests/notifications/notifications_request.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/requests/sign_up/sign_up_request.dart';
import 'package:pips/data/requests/update_password/update_password_request.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/data/responses/all_offices/all_offices_response.dart';
import 'package:pips/data/responses/all_users/all_users.dart';
import 'package:pips/data/responses/chat_room/chat_room.dart';
import 'package:pips/data/responses/filter_project/filter_project_response.dart';
import 'package:pips/data/responses/forgot_password/forgot_password.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/logins/logins_response.dart';
import 'package:pips/data/responses/messages/messages_response.dart';
import 'package:pips/data/responses/notifications/notifications_response.dart';
import 'package:pips/data/responses/office_response/office_response.dart';
import 'package:pips/data/responses/offices_response/offices_response.dart';
import 'package:pips/data/responses/pips_statuses/pips_statuses_response.dart';
import 'package:pips/data/responses/presets/presets.dart';
import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/data/responses/status/status_response.dart';
import 'package:pips/data/responses/update_password/update_password_response.dart';
import 'package:pips/data/responses/update_profile/update_profile.dart';
import 'package:pips/data/responses/upload_avatar/upload_avatar.dart';
import 'package:pips/data/responses/users/users_response.dart';
import 'package:pips/domain/models/message.dart';
import 'package:pips/domain/models/user.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/createmessage_usecase.dart';

import '../../domain/models/chat_room.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../requests/update_profile/update_profile_request.dart';
import '../responses/chat_rooms/chat_rooms.dart';
import '../responses/options/options_response.dart';
import '../responses/register/signup_response.dart';

// repository implementer returns result class
class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImplementer(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest input) async {
    try {
      final LoginResponse response = await _remoteDataSource.login(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input) async {
    try {
      final ForgotPasswordResponse response =
      await _remoteDataSource.forgotPassword(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
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
  Future<Either<Failure, ProjectsResponse>> getProjects(
      GetProjectsRequest input) async {
    try {
      final ProjectsResponse response =
      await _remoteDataSource.getProjects(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
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
  Future<Either<Failure, OfficesResponse>> getOffices(
      GetOfficesRequest input) async {
    try {
      final OfficesResponse response =
      await _remoteDataSource.getOffices(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, OfficeResponse>> getOffice(String input) async {
    try {
      final OfficeResponse response = await _remoteDataSource.getOffice(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, ProjectResponse>> getProject(String input) async {
    try {
      final ProjectResponse response =
      await _remoteDataSource.getProject(input);

      return Right(response);
    } catch (e) {
      debugPrint(e.toString());

      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<void> setLoggedInUser(User value) async {
    await _localDataSource.setLoggedInUser(value);
  }

  @override
  Future<Either<Failure, UsersResponse>> getUsers(GetUsersRequest input) async {
    try {
      final UsersResponse response = await _remoteDataSource.getUsers(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, OptionsResponse>> getOptions() async {
    try {
      final OptionsResponse response = await _remoteDataSource.getOptions();

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, ChatRoomsResponse>> getChatRooms() async {
    try {
      final ChatRoomsResponse response = await _remoteDataSource.getChatRooms();

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, ChatRoomResponse>> getChatRoom(int input) async {
    try {
      final ChatRoomResponse response =
      await _remoteDataSource.getChatRoom(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, ChatRoom>> createChatRoom(int input) async {
    try {
      final ChatRoom response = await _remoteDataSource.createChatRoom(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Message>> createMessage(
      CreateMessageUseCaseInput input) async {
    try {
      final Message response = await _remoteDataSource.createMessage(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, MessagesResponse>> listMessages(int input) async {
    try {
      final MessagesResponse response =
      await _remoteDataSource.listMessages(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, NotificationsResponse>> listNotifications(
      NotificationsRequest input) async {
    try {
      final NotificationsResponse response =
      await _remoteDataSource.listNotifications(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, SignUpResponse>> register(SignUpRequest input) async {
    try {
      final SignUpResponse response = await _remoteDataSource.register(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> updateProfile(
      UpdateProfileRequest input) async {
    try {
      final UpdateProfileResponse response =
      await _remoteDataSource.updateProfile(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, UploadAvatarResponse>> uploadAvatar(File input) async {
    try {
      final UploadAvatarResponse response =
      await _remoteDataSource.uploadAvatar(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> markNotificationAsRead(
      String input) async {
    try {
      final StatusResponse response =
      await _remoteDataSource.markNotificationAsRead(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<String?> getImageUrl() async {
    return _localDataSource.getImageUrl();
  }

  @override
  Future<void> setImageUrl(String value) async {
    return _localDataSource.setImageUrl(value);
  }

  @override
  Future<Either<Failure, LoginsResponse>> getLogins() async {
    try {
      final LoginsResponse response = await _remoteDataSource.getLogins();

      debugPrint("from rep imp: ${response.toString()}");

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, ChatRoomResponse>> getChatRoomByUserId(
      int input) async {
    try {
      final ChatRoomResponse response =
      await _remoteDataSource.getChatRoomByUserId(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, AllUsersResponse>> getAllUsers() async {
    try {
      final AllUsersResponse response = await _remoteDataSource.getAllUsers();

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<bool> getIsOnboardingScreenViewed() async {
    return _localDataSource.getIsOnboardingScreenViewed();
  }

  @override
  Future<void> setIsOnboardingScreenViewed(bool value) async {
    return _localDataSource.setIsOnboardingScreenViewed(value);
  }

  @override
  Future<Either<Failure, UpdatePasswordResponse>> updatePassword(
      UpdatePasswordRequest input) async {
    try {
      final UpdatePasswordResponse response =
      await _remoteDataSource.updatePassword(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, AllOfficesResponse>> getAllOffices() async {
    try {
      final AllOfficesResponse response =
      await _remoteDataSource.getAllOffices();

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<void> clear() async {
    _localDataSource.clear();
  }

  @override
  Future<User?> getLoggedInUser() async {
    return _localDataSource.getLoggedInUser();
  }

  @override
  Future<Either<Failure, FilterProjectResponse>> filterProjects(
      FilterProjectRequest input) async {
    try {
      final FilterProjectResponse response =
      await _remoteDataSource.filterProjects(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, PipsStatusesResponse>> pipsStatuses() async {
    try {
      final PipsStatusesResponse response =
      await _remoteDataSource.pipsStatuses();

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, PresetsResponse>> presets() async {
    try {
      final PresetsResponse response = await _remoteDataSource.presets();

      return Right(response);
    } catch (e) {
      debugPrint(e.toString());

      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
}
