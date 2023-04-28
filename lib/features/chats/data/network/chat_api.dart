import 'package:dio/dio.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:retrofit/http.dart';

import '../../../../app/config.dart';
import '../../domain/models/chat_room/chat_room.dart';
import '../../domain/models/chat_rooms/chat_rooms.dart';
import '../../domain/models/message/message.dart';
import '../responses/chat_room_response/chatroom_response.dart';
import '../responses/messages_response/messages_response.dart';
import '../responses/users_response/users_response.dart';

part 'chat_api.g.dart';

@RestApi(baseUrl: Config.baseApiUrl)
abstract class ChatApi {
  factory ChatApi(Dio dio, {String baseUrl}) = _ChatApi;

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

  @GET("/chat-room")
  Future<ChatRoomResponse> getChatRoomByUserId(@Field('user_id') int userId);

  @GET("/users")
  Future<UsersResponse> getUsers(@Body() GetUsersRequest input);
}
