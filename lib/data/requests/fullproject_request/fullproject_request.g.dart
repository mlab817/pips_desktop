// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fullproject_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullProjectRequest _$FullProjectRequestFromJson(Map<String, dynamic> json) =>
    FullProjectRequest(
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
      approvalLevelDate: json['approval_level_date'] == null
          ? null
          : DateTime.parse(json['approval_level_date'] as String),
      approvalLevelId: json['approval_level_id'] as int?,
      pip: json['pip'] as bool?,
      typologyId: json['typology_id'] as int?,
      cip: json['cip'] as bool?,
      cipTypeId: json['cip_type_id'] as int?,
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
      pdpChapters: json['pdp_chapters'],
      bases: json['bases'],
      agenda: json['agenda'],
      sdgs: json['sdgs'],
      gadId: json['gad_id'] as int?,
      preparationDocumentId: json['preparation_document_id'] as int?,
      fsNeedsAssistance: json['fs_needs_assistance'] as bool?,
      fsStatusId: json['fs_status_id'] as int?,
      fsCompletionDate: json['fs_completion_date'] == null
          ? null
          : DateTime.parse(json['fs_completion_date'] as String),
      fsTotalCost: json['fs_total_cost'] as String?,
      prerequisites: json['prerequisites'],
      operatingUnits: json['operating_units'],
      locations: json['locations'],
      infrastructureSectors: json['infrastructure_sectors'],
      fundingSourceId: json['funding_source_id'] as int?,
      fundingSources: json['funding_sources'],
      fundingInstitutions: json['funding_institutions'],
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
      fsInvestments: json['fs_investments'],
      regionalInvestments: json['regional_investments'],
      officeId: json['office_id'] as int?,
      financialAccomplishment: json['financial_accomplishment'],
    )
      ..hasRow = json['has_row'] as bool?
      ..rowAffectedHouseholds = json['row_affected_households'] as int?
      ..rowTotalCost = (json['row_total_cost'] as num?)?.toDouble()
      ..hasRap = json['has_rap'] as bool?
      ..rapAffectedHouseholds = json['rap_affected_households'] as int?
      ..rapTotalCost = (json['rap_total_cost'] as num?)?.toDouble()
      ..hasRowRap = json['has_row_rap'] as bool?
      ..fundingSource = json['funding_source'] == null
          ? null
          : Option.fromJson(json['funding_source'] as Map<String, dynamic>)
      ..pureGrant = json['pure_grant'] as bool?
      ..startYearId = json['start_year_id'] as int?
      ..endYearId = json['end_year_id'] as int?;

Map<String, dynamic> _$FullProjectRequestToJson(FullProjectRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type_id': instance.typeId,
      'type': instance.type,
      'regular_program': instance.regularProgram,
      'description': instance.description,
      'total_cost': instance.totalCost,
      'expected_outputs': instance.expectedOutputs,
      'spatial_coverage_id': instance.spatialCoverageId,
      'approval_level_id': instance.approvalLevelId,
      'approval_level_date': instance.approvalLevelDate?.toIso8601String(),
      'pip': instance.pip,
      'typology_id': instance.typologyId,
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
      'pdp_chapter': instance.pdpChapter,
      'pdp_chapters': instance.pdpChapters,
      'risk': instance.risk,
      'agenda': instance.agenda,
      'sdgs': instance.sdgs,
      'gad_id': instance.gadId,
      'preparation_document_id': instance.preparationDocumentId,
      'fs_needs_assistance': instance.fsNeedsAssistance,
      'fs_status_id': instance.fsStatusId,
      'fs_total_cost': instance.fsTotalCost,
      'fs_completion_date': instance.fsCompletionDate?.toIso8601String(),
      'has_row': instance.hasRow,
      'row_affected_households': instance.rowAffectedHouseholds,
      'row_total_cost': instance.rowTotalCost,
      'has_rap': instance.hasRap,
      'rap_affected_households': instance.rapAffectedHouseholds,
      'rap_total_cost': instance.rapTotalCost,
      'has_row_rap': instance.hasRowRap,
      'prerequisites': instance.prerequisites,
      'locations': instance.locations,
      'infrastructure_sectors': instance.infrastructureSectors,
      'funding_institutions': instance.fundingInstitutions,
      'funding_source_id': instance.fundingSourceId,
      'funding_source': instance.fundingSource,
      'funding_sources': instance.fundingSources,
      'implementation_mode_id': instance.implementationModeId,
      'pure_grant': instance.pureGrant,
      'fs_investments': instance.fsInvestments,
      'regional_investments': instance.regionalInvestments,
      'project_status_id': instance.projectStatusId,
      'category_id': instance.categoryId,
      'readiness_level_id': instance.readinessLevelId,
      'start_year_id': instance.startYearId,
      'end_year_id': instance.endYearId,
      'updates': instance.updates,
      'updates_as_of': instance.asOf?.toIso8601String(),
      'employment_generated': instance.employmentGenerated,
      'employed_male': instance.employedMale,
      'employed_female': instance.employedFemale,
      'office_id': instance.officeId,
      'financial_accomplishment': instance.financialAccomplishment,
    };
