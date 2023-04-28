import 'package:freezed_annotation/freezed_annotation.dart';

import 'options.dart';

part 'presets.g.dart';

@JsonSerializable()
class PresetsResponse {
  List<Preset> data;

  PresetsResponse({
    required this.data,
  });

  factory PresetsResponse.fromJson(Map<String, dynamic> json) =>
      _$PresetsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PresetsResponseToJson(this);
}

@JsonSerializable()
class Preset {
  String name;

  String description;

  String? remarks;

  @JsonKey(name: 'type_id')
  int? typeId;

  @JsonKey(name: 'type')
  Option? type;

  @JsonKey(name: 'regular_program')
  bool? regularProgram;

  @JsonKey(name: 'spatial_coverage_id')
  int? spatialCoverageId;

  @JsonKey(name: 'spatial_coverage')
  Option? spatialCoverage;

  @JsonKey(name: 'pip')
  bool? pip;

  @JsonKey(name: 'typology_id')
  int? typologyId;

  @JsonKey(name: 'typology')
  Option? typology;

  @JsonKey(name: 'cip')
  bool? cip;

  @JsonKey(name: 'cip_type_id')
  int? cipTypeId;

  @JsonKey(name: 'cip_type')
  Option? cipType;

  @JsonKey(name: 'trip')
  bool? trip;

  @JsonKey(name: 'rdc_endorsement_required')
  bool? rdcEndorsementRequired;

  @JsonKey(name: 'category_id')
  int? categoryId;

  @JsonKey(name: 'category')
  Option? category;

  @JsonKey(name: 'start_year_id')
  int? startYearId;

  @JsonKey(name: 'start_year')
  Option? startYear;

  @JsonKey(name: 'end_year_id')
  int? endYearId;

  @JsonKey(name: 'end_year')
  Option? endYear;

  @JsonKey(name: 'project_status_id')
  int? projectStatusId;

  @JsonKey(name: 'project_status')
  Option? projectStatus;

  @JsonKey(name: 'readiness_level_id')
  int? readinessLevelId;

  @JsonKey(name: 'readiness_level')
  Option? readinessLevel;

  @JsonKey(name: 'has_row')
  bool? hasRow;

  @JsonKey(name: 'has_rap')
  bool? hasRap;

  @JsonKey(name: 'has_row_rap')
  bool? hasRowRap;

  @JsonKey(name: 'funding_source_id')
  int? fundingSourceId;

  @JsonKey(name: 'funding_source')
  Option? fundingSource;

  @JsonKey(name: 'pure_grant')
  bool? pureGrant;

  @JsonKey(name: 'implementation_mode_id')
  int? implementationModeId;

  @JsonKey(name: 'implementation_mode')
  Option? implementationMode;

  Preset({
    required this.name,
    required this.description,
    this.remarks,
    this.typeId,
    this.type,
    this.regularProgram,
    this.spatialCoverageId,
    this.spatialCoverage,
    this.pip,
    this.typologyId,
    this.typology,
    this.cip,
    this.cipTypeId,
    this.cipType,
    this.trip,
    this.rdcEndorsementRequired,
    this.categoryId,
    this.category,
    this.startYearId,
    this.startYear,
    this.endYearId,
    this.endYear,
    this.projectStatusId,
    this.projectStatus,
    this.readinessLevelId,
    this.readinessLevel,
    this.hasRow,
    this.hasRap,
    this.hasRowRap,
    this.fundingSourceId,
    this.fundingSource,
    this.pureGrant,
    this.implementationModeId,
    this.implementationMode,
  });

  factory Preset.fromJson(Map<String, dynamic> json) => _$PresetFromJson(json);

  Map<String, dynamic> toJson() => _$PresetToJson(this);
}
