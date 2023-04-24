import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/filter_project/filter_project_request.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/requests/notifications/notifications_request.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/all_offices/all_offices_response.dart';
import 'package:pips/data/responses/all_users/all_users.dart';
import 'package:pips/data/responses/filter_project/filter_project_response.dart';
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
import 'package:pips/data/responses/upload_avatar/upload_avatar.dart';
import 'package:pips/domain/models/user.dart';
import 'package:pips/domain/usecase/createmessage_usecase.dart';

import '../../data/network/failure.dart';
import '../../data/requests/sign_up/sign_up_request.dart';
import '../../data/requests/update_password/update_password_request.dart';
import '../../data/requests/update_profile/update_profile_request.dart';
import '../../data/requests/users/get_users_request.dart';
import '../../data/responses/chat_room/chat_room.dart';
import '../../data/responses/chat_rooms/chat_rooms.dart';
import '../../data/responses/forgot_password/forgot_password.dart';
import '../../data/responses/options/options_response.dart';
import '../../data/responses/register/signup_response.dart';
import '../../data/responses/update_password/update_password_response.dart';
import '../../data/responses/update_profile/update_profile.dart';
import '../../data/responses/users/users_response.dart';
import '../models/chat_room.dart';
import '../models/message.dart';

/// The repository is responsible for abstracting the data access logic and providing a consistent interface for the domain layer to interact with the data.
/// This separation of concerns allows for more flexibility in terms of how the data is stored and retrieved, and makes it easier to make changes to the
/// data layer without affecting the rest of the application. Additionally, repositories allow to implement caching strategies, which is important for
/// performance and offline capabilities.

// define methods
// Future<Response> login();
abstract class Repository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest input);

  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input);

  Future<Either<Failure, ProjectsResponse>> getProjects(
      GetProjectsRequest input);

  Future<Either<Failure, OfficesResponse>> getOffices(GetOfficesRequest input);

  Future<Either<Failure, OfficeResponse>> getOffice(String input); // uuid

  Future<Either<Failure, ProjectResponse>> getProject(String input);

  Future<Either<Failure, UsersResponse>> getUsers(GetUsersRequest input);

  Future<Either<Failure, OptionsResponse>> getOptions();

  Future<Either<Failure, ChatRoomsResponse>> getChatRooms();

  Future<Either<Failure, ChatRoomResponse>> getChatRoom(int input);

  Future<Either<Failure, ChatRoomResponse>> getChatRoomByUserId(int input);

  Future<Either<Failure, ChatRoom>> createChatRoom(int input);

  Future<Either<Failure, Message>> createMessage(
      CreateMessageUseCaseInput input);

  Future<Either<Failure, MessagesResponse>> listMessages(int input);

  Future<Either<Failure, NotificationsResponse>> listNotifications(
      NotificationsRequest input);

  Future<Either<Failure, SignUpResponse>> register(SignUpRequest input);

  Future<Either<Failure, UpdateProfileResponse>> updateProfile(
      UpdateProfileRequest input);

  Future<Either<Failure, UploadAvatarResponse>> uploadAvatar(File input);

  Future<Either<Failure, StatusResponse>> markNotificationAsRead(String input);

  Future<Either<Failure, LoginsResponse>> getLogins();

  Future<Either<Failure, FilterProjectResponse>> filterProjects(
      FilterProjectRequest input);

  Future<Either<Failure, PipsStatusesResponse>> pipsStatuses();

  Future<String> getBearerToken();

  Future<Either<Failure, AllUsersResponse>> getAllUsers();

  Future<bool> getIsOnboardingScreenViewed();

  Future<void> setBearerToken(String value);

  Future<void> setIsUserLoggedIn();

  Future<void> setImageUrl(String value);

  Future<String?> getImageUrl();

  Future<bool> getIsUserLoggedIn();

  Future<void> setLoggedInUser(User value);

  Future<bool> getDatabaseLoaded();

  Future<void> setDatabaseLoaded();

  Future<void> resetDatabaseLoaded();

  Future<void> setIsOnboardingScreenViewed(bool value);

  Future<Either<Failure, UpdatePasswordResponse>> updatePassword(
      UpdatePasswordRequest input);

  Future<Either<Failure, AllOfficesResponse>> getAllOffices();

  Future<Either<Failure, PresetsResponse>> presets();

  Future<void> clear();

  Future<User?> getLoggedInUser();
}
