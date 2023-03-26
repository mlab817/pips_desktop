import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pips/app/config.dart';
import 'package:pips/data/requests/notifications/notifications_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/requests/sign_up/sign_up_request.dart';
import 'package:pips/data/requests/update_password/update_password_request.dart';
import 'package:pips/data/requests/update_profile/update_profile_request.dart';
import 'package:pips/data/responses/all_users/all_users.dart';
import 'package:pips/data/responses/chat_rooms/chat_rooms.dart';
import 'package:pips/data/responses/forgot_password/forgot_password.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/messages/messages_response.dart';
import 'package:pips/data/responses/status/status_response.dart';
import 'package:pips/data/responses/upload_avatar/upload_avatar.dart';
import 'package:retrofit/http.dart';

import '../../domain/models/chat_room.dart';
import '../../domain/models/message.dart';
import '../requests/login/login_request.dart';
import '../responses/all_offices/all_offices_response.dart';
import '../responses/chat_room/chat_room.dart';
import '../responses/logins/logins_response.dart';
import '../responses/notifications/notifications_response.dart';
import '../responses/office_response/office_response.dart';
import '../responses/offices_response/offices_response.dart';
import '../responses/options/options_response.dart';
import '../responses/project/project_response.dart';
import '../responses/projects/projects_response.dart';
import '../responses/register/signup_response.dart';
import '../responses/update_password/update_password_response.dart';
import '../responses/update_profile/update_profile.dart';
import '../responses/users/users_response.dart';

part 'app_api.g.dart';

// note: annotation requires retrofit_generator
@RestApi(baseUrl: Config.baseApiUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

// add methods to retrieve data from api here
  @POST("/auth/login")
  Future<LoginResponse> login(@Body() LoginRequest input);

  @POST("/auth/forgot-password")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/auth/update-profile")
  Future<UpdateProfileResponse> updateProfile(
      @Body() UpdateProfileRequest input);

  @GET("/projects")
  Future<ProjectsResponse> getProjects(@Queries() GetProjectsRequest input);

  @POST("/projects")
  Future<void> createProject(); // TODO: implement

  @DELETE("/projects/{uuid}")
  Future<void> deleteProject(@Path('uuid') String uuid); // TODO: implement

  @GET("/offices")
  Future<OfficesResponse> getOffices(
      @Query('per_page') int perPage, @Query('page') int page);

  @GET("/offices/{uuid}")
  Future<OfficeResponse> getOffice(@Path('uuid') String uuid);

  @GET("/projects/{uuid}")
  Future<ProjectResponse> getProject(@Path('uuid') String uuid);

  @GET("/users")
  Future<UsersResponse> getUsers(
      @Query('per_page') int perPage, @Query('page') int page);

  @GET("/all-options")
  Future<OptionsResponse> getOptions();

  @GET("/chat-rooms")
  Future<ChatRoomsResponse> getChatRooms();

  @GET("/chat-rooms/{id}")
  Future<ChatRoomResponse> getChatRoom(@Path('id') int id);

  @POST("/chat-rooms/{id}")
  Future<Message> createMessage(
      @Path('id') int id, @Field('content') String content);

  @POST("/chat-rooms")
  Future<ChatRoom> createChatRoom(@Field('recipient_id') int id);

  @GET("/chat-rooms/{id}/messages")
  Future<MessagesResponse> listMessages(@Path('id') int id);

  @GET("/auth/notifications")
  Future<NotificationsResponse> listNotifications(
      @Body() NotificationsRequest input);

  @POST("/signup")
  Future<SignUpResponse> register(@Body() SignUpRequest formData);

  @POST("/auth/upload-avatar")
  @MultiPart()
  Future<UploadAvatarResponse> uploadAvatar(@Part(name: "avatar") File file);

  @POST("/auth/mark-notification-as-read")
  Future<StatusResponse> markNotificationAsRead(@Field("id") String id);

  @GET("/auth/logins")
  Future<LoginsResponse> getLogins();

  @GET("/chat-room")
  Future<ChatRoomResponse> getChatRoomByUserId(@Field('user_id') int userId);

  @GET("/all-users")
  Future<AllUsersResponse> getAllUsers();

  @POST("/auth/update-password")
  Future<UpdatePasswordResponse> updatePassword(
      @Body() UpdatePasswordRequest input);

  @GET("/all-offices")
  Future<AllOfficesResponse> getAllOffices();
}
