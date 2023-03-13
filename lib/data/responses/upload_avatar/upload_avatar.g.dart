// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_avatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadAvatarResponse _$UploadAvatarResponseFromJson(
        Map<String, dynamic> json) =>
    UploadAvatarResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      request: json['request'] as String?,
    );

Map<String, dynamic> _$UploadAvatarResponseToJson(
        UploadAvatarResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'request': instance.request,
    };
