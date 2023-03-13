import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class UserModel with _$UserModel {
  @JsonSerializable()
  factory UserModel({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "uuid") required String uuid,
    @JsonKey(name: "username") required String username,
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "first_name") required String firstName,
    @JsonKey(name: "last_name") required String lastName,
    @JsonKey(name: "position") required String position,
    @JsonKey(name: "contact_number") required String contactNumber,
    @JsonKey(name: "image_url") String? imageUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
