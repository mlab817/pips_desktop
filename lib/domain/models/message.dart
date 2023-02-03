import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(name: "content")
  String content;

  @JsonKey(name: "sender_id")
  int senderId;

  Message({
    required this.content,
    required this.senderId,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
