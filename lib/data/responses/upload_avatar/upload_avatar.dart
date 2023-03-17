import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_avatar.g.dart';

@JsonSerializable()
class UploadAvatarResponse {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "data")
  String? data;

  UploadAvatarResponse({
    this.status,
    this.data,
  });

  factory UploadAvatarResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadAvatarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadAvatarResponseToJson(this);
}
