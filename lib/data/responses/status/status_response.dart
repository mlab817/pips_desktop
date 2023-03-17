import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_response.g.dart';

@JsonSerializable()
class StatusResponse {
  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: "message")
  String? message;

  StatusResponse({
    this.success,
    this.message,
  });

  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatusResponseToJson(this);
}