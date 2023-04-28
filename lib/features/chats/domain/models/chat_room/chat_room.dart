import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../authentication/domain/models/user/user.dart';
import '../message/message.dart';

part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "messages")
  List<Message> messages;

  @JsonKey(name: "users")
  List<User> users;

  @JsonKey(name: "last_message")
  Message? lastMessage;

  ChatRoom({
    required this.id,
    required this.messages,
    required this.users,
    this.lastMessage,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
