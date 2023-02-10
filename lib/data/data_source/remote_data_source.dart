import 'package:pips/data/network/app_api.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/data/responses/chat_rooms/chat_rooms.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/options/options_response.dart';
import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/domain/usecase/createmessage_usecase.dart';

import '../../domain/models/chat_room.dart';
import '../../domain/models/message.dart';
import '../responses/chat_room/chat_room.dart';
import '../responses/forgot_password/forgot_password.dart';
import '../responses/messages/messages_response.dart';
import '../responses/office_response/office_response.dart';
import '../responses/offices_response/offices_response.dart';
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

  Future<ChatRoom> createChatRoom(int input);

  Future<Message> createMessage(CreateMessageUseCaseInput input);

  Future<MessagesResponse> listMessages(int input);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  //
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest input) {
    return _appServiceClient.login(input.username, input.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest input) async {
    return _appServiceClient.forgotPassword(input.email);
  }

  @override
  Future<ProjectsResponse> getProjects(GetProjectsRequest input) async {
    return await _appServiceClient.getProjects(input.perPage, input.page);
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
}
