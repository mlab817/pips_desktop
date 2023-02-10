import 'package:json_annotation/json_annotation.dart';
import 'package:pips/domain/models/user.dart';

import 'message.dart';

part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "created_at")
  String createdAt;

  @JsonKey(name: "updated_at")
  String updatedAt;

  @JsonKey(name: "users")
  List<UserModel>? users;

  @JsonKey(name: "messages")
  List<Message>? messages;

  ChatRoom({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.name,
    this.users,
    this.messages,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
