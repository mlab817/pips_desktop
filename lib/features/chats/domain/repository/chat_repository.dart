import 'package:dartz/dartz.dart';

import '../../../../common/data/exceptions/error_handler.dart';
import '../../../../common/data/exceptions/failure.dart';
import '../../../../data/requests/users/get_users_request.dart';
import '../../data/network/chat_api.dart';
import '../../data/responses/chat_room_response/chatroom_response.dart';
import '../../data/responses/messages_response/messages_response.dart';
import '../../data/responses/users_response/users_response.dart';
import '../models/chat_room/chat_room.dart';
import '../models/chat_rooms/chat_rooms.dart';
import '../models/message/message.dart';
import '../usecase/createmessage_usecase.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatRoomsResponse>> getChatRooms();

  Future<Either<Failure, ChatRoomResponse>> getChatRoom(int input);

  Future<Either<Failure, ChatRoom>> createChatRoom(int input);

  Future<Either<Failure, Message>> createMessage(
      CreateMessageUseCaseInput input);

  Future<Either<Failure, MessagesResponse>> listMessages(int input);

  Future<Either<Failure, ChatRoomResponse>> getChatRoomByUserId(int input);

  Future<Either<Failure, UsersResponse>> getUsers(GetUsersRequest input);
}

class ChatRepositoryImplementer implements ChatRepository {
  final ChatApi _client;

  ChatRepositoryImplementer(this._client);

  @override
  Future<Either<Failure, ChatRoomsResponse>> getChatRooms() async {
    try {
      final ChatRoomsResponse response = await _client.getChatRooms();

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ChatRoomResponse>> getChatRoom(int input) async {
    try {
      final ChatRoomResponse response = await _client.getChatRoom(input);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ChatRoom>> createChatRoom(int input) async {
    try {
      final ChatRoom response = await _client.createChatRoom(input);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, Message>> createMessage(
      CreateMessageUseCaseInput input) async {
    try {
      final Message response =
          await _client.createMessage(input.id, input.content);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, MessagesResponse>> listMessages(int input) async {
    try {
      final MessagesResponse response = await _client.listMessages(input);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ChatRoomResponse>> getChatRoomByUserId(
      int input) async {
    try {
      final ChatRoomResponse response =
          await _client.getChatRoomByUserId(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, UsersResponse>> getUsers(GetUsersRequest input) async {
    try {
      final UsersResponse response = await _client.getUsers(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
