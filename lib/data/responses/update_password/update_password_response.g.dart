// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordResponse _$UpdatePasswordResponseFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordResponse(
      message: json['message'] as String,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$UpdatePasswordResponseToJson(
        UpdatePasswordResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
    };
