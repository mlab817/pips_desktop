import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pips/domain/models/user.dart';

import 'attribute.dart';
import 'office.dart';

part 'full_project.g.dart';

@JsonSerializable()
class FullProject {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "uuid")
  String? uuid;

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "type_id")
  int? typeId;

  @JsonKey(name: "type")
  Attribute? type;

  @JsonKey(name: "regular_program")
  bool regularProgram;

  @JsonKey(name: "description")
  String description;

  @JsonKey(name: "total_cost")
  double totalCost;

  @JsonKey(name: "expected_outputs")
  String expectedOutputs;

  @JsonKey(name: "spatial_coverage_id")
  int? spatialCoverageId;

  @JsonKey(name: "spatial_coverage")
  Attribute? spatialCoverage;

  @JsonKey(name: "approval_level_id")
  int? approvalLevelId;

  @JsonKey(name: "approval_level", includeToJson: false)
  Attribute? approvalLevel;

  @JsonKey(name: "approval_level_date")
  String? approvalLevelDate;

  @JsonKey(name: "pip")
  bool pip;

  @JsonKey(name: "pip_typology_id")
  int? pipTypologyId;

  @JsonKey(name: "pip_typology")
  Attribute? pipTypology;

  @JsonKey(name: "cip")
  bool cip;

  @JsonKey(name: "cip_type_id")
  int? cipTypeId;

  @JsonKey(name: "cip_type")
  Attribute? cipType;

  @JsonKey(name: "trip")
  bool trip;

  @JsonKey(name: "rdip")
  bool rdip;

  @JsonKey(name: "covid")
  bool covid;

  @JsonKey(name: "research")
  bool research;

  @JsonKey(name: "bases")
  List<int> bases;

  @JsonKey(name: "basis_details", includeToJson: false)
  List<Attribute>? basisDetails;

  @JsonKey(name: "operating_units")
  List<int> operatingUnits;

  @JsonKey(name: "operating_unit_details", includeToJson: false)
  List<Attribute>? operatingUnitDetails;

  @JsonKey(name: "rdc_endorsement_required")
  bool rdcEndorsementRequired;

  @JsonKey(name: "pdp_chapter_id")
  int? pdpChapterId;

  @JsonKey(name: "pdp_chapter")
  Attribute? pdpChapter;

  @JsonKey(name: "pdp_chapters")
  List<int> pdpChapters;

  @JsonKey(name: "pdp_chapter_details", includeToJson: false)
  List<Attribute>? pdpChapterDetails;

  @JsonKey(name: "risk")
  String? risk;

  @JsonKey(name: "agenda")
  List<int> agenda;

  @JsonKey(name: "agenda_details")
  List<Attribute>? agendaDetails;

  @JsonKey(name: "sdgs")
  List<int> sdgs;

  @JsonKey(name: "sdg_details")
  List<Attribute>? sdgDetails;

  @JsonKey(name: "gad_id")
  int? gadId;

  @JsonKey(name: "gad")
  Attribute? gad;

  @JsonKey(name: "preparation_document_id")
  int? preparationDocumentId;

  @JsonKey(name: "preparation_document")
  Attribute? preparationDocument;

  @JsonKey(name: "fs_needs_assistance")
  bool? fsNeedsAssistance;

  @JsonKey(name: "fs_status_id")
  int? fsStatusId;

  @JsonKey(name: "fs_status")
  Attribute? fsStatus;

  @JsonKey(name: "fs_total_cost")
  String? fsTotalCost;

  @JsonKey(name: "fs_completion_date")
  String? fsCompletionDate;

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

  @JsonKey(name: "prerequisiteDetails")
  List<Attribute>? prerequisiteDetails;

  @JsonKey(name: "locations")
  List<int> locations;

  @JsonKey(name: "location_details")
  List<Attribute>? locationDetails;

  @JsonKey(name: "infrastructure_sectors")
  List<int> infrastructureSectors;

  @JsonKey(name: "infrastructure_sector_details")
  List<Attribute>? infrastructureSectorDetails;

  @JsonKey(name: "funding_institutions")
  List<int> fundingInstitutions;

  @JsonKey(name: "funding_institution_details")
  List<Attribute>? fundingInstitutionDetails;

  @JsonKey(name: "funding_source_id")
  int? fundingSourceId;

  @JsonKey(name: "funding_sources")
  List<int> fundingSources;

  @JsonKey(name: "funding_source_details")
  List<Attribute>? fundingSourceDetails;

  @JsonKey(name: "implementation_mode_id")
  int? implementationModeId;

  @JsonKey(name: "project_status_id")
  int? projectStatusId;

  @JsonKey(name: "category_id")
  int? categoryId;

  @JsonKey(name: "readiness_level_id")
  int? readinessLevelId;

  @JsonKey(name: "updates")
  String? updates;

  @JsonKey(name: "updates_as_of")
  String? asOf;

  @JsonKey(name: "employment_generated")
  int? employmentGenerated;

  @JsonKey(name: "employed_male")
  int? employedMale;

  @JsonKey(name: "employed_female")
  int? employedFemale;

  @JsonKey(name: "office", includeToJson: false)
  Office? office;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "user")
  User? user;

  FullProject({
    this.id,
    this.uuid,
    required this.title,
    this.typeId,
    this.type,
    required this.regularProgram,
    required this.description,
    required this.totalCost,
    required this.expectedOutputs,
    required this.spatialCoverageId,
    required this.spatialCoverage,
    required this.approvalLevelDate,
    this.approvalLevelId,
    required this.pip,
    required this.pipTypologyId,
    required this.cip,
    required this.cipTypeId,
    required this.trip,
    required this.rdip,
    required this.covid,
    required this.research,
    this.risk,
    required this.rdcEndorsementRequired,
    required this.pdpChapterId,
    this.pdpChapter,
    required this.pdpChapters,
    this.pdpChapterDetails,
    required this.bases,
    this.basisDetails,
    required this.agenda,
    this.agendaDetails,
    required this.sdgs,
    this.sdgDetails,
    this.gadId,
    this.gad,
    this.preparationDocumentId,
    this.preparationDocument,
    this.fsNeedsAssistance,
    this.fsStatusId,
    this.fsStatus,
    this.fsCompletionDate,
    this.fsTotalCost,
    required this.prerequisites,
    this.prerequisiteDetails,
    required this.operatingUnits,
    this.operatingUnitDetails,
    required this.locations,
    this.locationDetails,
    required this.infrastructureSectors,
    this.infrastructureSectorDetails,
    this.fundingSourceId,
    required this.fundingSources,
    this.fundingSourceDetails,
    required this.fundingInstitutions,
    this.fundingInstitutionDetails,
    this.implementationModeId,
    this.projectStatusId,
    this.categoryId,
    this.readinessLevelId,
    this.updates,
    this.asOf,
    this.employmentGenerated,
    this.employedMale,
    this.employedFemale,
    this.office,
    this.updatedAt,
    this.user,
  });

  factory FullProject.fromJson(Map<String, Object?> json) =>
      _$FullProjectFromJson(json);

  Map<String, dynamic> toJson() => _$FullProjectToJson(this);

  FullProject copyWith({
    id,
    uuid,
    title,
    typeId,
    regularProgram,
    description,
    totalCost,
    expectedOutputs,
    spatialCoverageId,
    spatialCoverage,
    approvalLevelDate,
    approvalLevelId,
    pip,
    pipTypologyId,
    cip,
    cipTypeId,
    trip,
    rdip,
    covid,
    research,
    risk,
    rdcEndorsementRequired,
    pdpChapterId,
    pdpChapters,
    bases,
    agenda,
    sdgs,
    prerequisites,
    fsNeedsAssistance,
    fsTotalCost,
    operatingUnits,
    locations,
    infrastructureSectors,
    fundingSourceId,
    fundingSources,
    fundingInstitutions,
    implementationModeId,
    projectStatusId,
    categoryId,
    readinessLevelId,
    updates,
    asOf,
    employmentGenerated,
    employedMale,
    employedFemale,
    office,
  }) =>
      FullProject(
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        typeId: typeId ?? this.typeId,
        type: type,
        regularProgram: regularProgram ?? this.regularProgram,
        description: description ?? this.description,
        totalCost: totalCost ?? this.totalCost,
        expectedOutputs: expectedOutputs ?? this.expectedOutputs,
        spatialCoverageId: spatialCoverageId ?? this.spatialCoverageId,
        spatialCoverage: spatialCoverage ?? this.spatialCoverage,
        approvalLevelDate: approvalLevelDate ?? this.approvalLevelDate,
        pip: pip ?? this.pip,
        pipTypologyId: pipTypologyId ?? this.pipTypologyId,
        cip: cip ?? this.cip,
        cipTypeId: cipTypeId ?? this.cipTypeId,
        trip: trip ?? this.trip,
        rdip: rdip ?? this.rdip,
        covid: covid ?? this.covid,
        research: research ?? this.research,
        categoryId: categoryId ?? this.categoryId,
        rdcEndorsementRequired:
            rdcEndorsementRequired ?? this.rdcEndorsementRequired,
        pdpChapterId: pdpChapterId ?? this.pdpChapterId,
        pdpChapters: pdpChapters ?? this.pdpChapters,
        bases: bases ?? this.bases,
        agenda: agenda ?? this.agenda,
        sdgs: sdgs ?? this.sdgs,
        prerequisites: prerequisites ?? this.prerequisites,
        fsNeedsAssistance: fsNeedsAssistance ?? this.fsNeedsAssistance,
        fsTotalCost: fsTotalCost ?? this.fsTotalCost,
        operatingUnits: operatingUnits ?? this.operatingUnits,
        locations: locations ?? this.locations,
        infrastructureSectors:
            infrastructureSectors ?? this.infrastructureSectors,
        fundingSources: fundingSources ?? this.fundingSources,
        fundingInstitutions: fundingInstitutions ?? this.fundingInstitutions,
        updatedAt: updatedAt,
        user: user,
      );
}
