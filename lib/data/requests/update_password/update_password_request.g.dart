// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordRequest _$UpdatePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordRequest(
      currentPassword: json['current_password'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
    );

Map<String, dynamic> _$UpdatePasswordRequestToJson(
        UpdatePasswordRequest instance) =>
    <String, dynamic>{
      'current_password': instance.currentPassword,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
    };
