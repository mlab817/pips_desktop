// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FullProject _$$_FullProjectFromJson(Map<String, dynamic> json) =>
    _$_FullProject(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      title: json['title'] as String,
      typeId: json['type_id'] as int?,
      regularProgram: json['regular_program'] as bool,
      description: json['description'] as String,
      totalCost: (json['total_cost'] as num).toDouble(),
      expectedOutputs: json['expected_outputs'] as String,
      spatialCoverageId: json['spatial_coverage_id'] as int?,
      approvalLevelId: json['approval_level_id'] as int?,
      approvalLevelDate: json['approval_level_date'] as String,
      pip: json['pip'] as bool,
      pipTypologyId: json['pip_typology_id'] as int?,
      cip: json['cip'] as bool,
      cipTypeId: json['cip_type_id'] as int?,
      trip: json['trip'] as bool,
      rdip: json['rdip'] as bool,
      covid: json['covid'] as bool,
      research: json['research'] as bool,
      bases: (json['bases'] as List<dynamic>).map((e) => e as int).toList(),
      operatingUnits: (json['operating_units'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      rdcEndorsementRequired: json['rdc_endorsement_required'] as bool,
      pdpChapterId: json['pdp_chapter_id'] as int?,
      pdpChapters:
          (json['pdp_chapters'] as List<dynamic>).map((e) => e as int).toList(),
      risk: json['risk'] as String?,
      agendas: (json['agendas'] as List<dynamic>).map((e) => e as int).toList(),
      sdgs: (json['sdgs'] as List<dynamic>).map((e) => e as int).toList(),
      fundingSourceId: json['funding_source_id'] as int?,
      fundingSources: (json['funding_sources'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      implementationModeId: json['implementation_mode_id'] as int?,
      projectStatusId: json['project_status_id'] as int?,
      categoryId: json['category_id'] as int?,
      readinessLevelId: json['readiness_level_id'] as int?,
      updates: json['updates'] as String?,
      asOf: json['updates_as_of'] as String?,
      employmentGenerated: json['employment_generated'] as int?,
      employedMale: json['employed_male'] as int?,
      employedFemale: json['employed_female'] as int?,
    );

Map<String, dynamic> _$$_FullProjectToJson(_$_FullProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'title': instance.title,
      'type_id': instance.typeId,
      'regular_program': instance.regularProgram,
      'description': instance.description,
      'total_cost': instance.totalCost,
      'expected_outputs': instance.expectedOutputs,
      'spatial_coverage_id': instance.spatialCoverageId,
      'approval_level_id': instance.approvalLevelId,
      'approval_level_date': instance.approvalLevelDate,
      'pip': instance.pip,
      'pip_typology_id': instance.pipTypologyId,
      'cip': instance.cip,
      'cip_type_id': instance.cipTypeId,
      'trip': instance.trip,
      'rdip': instance.rdip,
      'covid': instance.covid,
      'research': instance.research,
      'bases': instance.bases,
      'operating_units': instance.operatingUnits,
      'rdc_endorsement_required': instance.rdcEndorsementRequired,
      'pdp_chapter_id': instance.pdpChapterId,
      'pdp_chapters': instance.pdpChapters,
      'risk': instance.risk,
      'agendas': instance.agendas,
      'sdgs': instance.sdgs,
      'funding_source_id': instance.fundingSourceId,
      'funding_sources': instance.fundingSources,
      'implementation_mode_id': instance.implementationModeId,
      'project_status_id': instance.projectStatusId,
      'category_id': instance.categoryId,
      'readiness_level_id': instance.readinessLevelId,
      'updates': instance.updates,
      'updates_as_of': instance.asOf,
      'employment_generated': instance.employmentGenerated,
      'employed_male': instance.employedMale,
      'employed_female': instance.employedFemale,
    };
