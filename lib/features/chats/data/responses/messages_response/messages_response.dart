import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/message/message.dart';

part 'messages_response.g.dart';

@JsonSerializable()
class MessagesResponse {
  @JsonKey(name: "data")
  List<Message> data;

  MessagesResponse({
    required this.data,
  });

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$MessagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesResponseToJson(this);
}
