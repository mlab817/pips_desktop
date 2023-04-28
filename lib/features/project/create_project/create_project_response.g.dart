// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProjectResponse _$CreateProjectResponseFromJson(
        Map<String, dynamic> json) =>
    CreateProjectResponse(
      data: FullProject.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      success: json['sucess'] as bool,
    );

Map<String, dynamic> _$CreateProjectResponseToJson(
        CreateProjectResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'sucess': instance.success,
    };
