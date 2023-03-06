import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/user.dart';

part 'update_profile.g.dart';

@JsonSerializable()
class UpdateProfileResponse {
  @JsonKey(name: "user")
  UserModel user;

  @JsonKey(name: "success")
  bool success;

  UpdateProfileResponse({required this.user, required this.success});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileResponseToJson(this);
}
