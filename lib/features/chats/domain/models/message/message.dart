import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class MessageResponse {
  @JsonKey(name: 'message')
  Message message;

  MessageResponse({
    required this.message,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}

@JsonSerializable()
class Message {
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool? sent;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? localId;

  Message({
    required this.id,
    required this.content,
    required this.chatRoomId,
    required this.senderId,
    required this.createdAt,
    required this.updatedAt,
    this.localId,
    this.sent = true,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Message copyWith({required bool sent}) => Message(
        id: id,
        content: content,
        chatRoomId: chatRoomId,
        senderId: senderId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        sent: sent,
      );
}
