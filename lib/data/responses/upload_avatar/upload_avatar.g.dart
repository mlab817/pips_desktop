// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_avatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadAvatarResponse _$UploadAvatarResponseFromJson(
        Map<String, dynamic> json) =>
    UploadAvatarResponse(
      status: json['status'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$UploadAvatarResponseToJson(
        UploadAvatarResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
