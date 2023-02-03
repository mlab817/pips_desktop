import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_message.g.dart';

@JsonSerializable()
class CreateMessageResponse {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "chat_room_id")
  final int chatRoomId;

  @JsonKey(name: "sender_id")
  final int senderId;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "updated_at")
  final String updatedAt;

  CreateMessageResponse({
    required this.id,
    required this.content,
    required this.chatRoomId,
    required this.senderId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMessageResponseToJson(this);
}
