import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: "username")
  String username;

  @JsonKey(name: "password")
  String password;

  @JsonKey(name: "onesignal_player_id")
  String? onesignalPlayerId;

  LoginRequest({
    required this.username,
    required this.password,
    this.onesignalPlayerId,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  LoginRequest copyWith({
    String? username,
    String? password,
    String? onesignalPlayerId,
  }) =>
      LoginRequest(
        username: username ?? this.username,
        password: password ?? this.password,
        onesignalPlayerId: onesignalPlayerId ?? this.onesignalPlayerId,
      );
}
