// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      uuid: json['uuid'] as String,
      title: json['title'] as String,
      isLocked: json['is_locked'] as bool,
      updatedAt: json['updated_at'] as String,
      totalCost: (json['total_cost'] as num?)?.toDouble(),
      pipolCode: json['pipol_code'] as String?,
      description: json['description'] as String?,
      spatialCoverage: json['spatial_coverage'] == null
          ? null
          : Attribute.fromJson(
              json['spatial_coverage'] as Map<String, dynamic>),
      office: json['office'] == null
          ? null
          : Office.fromJson(json['office'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'total_cost': instance.totalCost,
      'is_locked': instance.isLocked,
      'updated_at': instance.updatedAt,
      'pipol_code': instance.pipolCode,
      'description': instance.description,
      'spatial_coverage': instance.spatialCoverage,
      'office': instance.office,
      'user': instance.user,
    };
