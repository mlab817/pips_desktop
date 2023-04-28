import 'package:json_annotation/json_annotation.dart';

part 'forgotpassword_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  @JsonKey(name: "status")
  String status;

  ForgotPasswordResponse({
    required this.status,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}
