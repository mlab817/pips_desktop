import 'dart:io';

import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/requests/notifications/notifications_request.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/logins/logins_response.dart';
import 'package:pips/data/responses/messages/messages_response.dart';
import 'package:pips/data/responses/notifications/notifications_response.dart';
import 'package:pips/data/responses/office_response/office_response.dart';
import 'package:pips/data/responses/offices_response/offices_response.dart';
import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/data/responses/status/status_response.dart';
import 'package:pips/data/responses/upload_avatar/upload_avatar.dart';
import 'package:pips/domain/models/user.dart';
import 'package:pips/domain/usecase/createmessage_usecase.dart';
import 'package:pips/presentation/main/settings/screens/update_profile.dart';

import '../../data/requests/sign_up/sign_up_request.dart';
import '../../data/requests/users/get_users_request.dart';
import '../../data/responses/chat_room/chat_room.dart';
import '../../data/responses/chat_rooms/chat_rooms.dart';
import '../../data/responses/forgot_password/forgot_password.dart';
import '../../data/responses/options/options_response.dart';
import '../../data/responses/register/signup_response.dart';
import '../../data/responses/update_profile/update_profile.dart';
import '../../data/responses/users/users_response.dart';
import '../models/chat_room.dart';
import '../models/message.dart';
import '../usecase/base_usecase.dart';

/// The repository is responsible for abstracting the data access logic and providing a consistent interface for the domain layer to interact with the data.
/// This separation of concerns allows for more flexibility in terms of how the data is stored and retrieved, and makes it easier to make changes to the
/// data layer without affecting the rest of the application. Additionally, repositories allow to implement caching strategies, which is important for
/// performance and offline capabilities.

// define methods
// Future<Response> login();
abstract class Repository {
  Future<Result<LoginResponse>> login(LoginRequest input);

  Future<Result<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input);

  Future<Result<ProjectsResponse>> getProjects(GetProjectsRequest input);

  Future<Result<OfficesResponse>> getOffices(GetOfficesRequest input);

  Future<Result<OfficeResponse>> getOffice(String input); // uuid

  Future<Result<ProjectResponse>> getProject(String input);

  Future<Result<UsersResponse>> getUsers(GetUsersRequest input);

  Future<Result<OptionsResponse>> getOptions();

  Future<Result<ChatRoomsResponse>> getChatRooms();

  Future<Result<ChatRoomResponse>> getChatRoom(int input);

  Future<Result<ChatRoom>> createChatRoom(int input);

  Future<Result<Message>> createMessage(CreateMessageUseCaseInput input);

  Future<Result<MessagesResponse>> listMessages(int input);

  Future<Result<NotificationsResponse>> listNotifications(
      NotificationsRequest input);

  Future<Result<SignUpResponse>> register(SignUpRequest input);

  Future<Result<UpdateProfileResponse>> updateProfile(UserProfile input);

  Future<Result<UploadAvatarResponse>> uploadAvatar(File input);

  Future<Result<StatusResponse>> markNotificationAsRead(String input);

  Future<Result<LoginsResponse>> getLogins();

  Future<String> getBearerToken();

  Future<void> setBearerToken(String value);

  Future<void> setIsUserLoggedIn();

  Future<void> setImageUrl(String value);

  Future<String?> getImageUrl();

  Future<bool> getIsUserLoggedIn();

  Future<void> setLoggedInUser(UserModel value);

  Future<bool> getDatabaseLoaded();

  Future<void> setDatabaseLoaded();

  Future<void> resetDatabaseLoaded();
}
