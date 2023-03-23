import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  @JsonKey(name: "first_name")
  String firstName;

  @JsonKey(name: "last_name")
  String lastName;

  @JsonKey(name: "position")
  String position;

  @JsonKey(name: "contact_number")
  String contactNumber;

  UpdateProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.contactNumber,
  });

  UpdateProfileRequest copyWith({
    String? firstName,
    String? lastName,
    String? position,
    String? contactNumber,
  }) {
    return UpdateProfileRequest(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      position: position ?? this.position,
      contactNumber: contactNumber ?? this.contactNumber,
    );
  }

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
