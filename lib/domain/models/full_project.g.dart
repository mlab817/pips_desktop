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
      rdcEndorsementRequired: json['rdc_endorsement_required'] as bool,
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
      'rdc_endorsement_required': instance.rdcEndorsementRequired,
    };
