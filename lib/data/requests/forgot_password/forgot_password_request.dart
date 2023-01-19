import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable()
class ForgotPasswordRequest {
  @JsonKey(name: "email")
  String email;

  ForgotPasswordRequest({
    required this.email,
  });

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}
