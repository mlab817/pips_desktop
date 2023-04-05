// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullProject _$FullProjectFromJson(Map<String, dynamic> json) => FullProject(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      title: json['title'] as String,
      typeId: json['type_id'] as int?,
      type: json['type'] == null
          ? null
          : Attribute.fromJson(json['type'] as Map<String, dynamic>),
      regularProgram: json['regular_program'] as bool,
      description: json['description'] as String,
      totalCost: (json['total_cost'] as num).toDouble(),
      expectedOutputs: json['expected_outputs'] as String,
      spatialCoverageId: json['spatial_coverage_id'] as int?,
      spatialCoverage: json['spatial_coverage'] == null
          ? null
          : Attribute.fromJson(
              json['spatial_coverage'] as Map<String, dynamic>),
      approvalLevelDate: json['approval_level_date'] as String?,
      approvalLevelId: json['approval_level_id'] as int?,
      pip: json['pip'] as bool,
      pipTypologyId: json['pip_typology_id'] as int?,
      cip: json['cip'] as bool,
      cipTypeId: json['cip_type_id'] as int?,
      trip: json['trip'] as bool,
      rdip: json['rdip'] as bool,
      covid: json['covid'] as bool,
      research: json['research'] as bool,
      risk: json['risk'] as String?,
      rdcEndorsementRequired: json['rdc_endorsement_required'] as bool,
      pdpChapterId: json['pdp_chapter_id'] as int?,
      pdpChapter: json['pdp_chapter'] == null
          ? null
          : Attribute.fromJson(json['pdp_chapter'] as Map<String, dynamic>),
      pdpChapters:
          (json['pdp_chapters'] as List<dynamic>).map((e) => e as int).toList(),
      pdpChapterDetails: (json['pdp_chapter_details'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      bases: (json['bases'] as List<dynamic>).map((e) => e as int).toList(),
      basisDetails: (json['basis_details'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      agenda: (json['agenda'] as List<dynamic>).map((e) => e as int).toList(),
      agendaDetails: (json['agenda_details'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      sdgs: (json['sdgs'] as List<dynamic>).map((e) => e as int).toList(),
      sdgDetails: (json['sdg_details'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      gadId: json['gad_id'] as int?,
      gad: json['gad'] == null
          ? null
          : Attribute.fromJson(json['gad'] as Map<String, dynamic>),
      preparationDocumentId: json['preparation_document_id'] as int?,
      preparationDocument: json['preparation_document'] == null
          ? null
          : Attribute.fromJson(
              json['preparation_document'] as Map<String, dynamic>),
      fsNeedsAssistance: json['fs_needs_assistance'] as bool?,
      fsStatusId: json['fs_status_id'] as int?,
      fsStatus: json['fs_status'] == null
          ? null
          : Attribute.fromJson(json['fs_status'] as Map<String, dynamic>),
      fsCompletionDate: json['fs_completion_date'] as String?,
      fsTotalCost: json['fs_total_cost'] as String?,
      prerequisites: (json['prerequisites'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      prerequisiteDetails: (json['prerequisiteDetails'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      operatingUnits: (json['operating_units'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      operatingUnitDetails: (json['operating_unit_details'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      locations:
          (json['locations'] as List<dynamic>).map((e) => e as int).toList(),
      locationDetails: (json['location_details'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      infrastructureSectors: (json['infrastructure_sectors'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      infrastructureSectorDetails:
          (json['infrastructure_sector_details'] as List<dynamic>?)
              ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
              .toList(),
      fundingSourceId: json['funding_source_id'] as int?,
      fundingSources: (json['funding_sources'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      fundingSourceDetails: (json['funding_source_details'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      fundingInstitutions: (json['funding_institutions'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      fundingInstitutionDetails:
          (json['funding_institution_details'] as List<dynamic>?)
              ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
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
      office: json['office'] == null
          ? null
          : Office.fromJson(json['office'] as Map<String, dynamic>),
      updatedAt: json['updated_at'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    )
      ..approvalLevel = json['approval_level'] == null
          ? null
          : Attribute.fromJson(json['approval_level'] as Map<String, dynamic>)
      ..pipTypology = json['pip_typology'] == null
          ? null
          : Attribute.fromJson(json['pip_typology'] as Map<String, dynamic>)
      ..cipType = json['cip_type'] == null
          ? null
          : Attribute.fromJson(json['cip_type'] as Map<String, dynamic>)
      ..hasRow = json['has_row'] as bool?
      ..rowAffectedHouseholds = json['row_affected_households'] as int?
      ..rowTotalCost = (json['row_total_cost'] as num?)?.toDouble()
      ..hasRap = json['has_rap'] as bool?
      ..rapAffectedHouseholds = json['rap_affected_households'] as int?
      ..rapTotalCost = (json['rap_total_cost'] as num?)?.toDouble()
      ..hasRowRap = json['has_row_rap'] as bool?;

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
      'approval_level_date': instance.approvalLevelDate,
      'pip': instance.pip,
      'pip_typology_id': instance.pipTypologyId,
      'pip_typology': instance.pipTypology,
      'cip': instance.cip,
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
      'agenda_details': instance.agendaDetails,
      'sdgs': instance.sdgs,
      'sdg_details': instance.sdgDetails,
      'gad_id': instance.gadId,
      'gad': instance.gad,
      'preparation_document_id': instance.preparationDocumentId,
      'preparation_document': instance.preparationDocument,
      'fs_needs_assistance': instance.fsNeedsAssistance,
      'fs_status_id': instance.fsStatusId,
      'fs_status': instance.fsStatus,
      'fs_total_cost': instance.fsTotalCost,
      'fs_completion_date': instance.fsCompletionDate,
      'has_row': instance.hasRow,
      'row_affected_households': instance.rowAffectedHouseholds,
      'row_total_cost': instance.rowTotalCost,
      'has_rap': instance.hasRap,
      'rap_affected_households': instance.rapAffectedHouseholds,
      'rap_total_cost': instance.rapTotalCost,
      'has_row_rap': instance.hasRowRap,
      'prerequisites': instance.prerequisites,
      'prerequisiteDetails': instance.prerequisiteDetails,
      'locations': instance.locations,
      'location_details': instance.locationDetails,
      'infrastructure_sectors': instance.infrastructureSectors,
      'infrastructure_sector_details': instance.infrastructureSectorDetails,
      'funding_institutions': instance.fundingInstitutions,
      'funding_institution_details': instance.fundingInstitutionDetails,
      'funding_source_id': instance.fundingSourceId,
      'funding_sources': instance.fundingSources,
      'funding_source_details': instance.fundingSourceDetails,
      'implementation_mode_id': instance.implementationModeId,
      'project_status_id': instance.projectStatusId,
      'category_id': instance.categoryId,
      'readiness_level_id': instance.readinessLevelId,
      'updates': instance.updates,
      'updates_as_of': instance.asOf,
      'employment_generated': instance.employmentGenerated,
      'employed_male': instance.employedMale,
      'employed_female': instance.employedFemale,
      'updated_at': instance.updatedAt,
      'user': instance.user,
    };
