import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pips/domain/models/chat_room.dart';

part 'chat_room.g.dart';

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