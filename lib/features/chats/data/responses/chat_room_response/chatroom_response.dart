import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/chat_room/chat_room.dart';

part 'chatroom_response.g.dart';

@JsonSerializable()
class ChatRoomResponse {
  @JsonKey(name: "data")
  ChatRoom data;

  ChatRoomResponse({
    required this.data,
  });

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomResponseToJson(this);
}
