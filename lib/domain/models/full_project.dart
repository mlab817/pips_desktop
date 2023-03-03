import 'package:freezed_annotation/freezed_annotation.dart';

part 'full_project.freezed.dart';
part 'full_project.g.dart';

@freezed
class FullProject with _$FullProject {
  @JsonSerializable()
  factory FullProject({
    int? id,
    String? uuid,
    required String title,
    @JsonKey(name: "type_id") int? typeId,
    @JsonKey(name: "regular_program") required bool regularProgram,
    required String description,
    @JsonKey(name: "total_cost") required double totalCost,
    @JsonKey(name: "expected_outputs") required String expectedOutputs,
    @JsonKey(name: "spatial_coverage_id") int? spatialCoverageId,
    @JsonKey(name: "approval_level_id") int? approvalLevelId,
    @JsonKey(name: "approval_level_date") required String approvalLevelDate,
    required bool pip,
    @JsonKey(name: "pip_typology_id") int? pipTypologyId,
    required bool cip,
    @JsonKey(name: "cip_type_id") int? cipTypeId,
    required bool trip,
    required bool rdip,
    required bool covid,
    required bool research,
    required List<int> bases,
    @JsonKey(name: "operating_units") required List<int> operatingUnits,
    @JsonKey(name: "rdc_endorsement_required")
        required bool rdcEndorsementRequired,
    @JsonKey(name: "pdp_chapter_id") int? pdpChapterId,
    @JsonKey(name: "pdp_chapters") required List<int> pdpChapters,
    @JsonKey(name: "risk") String? risk,
    required List<int> agendas,
    @JsonKey(name: "funding_source_id") int? fundingSourceId,
    @JsonKey(name: "funding_sources") required List<int> fundingSources,
    @JsonKey(name: "implementation_mode_id") int? implementationModeId,
    @JsonKey(name: "project_status_id") int? projectStatusId,
    @JsonKey(name: "category_id") int? categoryId,
    @JsonKey(name: "readiness_level_id") int? readinessLevelId,
    String? updates,
    @JsonKey(name: "updates_as_of") String? asOf,
    @JsonKey(name: "employment_generated") int? employmentGenerated,
    @JsonKey(name: "employed_male") int? employedMale,
    @JsonKey(name: "employed_female") int? employedFemale,
  }) = _FullProject;

  factory FullProject.fromJson(Map<String, Object?> json) =>
      _$FullProjectFromJson(json);
}
