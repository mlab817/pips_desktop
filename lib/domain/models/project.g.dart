// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      uuid: json['uuid'] as String,
      title: json['title'] as String,
      totalCost: (json['total_cost'] as num?)?.toDouble(),
      passesValidation: json['passes_validation'] as int,
      isLocked: json['is_locked'] as bool,
      updatedAt: json['updated_at'] as String,
      pipolCode: json['pipol_code'] as String?,
      description: json['description'] as String?,
      spatialCoverage: json['spatial_coverage'] == null
          ? null
          : Attribute.fromJson(
              json['spatial_coverage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'total_cost': instance.totalCost,
      'passes_validation': instance.passesValidation,
      'is_locked': instance.isLocked,
      'updated_at': instance.updatedAt,
      'pipol_code': instance.pipolCode,
      'description': instance.description,
      'spatial_coverage': instance.spatialCoverage,
    };
