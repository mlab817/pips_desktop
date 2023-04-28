import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgotpassword_request.g.dart';

@JsonSerializable()
class ForgotPasswordRequest {
  @JsonKey(name: "email")
  String email;

  ForgotPasswordRequest({
    required this.email,
  });

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);

  ForgotPasswordRequest copyWith({String? email}) =>
      ForgotPasswordRequest(email: email ?? this.email);
}
