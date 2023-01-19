import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "uuid")
  final String uuid;

  @JsonKey(name: "username")
  final String username;

  @JsonKey(name: "email")
  final String email;

  UserModel({
    required this.id,
    required this.uuid,
    required this.username,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
