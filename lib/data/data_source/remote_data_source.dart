import 'dart:io';

import 'package:pips/data/network/app_api.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/requests/notifications/notifications_request.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/requests/sign_up/sign_up_request.dart';
import 'package:pips/data/requests/update_password/update_password_request.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/data/responses/chat_rooms/chat_rooms.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/notifications/notifications_response.dart';
import 'package:pips/data/responses/options/options_response.dart';
import 'package:pips/data/responses/presets/presets.dart';
import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/data/responses/register/signup_response.dart';
import 'package:pips/data/responses/update_password/update_password_response.dart';
import 'package:pips/data/responses/upload_avatar/upload_avatar.dart';
import 'package:pips/domain/usecase/createmessage_usecase.dart';

import '../../domain/models/chat_room.dart';
import '../../domain/models/message.dart';
import '../requests/filter_project/filter_project_request.dart';
import '../requests/update_profile/update_profile_request.dart';
import '../responses/all_offices/all_offices_response.dart';
import '../responses/all_users/all_users.dart';
import '../responses/chat_room/chat_room.dart';
import '../responses/filter_project/filter_project_response.dart';
import '../responses/forgot_password/forgot_password.dart';
import '../responses/logins/logins_response.dart';
import '../responses/messages/messages_response.dart';
import '../responses/office_response/office_response.dart';
import '../responses/offices_response/offices_response.dart';
import '../responses/pips_statuses/pips_statuses_response.dart';
import '../responses/status/status_response.dart';
import '../responses/update_profile/update_profile.dart';
import '../responses/users/users_response.dart';

// declare methods to get data from remote data source
abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest input);

  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest input);

  Future<ProjectsResponse> getProjects(GetProjectsRequest input);

  Future<OfficesResponse> getOffices(GetOfficesRequest input);

  Future<OfficeResponse> getOffice(String input);

  Future<ProjectResponse> getProject(String input);

  Future<UsersResponse> getUsers(GetUsersRequest input);

  Future<OptionsResponse> getOptions();

  Future<ChatRoomsResponse> getChatRooms();

  Future<ChatRoomResponse> getChatRoom(int input);

  Future<ChatRoomResponse> getChatRoomByUserId(int input);

  Future<ChatRoom> createChatRoom(int input);

  Future<Message> createMessage(CreateMessageUseCaseInput input);

  Future<MessagesResponse> listMessages(int input);

  Future<NotificationsResponse> listNotifications(NotificationsRequest input);

  Future<SignUpResponse> register(SignUpRequest input);

  Future<UpdateProfileResponse> updateProfile(UpdateProfileRequest input);

  Future<UploadAvatarResponse> uploadAvatar(File input);

  Future<StatusResponse> markNotificationAsRead(String input);

  Future<LoginsResponse> getLogins();

  Future<AllUsersResponse> getAllUsers();

  Future<UpdatePasswordResponse> updatePassword(UpdatePasswordRequest input);

  Future<AllOfficesResponse> getAllOffices();

  Future<FilterProjectResponse> filterProjects(FilterProjectRequest input);

  Future<PipsStatusesResponse> pipsStatuses();

  Future<PresetsResponse> presets();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest input) {
    return _appServiceClient.login(input);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest input) async {
    return _appServiceClient.forgotPassword(input.email);
  }

  @override
  Future<ProjectsResponse> getProjects(GetProjectsRequest input) async {
    return await _appServiceClient.getProjects(input);
  }

  @override
  Future<OfficesResponse> getOffices(GetOfficesRequest input) async {
    return await _appServiceClient.getOffices(input.perPage, input.page);
  }

  @override
  Future<OfficeResponse> getOffice(String input) async {
    return await _appServiceClient.getOffice(input);
  }

  @override
  Future<ProjectResponse> getProject(String input) async {
    return await _appServiceClient.getProject(input);
  }

  @override
  Future<UsersResponse> getUsers(GetUsersRequest input) async {
    return await _appServiceClient.getUsers(input.perPage, input.page);
  }

  @override
  Future<OptionsResponse> getOptions() async {
    return await _appServiceClient.getOptions();
  }

  @override
  Future<ChatRoomsResponse> getChatRooms() async {
    return await _appServiceClient.getChatRooms();
  }

  @override
  Future<ChatRoomResponse> getChatRoom(int input) async {
    return await _appServiceClient.getChatRoom(input);
  }

  @override
  Future<ChatRoom> createChatRoom(int input) async {
    return await _appServiceClient.createChatRoom(input);
  }

  @override
  Future<Message> createMessage(CreateMessageUseCaseInput input) async {
    return await _appServiceClient.createMessage(input.id, input.content);
  }

  @override
  Future<MessagesResponse> listMessages(int input) async {
    return await _appServiceClient.listMessages(input);
  }

  @override
  Future<NotificationsResponse> listNotifications(
      NotificationsRequest input) async {
    return await _appServiceClient.listNotifications(input);
  }

  @override
  Future<SignUpResponse> register(SignUpRequest input) async {
    return await _appServiceClient.register(input);
  }

  @override
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest input) async {
    return await _appServiceClient.updateProfile(input);
  }

  @override
  Future<UploadAvatarResponse> uploadAvatar(File input) async {
    return await _appServiceClient.uploadAvatar(input);
  }

  @override
  Future<StatusResponse> markNotificationAsRead(String input) async {
    return await _appServiceClient.markNotificationAsRead(input);
  }

  @override
  Future<LoginsResponse> getLogins() async {
    return await _appServiceClient.getLogins();
  }

  @override
  Future<ChatRoomResponse> getChatRoomByUserId(int input) async {
    return await _appServiceClient.getChatRoomByUserId(input);
  }

  @override
  Future<AllUsersResponse> getAllUsers() async {
    return await _appServiceClient.getAllUsers();
  }

  @override
  Future<UpdatePasswordResponse> updatePassword(
      UpdatePasswordRequest input) async {
    // TODO: implement updatePassword
    return await _appServiceClient.updatePassword(input);
  }

  @override
  Future<AllOfficesResponse> getAllOffices() async {
    return await _appServiceClient.getAllOffices();
  }

  @override
  Future<FilterProjectResponse> filterProjects(
      FilterProjectRequest input) async {
    return await _appServiceClient.filterProjects(input);
  }

  @override
  Future<PipsStatusesResponse> pipsStatuses() async {
    return await _appServiceClient.pipsStatuses();
  }

  @override
  Future<PresetsResponse> presets() async {
    return await _appServiceClient.presets();
  }
}
