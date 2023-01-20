import 'package:json_annotation/json_annotation.dart';
import 'package:pips/domain/models/user.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "user")
  final UserModel user;

  @JsonKey(name: "access_token")
  final String accessToken;

  LoginResponse({
    required this.user,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
