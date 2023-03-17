// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusResponse _$StatusResponseFromJson(Map<String, dynamic> json) =>
    StatusResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$StatusResponseToJson(StatusResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
