import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_avatar.g.dart';

@JsonSerializable()
class UploadAvatarResponse {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "request")
  String? request;

  UploadAvatarResponse({
    this.status,
    this.message,
    this.request,
  });

  factory UploadAvatarResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadAvatarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadAvatarResponseToJson(this);
}
