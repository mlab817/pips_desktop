// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresetsResponse _$PresetsResponseFromJson(Map<String, dynamic> json) =>
    PresetsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Preset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PresetsResponseToJson(PresetsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Preset _$PresetFromJson(Map<String, dynamic> json) => Preset(
      name: json['name'] as String,
      description: json['description'] as String,
      remarks: json['remarks'] as String?,
      typeId: json['type_id'] as int?,
      type: json['type'] == null
          ? null
          : Option.fromJson(json['type'] as Map<String, dynamic>),
      regularProgram: json['regular_program'] as bool?,
      spatialCoverageId: json['spatial_coverage_id'] as int?,
      spatialCoverage: json['spatial_coverage'] == null
          ? null
          : Option.fromJson(json['spatial_coverage'] as Map<String, dynamic>),
      pip: json['pip'] as bool?,
      typologyId: json['typology_id'] as int?,
      typology: json['typology'] == null
          ? null
          : Option.fromJson(json['typology'] as Map<String, dynamic>),
      cip: json['cip'] as bool?,
      cipTypeId: json['cip_type_id'] as int?,
      cipType: json['cip_type'] == null
          ? null
          : Option.fromJson(json['cip_type'] as Map<String, dynamic>),
      trip: json['trip'] as bool?,
      rdcEndorsementRequired: json['rdc_endorsement_required'] as bool?,
      categoryId: json['category_id'] as int?,
      category: json['category'] == null
          ? null
          : Option.fromJson(json['category'] as Map<String, dynamic>),
      startYearId: json['start_year_id'] as int?,
      startYear: json['start_year'] == null
          ? null
          : Option.fromJson(json['start_year'] as Map<String, dynamic>),
      endYearId: json['end_year_id'] as int?,
      endYear: json['end_year'] == null
          ? null
          : Option.fromJson(json['end_year'] as Map<String, dynamic>),
      projectStatusId: json['project_status_id'] as int?,
      projectStatus: json['project_status'] == null
          ? null
          : Option.fromJson(json['project_status'] as Map<String, dynamic>),
      readinessLevelId: json['readiness_level_id'] as int?,
      readinessLevel: json['readiness_level'] == null
          ? null
          : Option.fromJson(json['readiness_level'] as Map<String, dynamic>),
      hasRow: json['has_row'] as bool?,
      hasRap: json['has_rap'] as bool?,
      hasRowRap: json['has_row_rap'] as bool?,
      fundingSourceId: json['funding_source_id'] as int?,
      fundingSource: json['funding_source'] == null
          ? null
          : Option.fromJson(json['funding_source'] as Map<String, dynamic>),
      pureGrant: json['pure_grant'] as bool?,
      implementationModeId: json['implementation_mode_id'] as int?,
      implementationMode: json['implementation_mode'] == null
          ? null
          : Option.fromJson(
              json['implementation_mode'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PresetToJson(Preset instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'remarks': instance.remarks,
      'type_id': instance.typeId,
      'type': instance.type,
      'regular_program': instance.regularProgram,
      'spatial_coverage_id': instance.spatialCoverageId,
      'spatial_coverage': instance.spatialCoverage,
      'pip': instance.pip,
      'typology_id': instance.typologyId,
      'typology': instance.typology,
      'cip': instance.cip,
      'cip_type_id': instance.cipTypeId,
      'cip_type': instance.cipType,
      'trip': instance.trip,
      'rdc_endorsement_required': instance.rdcEndorsementRequired,
      'category_id': instance.categoryId,
      'category': instance.category,
      'start_year_id': instance.startYearId,
      'start_year': instance.startYear,
      'end_year_id': instance.endYearId,
      'end_year': instance.endYear,
      'project_status_id': instance.projectStatusId,
      'project_status': instance.projectStatus,
      'readiness_level_id': instance.readinessLevelId,
      'readiness_level': instance.readinessLevel,
      'has_row': instance.hasRow,
      'has_rap': instance.hasRap,
      'has_row_rap': instance.hasRowRap,
      'funding_source_id': instance.fundingSourceId,
      'funding_source': instance.fundingSource,
      'pure_grant': instance.pureGrant,
      'implementation_mode_id': instance.implementationModeId,
      'implementation_mode': instance.implementationMode,
    };
