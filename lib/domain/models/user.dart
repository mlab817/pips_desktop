import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "uuid")
  String uuid;

  @JsonKey(name: "username")
  String username;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "first_name")
  String firstName;

  @JsonKey(name: "last_name")
  String lastName;

  @JsonKey(name: "position")
  String position;

  @JsonKey(name: "contact_number")
  String contactNumber;

  @JsonKey(name: "image_url")
  String? imageUrl;

  String? name;

  UserModel({
    required this.id,
    required this.uuid,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.contactNumber,
    this.imageUrl,
  }) : name = "$firstName $lastName";

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // manually defined
  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? position,
    String? contactNumber,
    String? imageUrl,
  }) =>
      UserModel(
        id: id,
        uuid: uuid,
        username: username,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        position: position ?? this.position,
        contactNumber: contactNumber ?? this.contactNumber,
        imageUrl: imageUrl ?? this.imageUrl,
      );
}
