import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_password_response.g.dart';

@JsonSerializable()
class UpdatePasswordResponse {
  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "success")
  bool success;

  UpdatePasswordResponse({
    required this.message,
    required this.success,
  });

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordResponseToJson(this);
}
