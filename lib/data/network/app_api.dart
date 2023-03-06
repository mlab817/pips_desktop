import 'package:dio/dio.dart';
import 'package:pips/app/config.dart';
import 'package:pips/data/requests/sign_up/sign_up_request.dart';
import 'package:pips/data/responses/chat_rooms/chat_rooms.dart';
import 'package:pips/data/responses/forgot_password/forgot_password.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/messages/messages_response.dart';
import 'package:retrofit/http.dart';

import '../../domain/models/chat_room.dart';
import '../../domain/models/message.dart';
import '../../presentation/main/settings/screens/update_profile.dart';
import '../responses/chat_room/chat_room.dart';
import '../responses/notifications/notifications_response.dart';
import '../responses/office_response/office_response.dart';
import '../responses/offices_response/offices_response.dart';
import '../responses/options/options_response.dart';
import '../responses/project/project_response.dart';
import '../responses/projects/projects_response.dart';
import '../responses/register/signup_response.dart';
import '../responses/update_profile/update_profile.dart';
import '../responses/users/users_response.dart';

part 'app_api.g.dart';

// note: annotation requires retrofit_generator
@RestApi(baseUrl: Config.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

// add methods to retrieve data from api here
  @POST("/auth/login")
  Future<LoginResponse> login(
      @Field("username") String username, @Field("password") String password);

  @POST("/auth/forgot-password")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/auth/update-profile")
  Future<UpdateProfileResponse> updateProfile(@Body() UserProfile userProfile);

  @GET("/projects")
  Future<ProjectsResponse> getProjects(
      @Query('per_page') int perPage, @Query('page') int page);

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
  Future<NotificationsResponse> listNotifications();

  @POST("/signup")
  Future<SignUpResponse> register(@Body() SignUpRequest formData);
}
