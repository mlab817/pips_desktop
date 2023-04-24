import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pips/data/responses/presets/presets.dart';
import 'package:pips/domain/models/office.dart';
import 'package:pips/domain/models/options.dart';
import 'package:pips/domain/models/user.dart';

import 'attribute.dart';

part 'full_project.g.dart';

@JsonSerializable()
class FullProject {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "uuid")
  String? uuid;

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

  @JsonKey(name: "spatial_coverage")
  Option? spatialCoverage;

  @JsonKey(name: "approval_level_id")
  int? approvalLevelId;

  @JsonKey(name: "approval_level", includeToJson: false)
  Option? approvalLevel;

  @JsonKey(name: "approval_level_date")
  DateTime? approvalLevelDate;

  @JsonKey(name: "pip")
  bool? pip;

  @JsonKey(name: "typology_id")
  int? typologyId;

  @JsonKey(name: "typology")
  Option? typology;

  @JsonKey(name: "cip")
  bool? cip;

  @JsonKey(name: "iccable")
  bool? iccable;

  @JsonKey(name: "cip_type_id")
  int? cipTypeId;

  @JsonKey(name: "cip_type")
  Option? cipType;

  @JsonKey(name: "trip")
  bool? trip;

  @JsonKey(name: "rdip")
  bool? rdip;

  @JsonKey(name: "covid")
  bool? covid;

  @JsonKey(name: "research")
  bool? research;

  @JsonKey(name: "bases")
  List<Option> bases;

  @JsonKey(name: "operating_units")
  List<Option> operatingUnits;

  @JsonKey(name: "rdc_endorsement_required")
  bool? rdcEndorsementRequired;

  @JsonKey(name: "pdp_chapter_id")
  int? pdpChapterId;

  @JsonKey(name: "pdp_chapter")
  Option? pdpChapter;

  @JsonKey(name: "pdp_chapters")
  List<Option> pdpChapters;

  @JsonKey(name: "risk")
  String? risk;

  @JsonKey(name: "agenda")
  List<Option> agenda;

  @JsonKey(name: "sdgs")
  List<Option> sdgs;

  @JsonKey(name: "gad_id")
  int? gadId;

  @JsonKey(name: "gad")
  Option? gad;

  @JsonKey(name: "preparation_document_id")
  int? preparationDocumentId;

  @JsonKey(name: "preparation_document")
  Option? preparationDocument;

  @JsonKey(name: "fs_needs_assistance")
  bool? fsNeedsAssistance;

  @JsonKey(name: "fs_status_id")
  int? fsStatusId;

  @JsonKey(name: "fs_status")
  Option? fsStatus;

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
  List<Option> prerequisites;

  @JsonKey(name: "locations")
  List<Option> locations;

  @JsonKey(name: "infrastructure_sectors")
  List<Option> infrastructureSectors;

  @JsonKey(name: "funding_institutions")
  List<Option> fundingInstitutions;

  @JsonKey(name: "funding_source_id")
  int? fundingSourceId;

  @JsonKey(name: "funding_source")
  Option? fundingSource;

  @JsonKey(name: "funding_sources")
  List<Option> fundingSources;

  @JsonKey(name: "implementation_mode")
  Option? implementationMode;

  @JsonKey(name: "pure_grant")
  bool? pureGrant;

  @JsonKey(name: "fs_investments")
  List<FsInvestment> fsInvestments;

  @JsonKey(name: "regional_investments")
  List<RegionalInvestment> regionalInvestments;

  @JsonKey(name: "implementation_mode_id")
  int? implementationModeId;

  @JsonKey(name: "project_status_id")
  int? projectStatusId;

  @JsonKey(name: "category_id")
  int? categoryId;

  @JsonKey(name: "category")
  Option? category;

  @JsonKey(name: "readiness_level_id")
  int? readinessLevelId;

  @JsonKey(name: "readiness_level")
  Option? readinessLevel;

  @JsonKey(name: "start_year_id")
  int? startYearId;

  @JsonKey(name: "start_year")
  Option? startYear;

  @JsonKey(name: "end_year_id")
  int? endYearId;

  @JsonKey(name: "end_year")
  Option? endYear;

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

  @JsonKey(name: "project_status")
  Option? projectStatus;

  @JsonKey(name: "office")
  Office? office;

  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  @JsonKey(name: "user")
  User? user;

  @JsonKey(name: "remarks")
  String? remarks;

  @JsonKey(name: "uacs_code")
  String? uacsCode;

  @JsonKey(name: "financial_accomplishment")
  FinancialAccomplishment financialAccomplishment;

  FullProject({
    this.id,
    this.uuid,
    this.title,
    this.typeId,
    this.type,
    this.regularProgram,
    this.description,
    this.totalCost,
    this.expectedOutputs,
    this.spatialCoverageId,
    this.spatialCoverage,
    this.approvalLevelDate,
    this.approvalLevelId,
    bool? pip,
    this.typologyId,
    this.typology,
    bool? cip,
    this.cipTypeId,
    this.cipType,
    bool? trip,
    bool? rdip,
    bool? covid,
    bool? research,
    this.risk,
    this.rdcEndorsementRequired,
    this.pdpChapterId,
    this.pdpChapter,
    List<Option>? pdpChapters,
    List<Option>? bases,
    List<Option>? agenda,
    List<Option>? sdgs,
    this.gadId,
    this.gad,
    this.preparationDocumentId,
    this.preparationDocument,
    this.fsNeedsAssistance,
    this.fsStatusId,
    this.fsStatus,
    this.fsCompletionDate,
    this.fsTotalCost,
    List<Option>? prerequisites,
    List<Option>? operatingUnits,
    List<Option>? locations,
    List<Option>? infrastructureSectors,
    this.fundingSourceId,
    List<Option>? fundingSources,
    List<Option>? fundingInstitutions,
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
    List<FsInvestment>? fsInvestments,
    List<RegionalInvestment>? regionalInvestments,
    this.remarks,
    this.iccable,
    this.approvalLevel,
    this.fundingSource,
    this.hasRap,
    this.hasRow,
    this.hasRowRap,
    this.implementationMode,
    this.category,
    this.projectStatus,
    this.uacsCode,
    this.pureGrant,
    financialAccomplishment,
    this.startYear,
    this.endYear,
  })  : pip = pip ?? false,
        cip = cip ?? false,
        trip = trip ?? false,
        rdip = rdip ?? false,
        covid = covid ?? false,
        infrastructureSectors = infrastructureSectors ?? [],
        fundingInstitutions = fundingInstitutions ?? [],
        research = research ?? false,
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
        financialAccomplishment = financialAccomplishment ??
            FinancialAccomplishment(
                nep2023: 0,
                nep2024: 0,
                nep2025: 0,
                nep2026: 0,
                nep2027: 0,
                nep2028: 0,
                gaa2023: 0,
                gaa2024: 0,
                gaa2025: 0,
                gaa2026: 0,
                gaa2027: 0,
                gaa2028: 0,
                disbursement2023: 0,
                disbursement2024: 0,
                disbursement2025: 0,
                disbursement2026: 0,
                disbursement2027: 0,
                disbursement2028: 0);

  factory FullProject.fromJson(Map<String, Object?> json) =>
      _$FullProjectFromJson(json);

  Map<String, dynamic> toJson() => _$FullProjectToJson(this);

  void applyPresets(Preset preset) {
    typeId = preset.typeId;
    type = preset.type;
    regularProgram = preset.regularProgram ?? false;
    spatialCoverageId = preset.spatialCoverageId;
    spatialCoverage = preset.spatialCoverage;
    pip = preset.pip ?? false;
    typologyId = preset.typologyId;
    typology = preset.typology;
    cip = preset.cip ?? false;
    cipTypeId = preset.cipTypeId;
    cipType = preset.cipType;
    trip = preset.trip ?? false;
    rdcEndorsementRequired = preset.rdcEndorsementRequired ?? false;
    categoryId = preset.categoryId;
    category = preset.category;
    startYearId = preset.startYearId;
    startYear = preset.startYear;
    endYearId = preset.endYearId;
    endYear = preset.endYear;
    projectStatusId = preset.projectStatusId;
    projectStatus = preset.projectStatus;
    readinessLevelId = preset.readinessLevelId;
    readinessLevel = preset.readinessLevel;
    hasRow = preset.hasRow;
    hasRap = preset.hasRap;
    hasRowRap = preset.hasRowRap;
    fundingSourceId = preset.fundingSourceId;
    fundingSource = preset.fundingSource;
    pureGrant = preset.pureGrant;
    implementationModeId = preset.implementationModeId;
    implementationMode = preset.implementationMode;
  }

  FullProject copyWith({
    id,
    uuid,
    title,
    typeId,
    type,
    regularProgram,
    description,
    totalCost,
    expectedOutputs,
    spatialCoverageId,
    spatialCoverage,
    DateTime? approvalLevelDate,
    approvalLevelId,
    pip,
    typologyId,
    typology,
    cip,
    cipTypeId,
    cipType,
    iccable,
    trip,
    rdip,
    covid,
    research,
    risk,
    rdcEndorsementRequired,
    pdpChapterId,
    pdpChapter,
    pdpChapters,
    bases,
    agenda,
    sdgs,
    gad,
    prerequisites,
    fsNeedsAssistance,
    fsTotalCost,
    fsCompletionDate,
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
    fsInvestments,
    regionalInvestments,
    remarks,
    preparationDocument,
    fsStatus,
    approvalLevel,
    fundingSource,
    hasRap,
    hasRow,
    hasRowRap,
    implementationMode,
    category,
    projectStatus,
    startYear,
    endYear,
    uacsCode,
    pureGrant,
    financialAccomplishment,
  }) =>
      FullProject(
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        typeId: typeId ?? this.typeId,
        type: type ?? this.type,
        regularProgram: regularProgram ?? this.regularProgram,
        description: description ?? this.description,
        totalCost: totalCost ?? this.totalCost,
        expectedOutputs: expectedOutputs ?? this.expectedOutputs,
        spatialCoverageId: spatialCoverageId ?? this.spatialCoverageId,
        spatialCoverage: spatialCoverage ?? this.spatialCoverage,
        approvalLevelDate: approvalLevelDate ?? this.approvalLevelDate,
        pip: pip ?? this.pip,
        typologyId: typologyId ?? this.typologyId,
        typology: typology ?? this.typology,
        cip: cip ?? this.cip,
        cipTypeId: cipTypeId ?? this.cipTypeId,
        cipType: cipType ?? this.cipType,
        iccable: iccable ?? this.iccable,
        trip: trip ?? this.trip,
        rdip: rdip ?? this.rdip,
        covid: covid ?? this.covid,
        research: research ?? this.research,
        categoryId: categoryId ?? this.categoryId,
        rdcEndorsementRequired:
            rdcEndorsementRequired ?? this.rdcEndorsementRequired,
        pdpChapterId: pdpChapterId ?? this.pdpChapterId,
        pdpChapter: pdpChapter ?? this.pdpChapter,
        pdpChapters: pdpChapters ?? this.pdpChapters,
        bases: bases ?? this.bases,
        agenda: agenda ?? this.agenda,
        sdgs: sdgs ?? this.sdgs,
        prerequisites: prerequisites ?? this.prerequisites,
        fsNeedsAssistance: fsNeedsAssistance ?? this.fsNeedsAssistance,
        fsTotalCost: fsTotalCost ?? this.fsTotalCost,
        fsCompletionDate: fsCompletionDate ?? this.fsCompletionDate,
        operatingUnits: operatingUnits ?? this.operatingUnits,
        office: office ?? this.office,
        locations: locations ?? this.locations,
        infrastructureSectors:
            infrastructureSectors ?? this.infrastructureSectors,
        fundingSources: fundingSources ?? this.fundingSources,
        fundingInstitutions: fundingInstitutions ?? this.fundingInstitutions,
        fsInvestments: fsInvestments ?? this.fsInvestments,
        regionalInvestments: regionalInvestments ?? this.regionalInvestments,
        updatedAt: updatedAt,
        user: user,
        remarks: remarks ?? this.remarks,
        preparationDocument: preparationDocument ?? this.preparationDocument,
        fsStatus: fsStatus ?? this.fsStatus,
        approvalLevel: approvalLevel ?? this.approvalLevel,
        fundingSource: fundingSource ?? this.fundingSource,
        hasRap: hasRap ?? this.hasRap,
        hasRow: hasRow ?? this.hasRow,
        hasRowRap: hasRowRap ?? this.hasRowRap,
        implementationMode: implementationMode ?? this.implementationMode,
        category: category ?? this.category,
        projectStatus: projectStatus ?? this.projectStatus,
        uacsCode: uacsCode ?? this.uacsCode,
        pureGrant: pureGrant ?? this.pureGrant,
        financialAccomplishment:
            financialAccomplishment ?? this.financialAccomplishment,
        risk: risk ?? this.risk,
        gad: gad ?? this.gad,
        asOf: asOf ?? this.asOf,
        updates: updates ?? this.updates,
        startYear: startYear ?? this.startYear,
        endYear: endYear ?? this.endYear,
      );
}

@JsonSerializable()
class FsInvestment {
  @JsonKey(name: "funding_source_id")
  int fundingSourceId;

  @JsonKey(name: "y2022")
  num y2022;

  @JsonKey(name: "y2023")
  num y2023;

  @JsonKey(name: "y2024")
  num y2024;

  @JsonKey(name: "y2025")
  num y2025;

  @JsonKey(name: "y2026")
  num y2026;

  @JsonKey(name: "y2027")
  num y2027;

  @JsonKey(name: "y2028")
  num y2028;

  @JsonKey(name: "y2029")
  num y2029;

  FsInvestment({
    required this.fundingSourceId,
    required this.y2022,
    required this.y2023,
    required this.y2024,
    required this.y2025,
    required this.y2026,
    required this.y2027,
    required this.y2028,
    required this.y2029,
  });

  factory FsInvestment.fromJson(Map<String, dynamic> json) =>
      _$FsInvestmentFromJson(json);

  Map<String, dynamic> toJson() => _$FsInvestmentToJson(this);
}

@JsonSerializable()
class RegionalInvestment {
  @JsonKey(name: "region_id")
  int regionId;

  @JsonKey(name: "y2022")
  num y2022;

  @JsonKey(name: "y2023")
  num y2023;

  @JsonKey(name: "y2024")
  num y2024;

  @JsonKey(name: "y2025")
  num y2025;

  @JsonKey(name: "y2026")
  num y2026;

  @JsonKey(name: "y2027")
  num y2027;

  @JsonKey(name: "y2028")
  num y2028;

  @JsonKey(name: "y2029")
  num y2029;

  RegionalInvestment({
    required this.regionId,
    required this.y2022,
    required this.y2023,
    required this.y2024,
    required this.y2025,
    required this.y2026,
    required this.y2027,
    required this.y2028,
    required this.y2029,
  });

  factory RegionalInvestment.fromJson(Map<String, dynamic> json) =>
      _$RegionalInvestmentFromJson(json);

  Map<String, dynamic> toJson() => _$RegionalInvestmentToJson(this);
}

@JsonSerializable()
class FinancialAccomplishment {
  @JsonKey(name: "nep_2023")
  num nep2023;

  @JsonKey(name: "nep_2024")
  num nep2024;

  @JsonKey(name: "nep_2025")
  num nep2025;

  @JsonKey(name: "nep_2026")
  num nep2026;

  @JsonKey(name: "nep_2027")
  num nep2027;

  @JsonKey(name: "nep_2028")
  num nep2028;

  @JsonKey(name: "gaa_2023")
  num gaa2023;

  @JsonKey(name: "gaa_2024")
  num gaa2024;

  @JsonKey(name: "gaa_2025")
  num gaa2025;

  @JsonKey(name: "gaa_2026")
  num gaa2026;

  @JsonKey(name: "gaa_2027")
  num gaa2027;

  @JsonKey(name: "gaa_2028")
  num gaa2028;

  @JsonKey(name: "disbursement_2023")
  num disbursement2023;

  @JsonKey(name: "disbursement_2024")
  num disbursement2024;

  @JsonKey(name: "disbursement_2025")
  num disbursement2025;

  @JsonKey(name: "disbursement_2026")
  num disbursement2026;

  @JsonKey(name: "disbursement_2027")
  num disbursement2027;

  @JsonKey(name: "disbursement_2028")
  num disbursement2028;

  FinancialAccomplishment({
    required this.nep2023,
    required this.nep2024,
    required this.nep2025,
    required this.nep2026,
    required this.nep2027,
    required this.nep2028,
    required this.gaa2023,
    required this.gaa2024,
    required this.gaa2025,
    required this.gaa2026,
    required this.gaa2027,
    required this.gaa2028,
    required this.disbursement2023,
    required this.disbursement2024,
    required this.disbursement2025,
    required this.disbursement2026,
    required this.disbursement2027,
    required this.disbursement2028,
  });

  FinancialAccomplishment copyWith({
    num? nep2023,
    num? nep2024,
    num? nep2025,
    num? nep2026,
    num? nep2027,
    num? nep2028,
    num? gaa2023,
    num? gaa2024,
    num? gaa2025,
    num? gaa2026,
    num? gaa2027,
    num? gaa2028,
    num? disbursement2023,
    num? disbursement2024,
    num? disbursement2025,
    num? disbursement2026,
    num? disbursement2027,
    num? disbursement2028,
  }) =>
      FinancialAccomplishment(
        nep2023: nep2023 ?? this.nep2023,
        nep2024: nep2024 ?? this.nep2024,
        nep2025: nep2025 ?? this.nep2025,
        nep2026: nep2026 ?? this.nep2026,
        nep2027: nep2027 ?? this.nep2027,
        nep2028: nep2028 ?? this.nep2028,
        gaa2023: gaa2023 ?? this.gaa2023,
        gaa2024: gaa2024 ?? this.gaa2024,
        gaa2025: gaa2025 ?? this.gaa2025,
        gaa2026: gaa2026 ?? this.gaa2026,
        gaa2027: gaa2027 ?? this.gaa2027,
        gaa2028: gaa2028 ?? this.gaa2028,
        disbursement2023: disbursement2023 ?? this.disbursement2023,
        disbursement2024: disbursement2024 ?? this.disbursement2024,
        disbursement2025: disbursement2025 ?? this.disbursement2025,
        disbursement2026: disbursement2026 ?? this.disbursement2026,
        disbursement2027: disbursement2027 ?? this.disbursement2027,
        disbursement2028: disbursement2028 ?? this.disbursement2028,
      );

  factory FinancialAccomplishment.fromJson(Map<String, dynamic> json) =>
      _$FinancialAccomplishmentFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialAccomplishmentToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'nep2023': nep2023,
      'nep2024': nep2024,
      'nep2025': nep2025,
      'nep2026': nep2026,
      'nep2027': nep2027,
      'nep2028': nep2028,
      'gaa2023': gaa2023,
      'gaa2024': gaa2024,
      'gaa2025': gaa2025,
      'gaa2026': gaa2026,
      'gaa2027': gaa2027,
      'gaa2028': gaa2028,
      'disbursement2023': disbursement2023,
      'disbursement2024': disbursement2024,
      'disbursement2025': disbursement2025,
      'disbursement2026': disbursement2026,
      'disbursement2027': disbursement2027,
      'disbursement2028': disbursement2028,
    };
  }
}

extension ToOption on Option {
  Attribute toOption() {
    return Attribute(name: label, id: value);
  }
}
