import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../project/domain/models/office.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "uuid")
  String? uuid;

  @JsonKey(name: "username")
  String username;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  @JsonKey(name: "fullname")
  String? fullname;

  @JsonKey(name: "position")
  String? position;

  @JsonKey(name: "contact_number")
  String? contactNumber;

  @JsonKey(name: "image_url")
  String? imageUrl;

  String? name;

  @JsonKey(name: "office")
  Office? office;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.position,
    this.contactNumber,
    this.uuid,
    this.firstName,
    this.lastName,
    this.fullname,
    this.imageUrl,
    this.office,
  }) : name = "$firstName $lastName";

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // manually defined
  User copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? position,
    String? contactNumber,
    String? imageUrl,
  }) =>
      User(
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
