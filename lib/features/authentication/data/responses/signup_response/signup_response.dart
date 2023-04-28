import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignUpResponse {
  @JsonKey(name: "status")
  String status;

  SignUpResponse({
    required this.status,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}
