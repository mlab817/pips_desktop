import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_password_request.g.dart';

@JsonSerializable()
class UpdatePasswordRequest {
  @JsonKey(name: "current_password")
  String currentPassword;

  @JsonKey(name: "password")
  String password;

  @JsonKey(name: "password_confirmation")
  String passwordConfirmation;

  UpdatePasswordRequest({
    required this.currentPassword,
    required this.password,
    required this.passwordConfirmation,
  });

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);
}
