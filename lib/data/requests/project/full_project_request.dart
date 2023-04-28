import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pips/features/project/domain/models/options.dart';

import '../../../features/project/domain/models/full_project.dart';

part 'full_project_request.g.dart';

@JsonSerializable()
class FullProjectRequest {
  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "type_id")
  int? typeId;

  @JsonKey(name: "type")
  Option? type;

  @JsonKey(name: "regular_program")
  bool? regularProgram;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "total_cost")
  double? totalCost;

  @JsonKey(name: "expected_outputs")
  String? expectedOutputs;

  @JsonKey(name: "spatial_coverage_id")
  int? spatialCoverageId;

  @JsonKey(name: "approval_level_id")
  int? approvalLevelId;

  @JsonKey(name: "approval_level_date")
  DateTime? approvalLevelDate;

  @JsonKey(name: "pip")
  bool? pip;

  @JsonKey(name: "typology_id")
  int? typologyId;

  @JsonKey(name: "cip")
  bool? cip;

  @JsonKey(name: "cip_type_id")
  int? cipTypeId;

  @JsonKey(name: "trip")
  bool? trip;

  @JsonKey(name: "rdip")
  bool? rdip;

  @JsonKey(name: "covid")
  bool? covid;

  @JsonKey(name: "research")
  bool? research;

  @JsonKey(name: "bases")
  List<int> bases;

  @JsonKey(name: "operating_units")
  List<int> operatingUnits;

  @JsonKey(name: "rdc_endorsement_required")
  bool? rdcEndorsementRequired;

  @JsonKey(name: "pdp_chapter_id")
  int? pdpChapterId;

  @JsonKey(name: "pdp_chapter")
  Option? pdpChapter;

  @JsonKey(name: "pdp_chapters")
  List<int> pdpChapters;

  @JsonKey(name: "risk")
  String? risk;

  @JsonKey(name: "agenda")
  List<int> agenda;

  @JsonKey(name: "sdgs")
  List<int> sdgs;

  @JsonKey(name: "gad_id")
  int? gadId;

  @JsonKey(name: "preparation_document_id")
  int? preparationDocumentId;

  @JsonKey(name: "fs_needs_assistance")
  bool? fsNeedsAssistance;

  @JsonKey(name: "fs_status_id")
  int? fsStatusId;

  @JsonKey(name: "fs_total_cost")
  String? fsTotalCost;

  @JsonKey(name: "fs_completion_date")
  DateTime? fsCompletionDate;

  @JsonKey(name: "has_row")
  bool? hasRow;

  @JsonKey(name: "row_affected_households")
  int? rowAffectedHouseholds;

  @JsonKey(name: "row_total_cost")
  double? rowTotalCost;

  @JsonKey(name: "has_rap")
  bool? hasRap;

  @JsonKey(name: "rap_affected_households")
  int? rapAffectedHouseholds;

  @JsonKey(name: "rap_total_cost")
  double? rapTotalCost;

  @JsonKey(name: "has_row_rap")
  bool? hasRowRap;

  @JsonKey(name: "prerequisites")
  List<int> prerequisites;

  @JsonKey(name: "locations")
  List<int> locations;

  @JsonKey(name: "infrastructure_sectors")
  List<int> infrastructureSectors;

  @JsonKey(name: "funding_institutions")
  List<int> fundingInstitutions;

  @JsonKey(name: "funding_source_id")
  int? fundingSourceId;

  @JsonKey(name: "funding_source")
  Option? fundingSource;

  @JsonKey(name: "funding_sources")
  List<int> fundingSources;

  @JsonKey(name: "implementation_mode_id")
  int? implementationModeId;

  @JsonKey(name: "pure_grant")
  bool? pureGrant;

  @JsonKey(name: "fs_investments")
  List<FsInvestment> fsInvestments;

  @JsonKey(name: "regional_investments")
  List<RegionalInvestment> regionalInvestments;

  @JsonKey(name: "project_status_id")
  int? projectStatusId;

  @JsonKey(name: "category_id")
  int? categoryId;

  @JsonKey(name: "readiness_level_id")
  int? readinessLevelId;

  @JsonKey(name: "start_year_id")
  int? startYearId;

  @JsonKey(name: "end_year_id")
  int? endYearId;

  @JsonKey(name: "updates")
  String? updates;

  @JsonKey(name: "updates_as_of")
  DateTime? asOf;

  @JsonKey(name: "employment_generated")
  int? employmentGenerated;

  @JsonKey(name: "employed_male")
  int? employedMale;

  @JsonKey(name: "employed_female")
  int? employedFemale;

  @JsonKey(name: "office_id")
  int? officeId;

  @JsonKey(name: "financial_accomplishment")
  FinancialAccomplishment financialAccomplishment;

  FullProjectRequest({
    this.title,
    this.typeId,
    this.type,
    this.regularProgram,
    this.description,
    this.totalCost,
    this.expectedOutputs,
    this.spatialCoverageId,
    this.approvalLevelDate,
    this.approvalLevelId,
    this.pip,
    this.typologyId,
    this.cip,
    this.cipTypeId,
    this.trip,
    this.rdip,
    this.covid,
    this.research,
    this.risk,
    this.rdcEndorsementRequired,
    this.pdpChapterId,
    this.pdpChapter,
    pdpChapters,
    bases,
    agenda,
    sdgs,
    this.gadId,
    this.preparationDocumentId,
    this.fsNeedsAssistance,
    this.fsStatusId,
    this.fsCompletionDate,
    this.fsTotalCost,
    prerequisites,
    operatingUnits,
    locations,
    infrastructureSectors,
    this.fundingSourceId,
    fundingSources,
    fundingInstitutions,
    this.implementationModeId,
    this.projectStatusId,
    this.categoryId,
    this.readinessLevelId,
    this.updates,
    this.asOf,
    this.employmentGenerated,
    this.employedMale,
    this.employedFemale,
    fsInvestments,
    regionalInvestments,
    this.officeId,
    financialAccomplishment,
  })  : infrastructureSectors = infrastructureSectors ?? [],
        fundingInstitutions = fundingInstitutions ?? [],
        pdpChapters = pdpChapters ?? [],
        bases = bases ?? [],
        agenda = agenda ?? [],
        sdgs = sdgs ?? [],
        prerequisites = prerequisites ?? [],
        operatingUnits = operatingUnits ?? [],
        locations = locations ?? [],
        fundingSources = fundingSources ?? [],
        fsInvestments = fsInvestments ?? [],
        regionalInvestments = regionalInvestments ?? [],
        financialAccomplishment = financialAccomplishment ?? [];

  factory FullProjectRequest.fromFullProject(FullProject fullProject) {
    return FullProjectRequest(
      title: fullProject.title,
      typeId: fullProject.type?.value,
      regularProgram: fullProject.regularProgram,
      description: fullProject.description,
      totalCost: fullProject.totalCost,
      expectedOutputs: fullProject.expectedOutputs,
      spatialCoverageId: fullProject.spatialCoverage?.value,
      approvalLevelDate: fullProject.approvalLevelDate,
      approvalLevelId: fullProject.approvalLevel?.value,
      pip: fullProject.pip,
      typologyId: fullProject.typology?.value,
      cip: fullProject.cip,
      cipTypeId: fullProject.cipType?.value,
      trip: fullProject.trip,
      rdip: fullProject.rdip,
      covid: fullProject.covid,
      research: fullProject.research,
      risk: fullProject.risk,
      rdcEndorsementRequired: fullProject.rdcEndorsementRequired,
      pdpChapterId: fullProject.pdpChapter?.value,
      pdpChapters: fullProject.pdpChapters.toIntList(),
      bases: fullProject.bases.toIntList(),
      agenda: fullProject.agenda.toIntList(),
      sdgs: fullProject.sdgs.toIntList(),
      gadId: fullProject.gad?.value,
      preparationDocumentId: fullProject.preparationDocument?.value,
      fsNeedsAssistance: fullProject.fsNeedsAssistance,
      fsStatusId: fullProject.fsStatus?.value,
      fsCompletionDate: fullProject.fsCompletionDate,
      fsTotalCost: fullProject.fsTotalCost,
      prerequisites: fullProject.prerequisites.toIntList(),
      operatingUnits: fullProject.operatingUnits.toIntList(),
      locations: fullProject.locations.toIntList(),
      infrastructureSectors: fullProject.infrastructureSectors.toIntList(),
      fundingSourceId: fullProject.fundingSource?.value,
      fundingSources: fullProject.fundingSources.toIntList(),
      fundingInstitutions: fullProject.fundingInstitutions.toIntList(),
      implementationModeId: fullProject.implementationMode?.value,
      projectStatusId: fullProject.projectStatus?.value,
      categoryId: fullProject.category?.value,
      readinessLevelId: fullProject.readinessLevel?.value,
      updates: fullProject.updates,
      asOf: fullProject.asOf,
      employmentGenerated: fullProject.employmentGenerated,
      employedMale: fullProject.employedMale,
      employedFemale: fullProject.employedFemale,
      fsInvestments: fullProject.fsInvestments,
      regionalInvestments: fullProject.regionalInvestments,
      officeId: fullProject.office?.id,
      financialAccomplishment: fullProject.financialAccomplishment,
    );
  }

  factory FullProjectRequest.fromJson(Map<String, Object?> json) =>
      _$FullProjectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FullProjectRequestToJson(this);
}

extension ToIntList on List<Option> {
  List<int> toIntList() {
    return map((e) => e.value).toList();
  }
}
