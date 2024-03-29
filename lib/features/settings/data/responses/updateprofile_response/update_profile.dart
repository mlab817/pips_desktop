import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../authentication/domain/models/user/user.dart';

part 'update_profile.g.dart';

@JsonSerializable()
class UpdateProfileResponse {
  @JsonKey(name: "user")
  User user;

  @JsonKey(name: "success")
  bool success;

  UpdateProfileResponse({required this.user, required this.success});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileResponseToJson(this);
}
