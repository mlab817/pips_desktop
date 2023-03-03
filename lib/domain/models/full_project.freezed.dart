// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'full_project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FullProject _$FullProjectFromJson(Map<String, dynamic> json) {
  return _FullProject.fromJson(json);
}

/// @nodoc
mixin _$FullProject {
  int? get id => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "type_id")
  int? get typeId => throw _privateConstructorUsedError;
  @JsonKey(name: "regular_program")
  bool get regularProgram => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: "total_cost")
  double get totalCost => throw _privateConstructorUsedError;
  @JsonKey(name: "expected_outputs")
  String get expectedOutputs => throw _privateConstructorUsedError;
  @JsonKey(name: "spatial_coverage_id")
  int? get spatialCoverageId => throw _privateConstructorUsedError;
  @JsonKey(name: "approval_level_id")
  int? get approvalLevelId => throw _privateConstructorUsedError;
  @JsonKey(name: "approval_level_date")
  String get approvalLevelDate => throw _privateConstructorUsedError;
  bool get pip => throw _privateConstructorUsedError;
  @JsonKey(name: "pip_typology_id")
  int? get pipTypologyId => throw _privateConstructorUsedError;
  bool get cip => throw _privateConstructorUsedError;
  @JsonKey(name: "cip_type_id")
  int? get cipTypeId => throw _privateConstructorUsedError;
  bool get trip => throw _privateConstructorUsedError;
  bool get rdip => throw _privateConstructorUsedError;
  bool get covid => throw _privateConstructorUsedError;
  bool get research => throw _privateConstructorUsedError;
  List<int> get bases => throw _privateConstructorUsedError;
  @JsonKey(name: "operating_units")
  List<int> get operatingUnits => throw _privateConstructorUsedError;
  @JsonKey(name: "rdc_endorsement_required")
  bool get rdcEndorsementRequired => throw _privateConstructorUsedError;
  @JsonKey(name: "pdp_chapter_id")
  int? get pdpChapterId => throw _privateConstructorUsedError;
  @JsonKey(name: "pdp_chapters")
  List<int> get pdpChapters => throw _privateConstructorUsedError;
  @JsonKey(name: "risk")
  String? get risk => throw _privateConstructorUsedError;
  List<int> get agendas => throw _privateConstructorUsedError;
  @JsonKey(name: "funding_source_id")
  int? get fundingSourceId => throw _privateConstructorUsedError;
  @JsonKey(name: "funding_sources")
  List<int> get fundingSources => throw _privateConstructorUsedError;
  @JsonKey(name: "implementation_mode_id")
  int? get implementationModeId => throw _privateConstructorUsedError;
  @JsonKey(name: "project_status_id")
  int? get projectStatusId => throw _privateConstructorUsedError;
  @JsonKey(name: "category_id")
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: "readiness_level_id")
  int? get readinessLevelId => throw _privateConstructorUsedError;
  String? get updates => throw _privateConstructorUsedError;
  @JsonKey(name: "updates_as_of")
  String? get asOf => throw _privateConstructorUsedError;
  @JsonKey(name: "employment_generated")
  int? get employmentGenerated => throw _privateConstructorUsedError;
  @JsonKey(name: "employed_male")
  int? get employedMale => throw _privateConstructorUsedError;
  @JsonKey(name: "employed_female")
  int? get employedFemale => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FullProjectCopyWith<FullProject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullProjectCopyWith<$Res> {
  factory $FullProjectCopyWith(
          FullProject value, $Res Function(FullProject) then) =
      _$FullProjectCopyWithImpl<$Res, FullProject>;
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String title,
      @JsonKey(name: "type_id") int? typeId,
      @JsonKey(name: "regular_program") bool regularProgram,
      String description,
      @JsonKey(name: "total_cost") double totalCost,
      @JsonKey(name: "expected_outputs") String expectedOutputs,
      @JsonKey(name: "spatial_coverage_id") int? spatialCoverageId,
      @JsonKey(name: "approval_level_id") int? approvalLevelId,
      @JsonKey(name: "approval_level_date") String approvalLevelDate,
      bool pip,
      @JsonKey(name: "pip_typology_id") int? pipTypologyId,
      bool cip,
      @JsonKey(name: "cip_type_id") int? cipTypeId,
      bool trip,
      bool rdip,
      bool covid,
      bool research,
      List<int> bases,
      @JsonKey(name: "operating_units") List<int> operatingUnits,
      @JsonKey(name: "rdc_endorsement_required") bool rdcEndorsementRequired,
      @JsonKey(name: "pdp_chapter_id") int? pdpChapterId,
      @JsonKey(name: "pdp_chapters") List<int> pdpChapters,
      @JsonKey(name: "risk") String? risk,
      List<int> agendas,
      @JsonKey(name: "funding_source_id") int? fundingSourceId,
      @JsonKey(name: "funding_sources") List<int> fundingSources,
      @JsonKey(name: "implementation_mode_id") int? implementationModeId,
      @JsonKey(name: "project_status_id") int? projectStatusId,
      @JsonKey(name: "category_id") int? categoryId,
      @JsonKey(name: "readiness_level_id") int? readinessLevelId,
      String? updates,
      @JsonKey(name: "updates_as_of") String? asOf,
      @JsonKey(name: "employment_generated") int? employmentGenerated,
      @JsonKey(name: "employed_male") int? employedMale,
      @JsonKey(name: "employed_female") int? employedFemale});
}

/// @nodoc
class _$FullProjectCopyWithImpl<$Res, $Val extends FullProject>
    implements $FullProjectCopyWith<$Res> {
  _$FullProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? title = null,
    Object? typeId = freezed,
    Object? regularProgram = null,
    Object? description = null,
    Object? totalCost = null,
    Object? expectedOutputs = null,
    Object? spatialCoverageId = freezed,
    Object? approvalLevelId = freezed,
    Object? approvalLevelDate = null,
    Object? pip = null,
    Object? pipTypologyId = freezed,
    Object? cip = null,
    Object? cipTypeId = freezed,
    Object? trip = null,
    Object? rdip = null,
    Object? covid = null,
    Object? research = null,
    Object? bases = null,
    Object? operatingUnits = null,
    Object? rdcEndorsementRequired = null,
    Object? pdpChapterId = freezed,
    Object? pdpChapters = null,
    Object? risk = freezed,
    Object? agendas = null,
    Object? fundingSourceId = freezed,
    Object? fundingSources = null,
    Object? implementationModeId = freezed,
    Object? projectStatusId = freezed,
    Object? categoryId = freezed,
    Object? readinessLevelId = freezed,
    Object? updates = freezed,
    Object? asOf = freezed,
    Object? employmentGenerated = freezed,
    Object? employedMale = freezed,
    Object? employedFemale = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      typeId: freezed == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int?,
      regularProgram: null == regularProgram
          ? _value.regularProgram
          : regularProgram // ignore: cast_nullable_to_non_nullable
              as bool,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      expectedOutputs: null == expectedOutputs
          ? _value.expectedOutputs
          : expectedOutputs // ignore: cast_nullable_to_non_nullable
              as String,
      spatialCoverageId: freezed == spatialCoverageId
          ? _value.spatialCoverageId
          : spatialCoverageId // ignore: cast_nullable_to_non_nullable
              as int?,
      approvalLevelId: freezed == approvalLevelId
          ? _value.approvalLevelId
          : approvalLevelId // ignore: cast_nullable_to_non_nullable
              as int?,
      approvalLevelDate: null == approvalLevelDate
          ? _value.approvalLevelDate
          : approvalLevelDate // ignore: cast_nullable_to_non_nullable
              as String,
      pip: null == pip
          ? _value.pip
          : pip // ignore: cast_nullable_to_non_nullable
              as bool,
      pipTypologyId: freezed == pipTypologyId
          ? _value.pipTypologyId
          : pipTypologyId // ignore: cast_nullable_to_non_nullable
              as int?,
      cip: null == cip
          ? _value.cip
          : cip // ignore: cast_nullable_to_non_nullable
              as bool,
      cipTypeId: freezed == cipTypeId
          ? _value.cipTypeId
          : cipTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
      trip: null == trip
          ? _value.trip
          : trip // ignore: cast_nullable_to_non_nullable
              as bool,
      rdip: null == rdip
          ? _value.rdip
          : rdip // ignore: cast_nullable_to_non_nullable
              as bool,
      covid: null == covid
          ? _value.covid
          : covid // ignore: cast_nullable_to_non_nullable
              as bool,
      research: null == research
          ? _value.research
          : research // ignore: cast_nullable_to_non_nullable
              as bool,
      bases: null == bases
          ? _value.bases
          : bases // ignore: cast_nullable_to_non_nullable
              as List<int>,
      operatingUnits: null == operatingUnits
          ? _value.operatingUnits
          : operatingUnits // ignore: cast_nullable_to_non_nullable
              as List<int>,
      rdcEndorsementRequired: null == rdcEndorsementRequired
          ? _value.rdcEndorsementRequired
          : rdcEndorsementRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      pdpChapterId: freezed == pdpChapterId
          ? _value.pdpChapterId
          : pdpChapterId // ignore: cast_nullable_to_non_nullable
              as int?,
      pdpChapters: null == pdpChapters
          ? _value.pdpChapters
          : pdpChapters // ignore: cast_nullable_to_non_nullable
              as List<int>,
      risk: freezed == risk
          ? _value.risk
          : risk // ignore: cast_nullable_to_non_nullable
              as String?,
      agendas: null == agendas
          ? _value.agendas
          : agendas // ignore: cast_nullable_to_non_nullable
              as List<int>,
      fundingSourceId: freezed == fundingSourceId
          ? _value.fundingSourceId
          : fundingSourceId // ignore: cast_nullable_to_non_nullable
              as int?,
      fundingSources: null == fundingSources
          ? _value.fundingSources
          : fundingSources // ignore: cast_nullable_to_non_nullable
              as List<int>,
      implementationModeId: freezed == implementationModeId
          ? _value.implementationModeId
          : implementationModeId // ignore: cast_nullable_to_non_nullable
              as int?,
      projectStatusId: freezed == projectStatusId
          ? _value.projectStatusId
          : projectStatusId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      readinessLevelId: freezed == readinessLevelId
          ? _value.readinessLevelId
          : readinessLevelId // ignore: cast_nullable_to_non_nullable
              as int?,
      updates: freezed == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as String?,
      asOf: freezed == asOf
          ? _value.asOf
          : asOf // ignore: cast_nullable_to_non_nullable
              as String?,
      employmentGenerated: freezed == employmentGenerated
          ? _value.employmentGenerated
          : employmentGenerated // ignore: cast_nullable_to_non_nullable
              as int?,
      employedMale: freezed == employedMale
          ? _value.employedMale
          : employedMale // ignore: cast_nullable_to_non_nullable
              as int?,
      employedFemale: freezed == employedFemale
          ? _value.employedFemale
          : employedFemale // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FullProjectCopyWith<$Res>
    implements $FullProjectCopyWith<$Res> {
  factory _$$_FullProjectCopyWith(
          _$_FullProject value, $Res Function(_$_FullProject) then) =
      __$$_FullProjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String title,
      @JsonKey(name: "type_id") int? typeId,
      @JsonKey(name: "regular_program") bool regularProgram,
      String description,
      @JsonKey(name: "total_cost") double totalCost,
      @JsonKey(name: "expected_outputs") String expectedOutputs,
      @JsonKey(name: "spatial_coverage_id") int? spatialCoverageId,
      @JsonKey(name: "approval_level_id") int? approvalLevelId,
      @JsonKey(name: "approval_level_date") String approvalLevelDate,
      bool pip,
      @JsonKey(name: "pip_typology_id") int? pipTypologyId,
      bool cip,
      @JsonKey(name: "cip_type_id") int? cipTypeId,
      bool trip,
      bool rdip,
      bool covid,
      bool research,
      List<int> bases,
      @JsonKey(name: "operating_units") List<int> operatingUnits,
      @JsonKey(name: "rdc_endorsement_required") bool rdcEndorsementRequired,
      @JsonKey(name: "pdp_chapter_id") int? pdpChapterId,
      @JsonKey(name: "pdp_chapters") List<int> pdpChapters,
      @JsonKey(name: "risk") String? risk,
      List<int> agendas,
      @JsonKey(name: "funding_source_id") int? fundingSourceId,
      @JsonKey(name: "funding_sources") List<int> fundingSources,
      @JsonKey(name: "implementation_mode_id") int? implementationModeId,
      @JsonKey(name: "project_status_id") int? projectStatusId,
      @JsonKey(name: "category_id") int? categoryId,
      @JsonKey(name: "readiness_level_id") int? readinessLevelId,
      String? updates,
      @JsonKey(name: "updates_as_of") String? asOf,
      @JsonKey(name: "employment_generated") int? employmentGenerated,
      @JsonKey(name: "employed_male") int? employedMale,
      @JsonKey(name: "employed_female") int? employedFemale});
}

/// @nodoc
class __$$_FullProjectCopyWithImpl<$Res>
    extends _$FullProjectCopyWithImpl<$Res, _$_FullProject>
    implements _$$_FullProjectCopyWith<$Res> {
  __$$_FullProjectCopyWithImpl(
      _$_FullProject _value, $Res Function(_$_FullProject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? title = null,
    Object? typeId = freezed,
    Object? regularProgram = null,
    Object? description = null,
    Object? totalCost = null,
    Object? expectedOutputs = null,
    Object? spatialCoverageId = freezed,
    Object? approvalLevelId = freezed,
    Object? approvalLevelDate = null,
    Object? pip = null,
    Object? pipTypologyId = freezed,
    Object? cip = null,
    Object? cipTypeId = freezed,
    Object? trip = null,
    Object? rdip = null,
    Object? covid = null,
    Object? research = null,
    Object? bases = null,
    Object? operatingUnits = null,
    Object? rdcEndorsementRequired = null,
    Object? pdpChapterId = freezed,
    Object? pdpChapters = null,
    Object? risk = freezed,
    Object? agendas = null,
    Object? fundingSourceId = freezed,
    Object? fundingSources = null,
    Object? implementationModeId = freezed,
    Object? projectStatusId = freezed,
    Object? categoryId = freezed,
    Object? readinessLevelId = freezed,
    Object? updates = freezed,
    Object? asOf = freezed,
    Object? employmentGenerated = freezed,
    Object? employedMale = freezed,
    Object? employedFemale = freezed,
  }) {
    return _then(_$_FullProject(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      typeId: freezed == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int?,
      regularProgram: null == regularProgram
          ? _value.regularProgram
          : regularProgram // ignore: cast_nullable_to_non_nullable
              as bool,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      expectedOutputs: null == expectedOutputs
          ? _value.expectedOutputs
          : expectedOutputs // ignore: cast_nullable_to_non_nullable
              as String,
      spatialCoverageId: freezed == spatialCoverageId
          ? _value.spatialCoverageId
          : spatialCoverageId // ignore: cast_nullable_to_non_nullable
              as int?,
      approvalLevelId: freezed == approvalLevelId
          ? _value.approvalLevelId
          : approvalLevelId // ignore: cast_nullable_to_non_nullable
              as int?,
      approvalLevelDate: null == approvalLevelDate
          ? _value.approvalLevelDate
          : approvalLevelDate // ignore: cast_nullable_to_non_nullable
              as String,
      pip: null == pip
          ? _value.pip
          : pip // ignore: cast_nullable_to_non_nullable
              as bool,
      pipTypologyId: freezed == pipTypologyId
          ? _value.pipTypologyId
          : pipTypologyId // ignore: cast_nullable_to_non_nullable
              as int?,
      cip: null == cip
          ? _value.cip
          : cip // ignore: cast_nullable_to_non_nullable
              as bool,
      cipTypeId: freezed == cipTypeId
          ? _value.cipTypeId
          : cipTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
      trip: null == trip
          ? _value.trip
          : trip // ignore: cast_nullable_to_non_nullable
              as bool,
      rdip: null == rdip
          ? _value.rdip
          : rdip // ignore: cast_nullable_to_non_nullable
              as bool,
      covid: null == covid
          ? _value.covid
          : covid // ignore: cast_nullable_to_non_nullable
              as bool,
      research: null == research
          ? _value.research
          : research // ignore: cast_nullable_to_non_nullable
              as bool,
      bases: null == bases
          ? _value._bases
          : bases // ignore: cast_nullable_to_non_nullable
              as List<int>,
      operatingUnits: null == operatingUnits
          ? _value._operatingUnits
          : operatingUnits // ignore: cast_nullable_to_non_nullable
              as List<int>,
      rdcEndorsementRequired: null == rdcEndorsementRequired
          ? _value.rdcEndorsementRequired
          : rdcEndorsementRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      pdpChapterId: freezed == pdpChapterId
          ? _value.pdpChapterId
          : pdpChapterId // ignore: cast_nullable_to_non_nullable
              as int?,
      pdpChapters: null == pdpChapters
          ? _value._pdpChapters
          : pdpChapters // ignore: cast_nullable_to_non_nullable
              as List<int>,
      risk: freezed == risk
          ? _value.risk
          : risk // ignore: cast_nullable_to_non_nullable
              as String?,
      agendas: null == agendas
          ? _value._agendas
          : agendas // ignore: cast_nullable_to_non_nullable
              as List<int>,
      fundingSourceId: freezed == fundingSourceId
          ? _value.fundingSourceId
          : fundingSourceId // ignore: cast_nullable_to_non_nullable
              as int?,
      fundingSources: null == fundingSources
          ? _value._fundingSources
          : fundingSources // ignore: cast_nullable_to_non_nullable
              as List<int>,
      implementationModeId: freezed == implementationModeId
          ? _value.implementationModeId
          : implementationModeId // ignore: cast_nullable_to_non_nullable
              as int?,
      projectStatusId: freezed == projectStatusId
          ? _value.projectStatusId
          : projectStatusId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      readinessLevelId: freezed == readinessLevelId
          ? _value.readinessLevelId
          : readinessLevelId // ignore: cast_nullable_to_non_nullable
              as int?,
      updates: freezed == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as String?,
      asOf: freezed == asOf
          ? _value.asOf
          : asOf // ignore: cast_nullable_to_non_nullable
              as String?,
      employmentGenerated: freezed == employmentGenerated
          ? _value.employmentGenerated
          : employmentGenerated // ignore: cast_nullable_to_non_nullable
              as int?,
      employedMale: freezed == employedMale
          ? _value.employedMale
          : employedMale // ignore: cast_nullable_to_non_nullable
              as int?,
      employedFemale: freezed == employedFemale
          ? _value.employedFemale
          : employedFemale // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_FullProject implements _FullProject {
  _$_FullProject(
      {this.id,
      this.uuid,
      required this.title,
      @JsonKey(name: "type_id")
          this.typeId,
      @JsonKey(name: "regular_program")
          required this.regularProgram,
      required this.description,
      @JsonKey(name: "total_cost")
          required this.totalCost,
      @JsonKey(name: "expected_outputs")
          required this.expectedOutputs,
      @JsonKey(name: "spatial_coverage_id")
          this.spatialCoverageId,
      @JsonKey(name: "approval_level_id")
          this.approvalLevelId,
      @JsonKey(name: "approval_level_date")
          required this.approvalLevelDate,
      required this.pip,
      @JsonKey(name: "pip_typology_id")
          this.pipTypologyId,
      required this.cip,
      @JsonKey(name: "cip_type_id")
          this.cipTypeId,
      required this.trip,
      required this.rdip,
      required this.covid,
      required this.research,
      required final List<int> bases,
      @JsonKey(name: "operating_units")
          required final List<int> operatingUnits,
      @JsonKey(name: "rdc_endorsement_required")
          required this.rdcEndorsementRequired,
      @JsonKey(name: "pdp_chapter_id")
          this.pdpChapterId,
      @JsonKey(name: "pdp_chapters")
          required final List<int> pdpChapters,
      @JsonKey(name: "risk")
          this.risk,
      required final List<int> agendas,
      @JsonKey(name: "funding_source_id")
          this.fundingSourceId,
      @JsonKey(name: "funding_sources")
          required final List<int> fundingSources,
      @JsonKey(name: "implementation_mode_id")
          this.implementationModeId,
      @JsonKey(name: "project_status_id")
          this.projectStatusId,
      @JsonKey(name: "category_id")
          this.categoryId,
      @JsonKey(name: "readiness_level_id")
          this.readinessLevelId,
      this.updates,
      @JsonKey(name: "updates_as_of")
          this.asOf,
      @JsonKey(name: "employment_generated")
          this.employmentGenerated,
      @JsonKey(name: "employed_male")
          this.employedMale,
      @JsonKey(name: "employed_female")
          this.employedFemale})
      : _bases = bases,
        _operatingUnits = operatingUnits,
        _pdpChapters = pdpChapters,
        _agendas = agendas,
        _fundingSources = fundingSources;

  factory _$_FullProject.fromJson(Map<String, dynamic> json) =>
      _$$_FullProjectFromJson(json);

  @override
  final int? id;
  @override
  final String? uuid;
  @override
  final String title;
  @override
  @JsonKey(name: "type_id")
  final int? typeId;
  @override
  @JsonKey(name: "regular_program")
  final bool regularProgram;
  @override
  final String description;
  @override
  @JsonKey(name: "total_cost")
  final double totalCost;
  @override
  @JsonKey(name: "expected_outputs")
  final String expectedOutputs;
  @override
  @JsonKey(name: "spatial_coverage_id")
  final int? spatialCoverageId;
  @override
  @JsonKey(name: "approval_level_id")
  final int? approvalLevelId;
  @override
  @JsonKey(name: "approval_level_date")
  final String approvalLevelDate;
  @override
  final bool pip;
  @override
  @JsonKey(name: "pip_typology_id")
  final int? pipTypologyId;
  @override
  final bool cip;
  @override
  @JsonKey(name: "cip_type_id")
  final int? cipTypeId;
  @override
  final bool trip;
  @override
  final bool rdip;
  @override
  final bool covid;
  @override
  final bool research;
  final List<int> _bases;
  @override
  List<int> get bases {
    if (_bases is EqualUnmodifiableListView) return _bases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bases);
  }

  final List<int> _operatingUnits;
  @override
  @JsonKey(name: "operating_units")
  List<int> get operatingUnits {
    if (_operatingUnits is EqualUnmodifiableListView) return _operatingUnits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_operatingUnits);
  }

  @override
  @JsonKey(name: "rdc_endorsement_required")
  final bool rdcEndorsementRequired;
  @override
  @JsonKey(name: "pdp_chapter_id")
  final int? pdpChapterId;
  final List<int> _pdpChapters;
  @override
  @JsonKey(name: "pdp_chapters")
  List<int> get pdpChapters {
    if (_pdpChapters is EqualUnmodifiableListView) return _pdpChapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pdpChapters);
  }

  @override
  @JsonKey(name: "risk")
  final String? risk;
  final List<int> _agendas;
  @override
  List<int> get agendas {
    if (_agendas is EqualUnmodifiableListView) return _agendas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_agendas);
  }

  @override
  @JsonKey(name: "funding_source_id")
  final int? fundingSourceId;
  final List<int> _fundingSources;
  @override
  @JsonKey(name: "funding_sources")
  List<int> get fundingSources {
    if (_fundingSources is EqualUnmodifiableListView) return _fundingSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fundingSources);
  }

  @override
  @JsonKey(name: "implementation_mode_id")
  final int? implementationModeId;
  @override
  @JsonKey(name: "project_status_id")
  final int? projectStatusId;
  @override
  @JsonKey(name: "category_id")
  final int? categoryId;
  @override
  @JsonKey(name: "readiness_level_id")
  final int? readinessLevelId;
  @override
  final String? updates;
  @override
  @JsonKey(name: "updates_as_of")
  final String? asOf;
  @override
  @JsonKey(name: "employment_generated")
  final int? employmentGenerated;
  @override
  @JsonKey(name: "employed_male")
  final int? employedMale;
  @override
  @JsonKey(name: "employed_female")
  final int? employedFemale;

  @override
  String toString() {
    return 'FullProject(id: $id, uuid: $uuid, title: $title, typeId: $typeId, regularProgram: $regularProgram, description: $description, totalCost: $totalCost, expectedOutputs: $expectedOutputs, spatialCoverageId: $spatialCoverageId, approvalLevelId: $approvalLevelId, approvalLevelDate: $approvalLevelDate, pip: $pip, pipTypologyId: $pipTypologyId, cip: $cip, cipTypeId: $cipTypeId, trip: $trip, rdip: $rdip, covid: $covid, research: $research, bases: $bases, operatingUnits: $operatingUnits, rdcEndorsementRequired: $rdcEndorsementRequired, pdpChapterId: $pdpChapterId, pdpChapters: $pdpChapters, risk: $risk, agendas: $agendas, fundingSourceId: $fundingSourceId, fundingSources: $fundingSources, implementationModeId: $implementationModeId, projectStatusId: $projectStatusId, categoryId: $categoryId, readinessLevelId: $readinessLevelId, updates: $updates, asOf: $asOf, employmentGenerated: $employmentGenerated, employedMale: $employedMale, employedFemale: $employedFemale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FullProject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.regularProgram, regularProgram) ||
                other.regularProgram == regularProgram) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.expectedOutputs, expectedOutputs) ||
                other.expectedOutputs == expectedOutputs) &&
            (identical(other.spatialCoverageId, spatialCoverageId) ||
                other.spatialCoverageId == spatialCoverageId) &&
            (identical(other.approvalLevelId, approvalLevelId) ||
                other.approvalLevelId == approvalLevelId) &&
            (identical(other.approvalLevelDate, approvalLevelDate) ||
                other.approvalLevelDate == approvalLevelDate) &&
            (identical(other.pip, pip) || other.pip == pip) &&
            (identical(other.pipTypologyId, pipTypologyId) ||
                other.pipTypologyId == pipTypologyId) &&
            (identical(other.cip, cip) || other.cip == cip) &&
            (identical(other.cipTypeId, cipTypeId) ||
                other.cipTypeId == cipTypeId) &&
            (identical(other.trip, trip) || other.trip == trip) &&
            (identical(other.rdip, rdip) || other.rdip == rdip) &&
            (identical(other.covid, covid) || other.covid == covid) &&
            (identical(other.research, research) ||
                other.research == research) &&
            const DeepCollectionEquality().equals(other._bases, _bases) &&
            const DeepCollectionEquality()
                .equals(other._operatingUnits, _operatingUnits) &&
            (identical(other.rdcEndorsementRequired, rdcEndorsementRequired) ||
                other.rdcEndorsementRequired == rdcEndorsementRequired) &&
            (identical(other.pdpChapterId, pdpChapterId) ||
                other.pdpChapterId == pdpChapterId) &&
            const DeepCollectionEquality()
                .equals(other._pdpChapters, _pdpChapters) &&
            (identical(other.risk, risk) || other.risk == risk) &&
            const DeepCollectionEquality().equals(other._agendas, _agendas) &&
            (identical(other.fundingSourceId, fundingSourceId) ||
                other.fundingSourceId == fundingSourceId) &&
            const DeepCollectionEquality()
                .equals(other._fundingSources, _fundingSources) &&
            (identical(other.implementationModeId, implementationModeId) ||
                other.implementationModeId == implementationModeId) &&
            (identical(other.projectStatusId, projectStatusId) ||
                other.projectStatusId == projectStatusId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.readinessLevelId, readinessLevelId) ||
                other.readinessLevelId == readinessLevelId) &&
            (identical(other.updates, updates) || other.updates == updates) &&
            (identical(other.asOf, asOf) || other.asOf == asOf) &&
            (identical(other.employmentGenerated, employmentGenerated) ||
                other.employmentGenerated == employmentGenerated) &&
            (identical(other.employedMale, employedMale) ||
                other.employedMale == employedMale) &&
            (identical(other.employedFemale, employedFemale) ||
                other.employedFemale == employedFemale));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        uuid,
        title,
        typeId,
        regularProgram,
        description,
        totalCost,
        expectedOutputs,
        spatialCoverageId,
        approvalLevelId,
        approvalLevelDate,
        pip,
        pipTypologyId,
        cip,
        cipTypeId,
        trip,
        rdip,
        covid,
        research,
        const DeepCollectionEquality().hash(_bases),
        const DeepCollectionEquality().hash(_operatingUnits),
        rdcEndorsementRequired,
        pdpChapterId,
        const DeepCollectionEquality().hash(_pdpChapters),
        risk,
        const DeepCollectionEquality().hash(_agendas),
        fundingSourceId,
        const DeepCollectionEquality().hash(_fundingSources),
        implementationModeId,
        projectStatusId,
        categoryId,
        readinessLevelId,
        updates,
        asOf,
        employmentGenerated,
        employedMale,
        employedFemale
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FullProjectCopyWith<_$_FullProject> get copyWith =>
      __$$_FullProjectCopyWithImpl<_$_FullProject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FullProjectToJson(
      this,
    );
  }
}

abstract class _FullProject implements FullProject {
  factory _FullProject(
      {final int? id,
      final String? uuid,
      required final String title,
      @JsonKey(name: "type_id")
          final int? typeId,
      @JsonKey(name: "regular_program")
          required final bool regularProgram,
      required final String description,
      @JsonKey(name: "total_cost")
          required final double totalCost,
      @JsonKey(name: "expected_outputs")
          required final String expectedOutputs,
      @JsonKey(name: "spatial_coverage_id")
          final int? spatialCoverageId,
      @JsonKey(name: "approval_level_id")
          final int? approvalLevelId,
      @JsonKey(name: "approval_level_date")
          required final String approvalLevelDate,
      required final bool pip,
      @JsonKey(name: "pip_typology_id")
          final int? pipTypologyId,
      required final bool cip,
      @JsonKey(name: "cip_type_id")
          final int? cipTypeId,
      required final bool trip,
      required final bool rdip,
      required final bool covid,
      required final bool research,
      required final List<int> bases,
      @JsonKey(name: "operating_units")
          required final List<int> operatingUnits,
      @JsonKey(name: "rdc_endorsement_required")
          required final bool rdcEndorsementRequired,
      @JsonKey(name: "pdp_chapter_id")
          final int? pdpChapterId,
      @JsonKey(name: "pdp_chapters")
          required final List<int> pdpChapters,
      @JsonKey(name: "risk")
          final String? risk,
      required final List<int> agendas,
      @JsonKey(name: "funding_source_id")
          final int? fundingSourceId,
      @JsonKey(name: "funding_sources")
          required final List<int> fundingSources,
      @JsonKey(name: "implementation_mode_id")
          final int? implementationModeId,
      @JsonKey(name: "project_status_id")
          final int? projectStatusId,
      @JsonKey(name: "category_id")
          final int? categoryId,
      @JsonKey(name: "readiness_level_id")
          final int? readinessLevelId,
      final String? updates,
      @JsonKey(name: "updates_as_of")
          final String? asOf,
      @JsonKey(name: "employment_generated")
          final int? employmentGenerated,
      @JsonKey(name: "employed_male")
          final int? employedMale,
      @JsonKey(name: "employed_female")
          final int? employedFemale}) = _$_FullProject;

  factory _FullProject.fromJson(Map<String, dynamic> json) =
      _$_FullProject.fromJson;

  @override
  int? get id;
  @override
  String? get uuid;
  @override
  String get title;
  @override
  @JsonKey(name: "type_id")
  int? get typeId;
  @override
  @JsonKey(name: "regular_program")
  bool get regularProgram;
  @override
  String get description;
  @override
  @JsonKey(name: "total_cost")
  double get totalCost;
  @override
  @JsonKey(name: "expected_outputs")
  String get expectedOutputs;
  @override
  @JsonKey(name: "spatial_coverage_id")
  int? get spatialCoverageId;
  @override
  @JsonKey(name: "approval_level_id")
  int? get approvalLevelId;
  @override
  @JsonKey(name: "approval_level_date")
  String get approvalLevelDate;
  @override
  bool get pip;
  @override
  @JsonKey(name: "pip_typology_id")
  int? get pipTypologyId;
  @override
  bool get cip;
  @override
  @JsonKey(name: "cip_type_id")
  int? get cipTypeId;
  @override
  bool get trip;
  @override
  bool get rdip;
  @override
  bool get covid;
  @override
  bool get research;
  @override
  List<int> get bases;
  @override
  @JsonKey(name: "operating_units")
  List<int> get operatingUnits;
  @override
  @JsonKey(name: "rdc_endorsement_required")
  bool get rdcEndorsementRequired;
  @override
  @JsonKey(name: "pdp_chapter_id")
  int? get pdpChapterId;
  @override
  @JsonKey(name: "pdp_chapters")
  List<int> get pdpChapters;
  @override
  @JsonKey(name: "risk")
  String? get risk;
  @override
  List<int> get agendas;
  @override
  @JsonKey(name: "funding_source_id")
  int? get fundingSourceId;
  @override
  @JsonKey(name: "funding_sources")
  List<int> get fundingSources;
  @override
  @JsonKey(name: "implementation_mode_id")
  int? get implementationModeId;
  @override
  @JsonKey(name: "project_status_id")
  int? get projectStatusId;
  @override
  @JsonKey(name: "category_id")
  int? get categoryId;
  @override
  @JsonKey(name: "readiness_level_id")
  int? get readinessLevelId;
  @override
  String? get updates;
  @override
  @JsonKey(name: "updates_as_of")
  String? get asOf;
  @override
  @JsonKey(name: "employment_generated")
  int? get employmentGenerated;
  @override
  @JsonKey(name: "employed_male")
  int? get employedMale;
  @override
  @JsonKey(name: "employed_female")
  int? get employedFemale;
  @override
  @JsonKey(ignore: true)
  _$$_FullProjectCopyWith<_$_FullProject> get copyWith =>
      throw _privateConstructorUsedError;
}
