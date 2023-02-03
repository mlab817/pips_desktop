import 'package:json_annotation/json_annotation.dart';
import 'package:pips/domain/models/chat_room.dart';

part 'chat_rooms.g.dart';

@JsonSerializable()
class ChatRoomsResponse {
  @JsonKey(name: "data")
  List<ChatRoom> data;

  ChatRoomsResponse({
    required this.data,
  });

  factory ChatRoomsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomsResponseToJson(this);
}
