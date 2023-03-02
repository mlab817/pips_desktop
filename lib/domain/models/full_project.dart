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
  }) = _FullProject;

  factory FullProject.fromJson(Map<String, Object?> json) =>
      _$FullProjectFromJson(json);
}
