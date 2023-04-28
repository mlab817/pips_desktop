// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullProject _$FullProjectFromJson(Map<String, dynamic> json) => FullProject(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      title: json['title'] as String?,
      typeId: json['type_id'] as int?,
      type: json['type'] == null
          ? null
          : Option.fromJson(json['type'] as Map<String, dynamic>),
      regularProgram: json['regular_program'] as bool?,
      description: json['description'] as String?,
      totalCost: (json['total_cost'] as num?)?.toDouble(),
      expectedOutputs: json['expected_outputs'] as String?,
      spatialCoverageId: json['spatial_coverage_id'] as int?,
      spatialCoverage: json['spatial_coverage'] == null
          ? null
          : Option.fromJson(json['spatial_coverage'] as Map<String, dynamic>),
      approvalLevelDate: json['approval_level_date'] == null
          ? null
          : DateTime.parse(json['approval_level_date'] as String),
      approvalLevelId: json['approval_level_id'] as int?,
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
      rdip: json['rdip'] as bool?,
      covid: json['covid'] as bool?,
      research: json['research'] as bool?,
      risk: json['risk'] as String?,
      rdcEndorsementRequired: json['rdc_endorsement_required'] as bool?,
      pdpChapterId: json['pdp_chapter_id'] as int?,
      pdpChapter: json['pdp_chapter'] == null
          ? null
          : Option.fromJson(json['pdp_chapter'] as Map<String, dynamic>),
      pdpChapters: (json['pdp_chapters'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      bases: (json['bases'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      agenda: (json['agenda'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      sdgs: (json['sdgs'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      gadId: json['gad_id'] as int?,
      gad: json['gad'] == null
          ? null
          : Option.fromJson(json['gad'] as Map<String, dynamic>),
      preparationDocumentId: json['preparation_document_id'] as int?,
      preparationDocument: json['preparation_document'] == null
          ? null
          : Option.fromJson(
              json['preparation_document'] as Map<String, dynamic>),
      fsNeedsAssistance: json['fs_needs_assistance'] as bool?,
      fsStatusId: json['fs_status_id'] as int?,
      fsStatus: json['fs_status'] == null
          ? null
          : Option.fromJson(json['fs_status'] as Map<String, dynamic>),
      fsCompletionDate: json['fs_completion_date'] == null
          ? null
          : DateTime.parse(json['fs_completion_date'] as String),
      fsTotalCost: json['fs_total_cost'] as String?,
      prerequisites: (json['prerequisites'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      operatingUnits: (json['operating_units'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      infrastructureSectors: (json['infrastructure_sectors'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      fundingSourceId: json['funding_source_id'] as int?,
      fundingSources: (json['funding_sources'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      fundingInstitutions: (json['funding_institutions'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      implementationModeId: json['implementation_mode_id'] as int?,
      projectStatusId: json['project_status_id'] as int?,
      categoryId: json['category_id'] as int?,
      readinessLevelId: json['readiness_level_id'] as int?,
      updates: json['updates'] as String?,
      asOf: json['updates_as_of'] == null
          ? null
          : DateTime.parse(json['updates_as_of'] as String),
      employmentGenerated: json['employment_generated'] as int?,
      employedMale: json['employed_male'] as int?,
      employedFemale: json['employed_female'] as int?,
      office: json['office'] == null
          ? null
          : Office.fromJson(json['office'] as Map<String, dynamic>),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      fsInvestments: (json['fs_investments'] as List<dynamic>?)
          ?.map((e) => FsInvestment.fromJson(e as Map<String, dynamic>))
          .toList(),
      regionalInvestments: (json['regional_investments'] as List<dynamic>?)
          ?.map((e) => RegionalInvestment.fromJson(e as Map<String, dynamic>))
          .toList(),
      remarks: json['remarks'] as String?,
      iccable: json['iccable'] as bool?,
      approvalLevel: json['approval_level'] == null
          ? null
          : Option.fromJson(json['approval_level'] as Map<String, dynamic>),
      fundingSource: json['funding_source'] == null
          ? null
          : Option.fromJson(json['funding_source'] as Map<String, dynamic>),
      hasRap: json['has_rap'] as bool?,
      hasRow: json['has_row'] as bool?,
      hasRowRap: json['has_row_rap'] as bool?,
      implementationMode: json['implementation_mode'] == null
          ? null
          : Option.fromJson(
              json['implementation_mode'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Option.fromJson(json['category'] as Map<String, dynamic>),
      projectStatus: json['project_status'] == null
          ? null
          : Option.fromJson(json['project_status'] as Map<String, dynamic>),
      uacsCode: json['uacs_code'] as String?,
      pureGrant: json['pure_grant'] as bool?,
      financialAccomplishment: json['financial_accomplishment'],
      startYear: json['start_year'] == null
          ? null
          : Option.fromJson(json['start_year'] as Map<String, dynamic>),
      endYear: json['end_year'] == null
          ? null
          : Option.fromJson(json['end_year'] as Map<String, dynamic>),
      fsCost: json['fs_cost'],
      rowCost: json['row_cost'],
      rapCost: json['rap_cost'],
      rowAffectedHouseholds: json['row_affected_households'],
      rapAffectedHouseholds: json['rap_affected_households'],
    )
      ..rowTotalCost = (json['row_total_cost'] as num?)?.toDouble()
      ..rapTotalCost = (json['rap_total_cost'] as num?)?.toDouble()
      ..readinessLevel = json['readiness_level'] == null
          ? null
          : Option.fromJson(json['readiness_level'] as Map<String, dynamic>)
      ..startYearId = json['start_year_id'] as int?
      ..endYearId = json['end_year_id'] as int?;

Map<String, dynamic> _$FullProjectToJson(FullProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'title': instance.title,
      'type_id': instance.typeId,
      'type': instance.type,
      'regular_program': instance.regularProgram,
      'description': instance.description,
      'total_cost': instance.totalCost,
      'expected_outputs': instance.expectedOutputs,
      'spatial_coverage_id': instance.spatialCoverageId,
      'spatial_coverage': instance.spatialCoverage,
      'approval_level_id': instance.approvalLevelId,
      'approval_level_date': instance.approvalLevelDate?.toIso8601String(),
      'pip': instance.pip,
      'typology_id': instance.typologyId,
      'typology': instance.typology,
      'cip': instance.cip,
      'iccable': instance.iccable,
      'cip_type_id': instance.cipTypeId,
      'cip_type': instance.cipType,
      'trip': instance.trip,
      'rdip': instance.rdip,
      'covid': instance.covid,
      'research': instance.research,
      'bases': instance.bases,
      'operating_units': instance.operatingUnits,
      'rdc_endorsement_required': instance.rdcEndorsementRequired,
      'pdp_chapter_id': instance.pdpChapterId,
      'pdp_chapter': instance.pdpChapter,
      'pdp_chapters': instance.pdpChapters,
      'risk': instance.risk,
      'agenda': instance.agenda,
      'sdgs': instance.sdgs,
      'gad_id': instance.gadId,
      'gad': instance.gad,
      'preparation_document_id': instance.preparationDocumentId,
      'preparation_document': instance.preparationDocument,
      'fs_needs_assistance': instance.fsNeedsAssistance,
      'fs_status_id': instance.fsStatusId,
      'fs_status': instance.fsStatus,
      'fs_total_cost': instance.fsTotalCost,
      'fs_cost': instance.fsCost,
      'fs_completion_date': instance.fsCompletionDate?.toIso8601String(),
      'has_row': instance.hasRow,
      'row_affected_households': instance.rowAffectedHouseholds,
      'row_total_cost': instance.rowTotalCost,
      'row_cost': instance.rowCost,
      'has_rap': instance.hasRap,
      'rap_affected_households': instance.rapAffectedHouseholds,
      'rap_total_cost': instance.rapTotalCost,
      'rap_cost': instance.rapCost,
      'has_row_rap': instance.hasRowRap,
      'prerequisites': instance.prerequisites,
      'locations': instance.locations,
      'infrastructure_sectors': instance.infrastructureSectors,
      'funding_institutions': instance.fundingInstitutions,
      'funding_source_id': instance.fundingSourceId,
      'funding_source': instance.fundingSource,
      'funding_sources': instance.fundingSources,
      'implementation_mode': instance.implementationMode,
      'pure_grant': instance.pureGrant,
      'fs_investments': instance.fsInvestments,
      'regional_investments': instance.regionalInvestments,
      'implementation_mode_id': instance.implementationModeId,
      'project_status_id': instance.projectStatusId,
      'category_id': instance.categoryId,
      'category': instance.category,
      'readiness_level_id': instance.readinessLevelId,
      'readiness_level': instance.readinessLevel,
      'start_year_id': instance.startYearId,
      'start_year': instance.startYear,
      'end_year_id': instance.endYearId,
      'end_year': instance.endYear,
      'updates': instance.updates,
      'updates_as_of': instance.asOf?.toIso8601String(),
      'employment_generated': instance.employmentGenerated,
      'employed_male': instance.employedMale,
      'employed_female': instance.employedFemale,
      'project_status': instance.projectStatus,
      'office': instance.office,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user': instance.user,
      'remarks': instance.remarks,
      'uacs_code': instance.uacsCode,
      'financial_accomplishment': instance.financialAccomplishment,
    };

FsInvestment _$FsInvestmentFromJson(Map<String, dynamic> json) => FsInvestment(
      fundingSourceId: json['funding_source_id'] as int,
      fundingSource:
          Option.fromJson(json['funding_source'] as Map<String, dynamic>),
      y2022: (json['y2022'] as num?)?.toDouble(),
      y2023: (json['y2023'] as num?)?.toDouble(),
      y2024: (json['y2024'] as num?)?.toDouble(),
      y2025: (json['y2025'] as num?)?.toDouble(),
      y2026: (json['y2026'] as num?)?.toDouble(),
      y2027: (json['y2027'] as num?)?.toDouble(),
      y2028: (json['y2028'] as num?)?.toDouble(),
      y2029: (json['y2029'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FsInvestmentToJson(FsInvestment instance) =>
    <String, dynamic>{
      'funding_source_id': instance.fundingSourceId,
      'funding_source': instance.fundingSource,
      'y2022': instance.y2022,
      'y2023': instance.y2023,
      'y2024': instance.y2024,
      'y2025': instance.y2025,
      'y2026': instance.y2026,
      'y2027': instance.y2027,
      'y2028': instance.y2028,
      'y2029': instance.y2029,
    };

RegionalInvestment _$RegionalInvestmentFromJson(Map<String, dynamic> json) =>
    RegionalInvestment(
      regionId: json['region_id'] as int,
      region: Option.fromJson(json['region'] as Map<String, dynamic>),
      y2022: json['y2022'] as num,
      y2023: json['y2023'] as num,
      y2024: json['y2024'] as num,
      y2025: json['y2025'] as num,
      y2026: json['y2026'] as num,
      y2027: json['y2027'] as num,
      y2028: json['y2028'] as num,
      y2029: json['y2029'] as num,
    );

Map<String, dynamic> _$RegionalInvestmentToJson(RegionalInvestment instance) =>
    <String, dynamic>{
      'region_id': instance.regionId,
      'region': instance.region,
      'y2022': instance.y2022,
      'y2023': instance.y2023,
      'y2024': instance.y2024,
      'y2025': instance.y2025,
      'y2026': instance.y2026,
      'y2027': instance.y2027,
      'y2028': instance.y2028,
      'y2029': instance.y2029,
    };

FinancialAccomplishment _$FinancialAccomplishmentFromJson(
        Map<String, dynamic> json) =>
    FinancialAccomplishment(
      nep2023: json['nep_2023'] as num,
      nep2024: json['nep_2024'] as num,
      nep2025: json['nep_2025'] as num,
      nep2026: json['nep_2026'] as num,
      nep2027: json['nep_2027'] as num,
      nep2028: json['nep_2028'] as num,
      gaa2023: json['gaa_2023'] as num,
      gaa2024: json['gaa_2024'] as num,
      gaa2025: json['gaa_2025'] as num,
      gaa2026: json['gaa_2026'] as num,
      gaa2027: json['gaa_2027'] as num,
      gaa2028: json['gaa_2028'] as num,
      disbursement2023: json['disbursement_2023'] as num,
      disbursement2024: json['disbursement_2024'] as num,
      disbursement2025: json['disbursement_2025'] as num,
      disbursement2026: json['disbursement_2026'] as num,
      disbursement2027: json['disbursement_2027'] as num,
      disbursement2028: json['disbursement_2028'] as num,
    );

Map<String, dynamic> _$FinancialAccomplishmentToJson(
        FinancialAccomplishment instance) =>
    <String, dynamic>{
      'nep_2023': instance.nep2023,
      'nep_2024': instance.nep2024,
      'nep_2025': instance.nep2025,
      'nep_2026': instance.nep2026,
      'nep_2027': instance.nep2027,
      'nep_2028': instance.nep2028,
      'gaa_2023': instance.gaa2023,
      'gaa_2024': instance.gaa2024,
      'gaa_2025': instance.gaa2025,
      'gaa_2026': instance.gaa2026,
      'gaa_2027': instance.gaa2027,
      'gaa_2028': instance.gaa2028,
      'disbursement_2023': instance.disbursement2023,
      'disbursement_2024': instance.disbursement2024,
      'disbursement_2025': instance.disbursement2025,
      'disbursement_2026': instance.disbursement2026,
      'disbursement_2027': instance.disbursement2027,
      'disbursement_2028': instance.disbursement2028,
    };

FsCost _$FsCostFromJson(Map<String, dynamic> json) => FsCost(
      y2023: json['y2023'] as num?,
      y2024: json['y2024'] as num?,
      y2025: json['y2025'] as num?,
      y2026: json['y2026'] as num?,
      y2027: json['y2027'] as num?,
      y2028: json['y2028'] as num?,
    );

Map<String, dynamic> _$FsCostToJson(FsCost instance) => <String, dynamic>{
      'y2023': instance.y2023,
      'y2024': instance.y2024,
      'y2025': instance.y2025,
      'y2026': instance.y2026,
      'y2027': instance.y2027,
      'y2028': instance.y2028,
    };

RowCost _$RowCostFromJson(Map<String, dynamic> json) => RowCost(
      y2023: json['y2023'] as num?,
      y2024: json['y2024'] as num?,
      y2025: json['y2025'] as num?,
      y2026: json['y2026'] as num?,
      y2027: json['y2027'] as num?,
      y2028: json['y2028'] as num?,
    );

Map<String, dynamic> _$RowCostToJson(RowCost instance) => <String, dynamic>{
      'y2023': instance.y2023,
      'y2024': instance.y2024,
      'y2025': instance.y2025,
      'y2026': instance.y2026,
      'y2027': instance.y2027,
      'y2028': instance.y2028,
    };

RapCost _$RapCostFromJson(Map<String, dynamic> json) => RapCost(
      y2023: json['y2023'] as num?,
      y2024: json['y2024'] as num?,
      y2025: json['y2025'] as num?,
      y2026: json['y2026'] as num?,
      y2027: json['y2027'] as num?,
      y2028: json['y2028'] as num?,
    );

Map<String, dynamic> _$RapCostToJson(RapCost instance) => <String, dynamic>{
      'y2023': instance.y2023,
      'y2024': instance.y2024,
      'y2025': instance.y2025,
      'y2026': instance.y2026,
      'y2027': instance.y2027,
      'y2028': instance.y2028,
    };
