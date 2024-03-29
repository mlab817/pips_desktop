import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/features/project/domain/models/full_project.dart';

import '../../domain/models/office.dart';
import '../../domain/models/options.dart';

class ProjectState extends StateNotifier<FullProject> {
  ProjectState() : super(FullProject());

  void update({
    String? title,
    Option? type,
    bool? regularProgram,
    String? description,
    double? totalCost,
    String? expectedOutputs,
    Option? spatialCoverage,
    DateTime? approvalLevelDate,
    Option? approvalLevel,
    bool? pip,
    Option? typology,
    bool? cip,
    Option? cipType,
    bool? iccable,
    bool? trip,
    bool? rdip,
    bool? covid,
    bool? research,
    String? risk,
    bool? rdcEndorsementRequired,
    Option? pdpChapter,
    List<Option>? pdpChapters,
    List<Option>? bases,
    List<Option>? agenda,
    List<Option>? sdgs,
    Option? gad,
    List<Option>? prerequisites,
    bool? fsNeedsAssistance,
    double? fsTotalCost,
    DateTime? fsCompletionDate,
    List<Option>? operatingUnits,
    List<Option>? locations,
    List<Option>? infrastructureSectors,
    List<Option>? fundingSources,
    List<Option>? fundingInstitutions,
    implementationModeId,
    Option? implementationMode,
    projectStatusId,
    Option? projectStatus,
    categoryId,
    Option? category,
    readinessLevelId,
    Option? readinessLevel,
    String? updates,
    DateTime? asOf,
    int? employmentGenerated,
    int? employedMale,
    int? employedFemale,
    Office? office,
    List<FsInvestment>? fsInvestments,
    List<RegionalInvestment>? regionalInvestments,
    String? remarks,
    Option? preparationDocument,
    Option? fsStatus,
    Option? fundingSource,
    bool? hasRap,
    int? rapAffectedHouseholds,
    bool? hasRow,
    int? rowAffectedHouseholds,
    bool? hasRowRap,
    Option? startYear,
    Option? endYear,
    String? uacsCode,
    bool? pureGrant,
    FinancialAccomplishment? financialAccomplishment,
    FsCost? fsCost,
    RowCost? rowCost,
    RapCost? rapCost,
    user,
  }) {
    state = state.copyWith(
      title: title ?? state.title,
      type: type ?? state.type,
      regularProgram: regularProgram ?? state.regularProgram,
      description: description ?? state.description,
      totalCost: totalCost ?? state.totalCost,
      expectedOutputs: expectedOutputs ?? state.expectedOutputs,
      spatialCoverage: spatialCoverage ?? state.spatialCoverage,
      approvalLevelDate: approvalLevelDate ?? state.approvalLevelDate,
      pip: pip ?? state.pip,
      typology: typology ?? state.typology,
      cip: cip ?? state.cip,
      cipType: cipType ?? state.cipType,
      iccable: iccable ?? state.iccable,
      trip: trip ?? state.trip,
      rdip: rdip ?? state.rdip,
      covid: covid ?? state.covid,
      research: research ?? state.research,
      categoryId: categoryId ?? state.categoryId,
      rdcEndorsementRequired:
          rdcEndorsementRequired ?? state.rdcEndorsementRequired,
      pdpChapter: pdpChapter ?? state.pdpChapter,
      pdpChapters: pdpChapters ?? state.pdpChapters,
      bases: bases ?? state.bases,
      agenda: agenda ?? state.agenda,
      sdgs: sdgs ?? state.sdgs,
      prerequisites: prerequisites ?? state.prerequisites,
      fsNeedsAssistance: fsNeedsAssistance ?? state.fsNeedsAssistance,
      fsTotalCost: fsTotalCost ?? state.fsTotalCost,
      fsCompletionDate: fsCompletionDate ?? state.fsCompletionDate,
      operatingUnits: operatingUnits ?? state.operatingUnits,
      office: office ?? state.office,
      locations: locations ?? state.locations,
      infrastructureSectors:
          infrastructureSectors ?? state.infrastructureSectors,
      fundingSources: fundingSources ?? state.fundingSources,
      fundingInstitutions: fundingInstitutions ?? state.fundingInstitutions,
      fsInvestments: fsInvestments ?? state.fsInvestments,
      regionalInvestments: regionalInvestments ?? state.regionalInvestments,
      updatedAt: state.updatedAt,
      user: state.user,
      remarks: remarks ?? state.remarks,
      preparationDocument: preparationDocument ?? state.preparationDocument,
      fsStatus: fsStatus ?? state.fsStatus,
      approvalLevel: approvalLevel ?? state.approvalLevel,
      fundingSource: fundingSource ?? state.fundingSource,
      hasRap: hasRap ?? state.hasRap,
      hasRow: hasRow ?? state.hasRow,
      hasRowRap: hasRowRap ?? state.hasRowRap,
      implementationMode: implementationMode ?? state.implementationMode,
      category: category ?? state.category,
      projectStatus: projectStatus ?? state.projectStatus,
      uacsCode: uacsCode ?? state.uacsCode,
      pureGrant: pureGrant ?? state.pureGrant,
      financialAccomplishment:
          financialAccomplishment ?? state.financialAccomplishment,
      risk: risk ?? state.risk,
      gad: gad ?? state.gad,
      asOf: asOf ?? state.asOf,
      updates: updates ?? state.updates,
      startYear: startYear ?? state.startYear,
      endYear: endYear ?? state.endYear,
      fsCost: fsCost ?? state.fsCost,
      rowCost: rowCost ?? state.rowCost,
      rapCost: rapCost ?? state.rapCost,
      rowAffectedHouseholds: rowAffectedHouseholds ?? rowAffectedHouseholds,
      rapAffectedHouseholds: rapAffectedHouseholds ?? rapAffectedHouseholds,
    );
  }

  @override
  FutureOr<FullProject> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final projectProvider =
    StateNotifierProvider.autoDispose<ProjectState, FullProject>(
        (ref) => ProjectState());
