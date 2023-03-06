import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "uuid")
  final String? uuid;

  @JsonKey(name: "username")
  final String username;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  @JsonKey(name: "position")
  final String? position;

  @JsonKey(name: "contact_number")
  final String? contactNumber;

  String avatar;

  UserModel({
    required this.id,
    this.uuid,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.contactNumber,
    avatar,
  }) : avatar = "${firstName?.substring(0, 1)}${lastName?.substring(0, 1)}";

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
