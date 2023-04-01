// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pips_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PipsStatus _$PipsStatusFromJson(Map<String, dynamic> json) => PipsStatus(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      projectsCount: json['projects_count'] as int,
    );

Map<String, dynamic> _$PipsStatusToJson(PipsStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'projects_count': instance.projectsCount,
    };
