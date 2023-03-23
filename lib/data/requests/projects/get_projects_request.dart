import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_projects_request.g.dart';

@JsonSerializable()
class GetProjectsRequest {
  @JsonKey(name: "per_page")
  int perPage;

  @JsonKey(name: "page")
  int page;

  @JsonKey(name: "q", includeIfNull: false)
  String? q;

  @JsonKey(name: "types[]", includeIfNull: false)
  List<int>? types;

  @JsonKey(name: "spatial_coverages[]", includeIfNull: false)
  List<int>? spatialCoverages;

  @JsonKey(name: "pip", includeIfNull: false)
  bool? pip;

  @JsonKey(name: "cip", includeIfNull: false)
  bool? cip;

  @JsonKey(name: "trip", includeIfNull: false)
  bool? trip;

  @JsonKey(name: "rdip", includeIfNull: false)
  bool? rdip;

  @JsonKey(name: "pdp_chapters[]", includeIfNull: false)
  List<int>? pdpChapters;

  @JsonKey(name: "project_statuses[]", includeIfNull: false)
  List<int>? projectStatuses;

  @JsonKey(name: "categories[]", includeIfNull: false)
  List<int>? categories;

  @JsonKey(name: "pipol_statuses[]", includeIfNull: false)
  List<int>? pipolStatuses;

  @JsonKey(name: "pips_statuses[]", includeIfNull: false)
  List<int>? pipsStatuses;

  @JsonKey(name: "offices[]", includeIfNull: false)
  List<int>? offices;

  @JsonKey(name: "funding_sources[]", includeIfNull: false)
  List<int>? fundingSources;

  GetProjectsRequest({
    this.perPage = 25,
    this.page = 1,
    this.q,
    this.types,
    this.spatialCoverages,
    this.pip,
    this.cip,
    this.trip,
    this.rdip,
    this.pdpChapters,
    this.projectStatuses,
    this.categories,
    this.pipolStatuses,
    this.pipsStatuses,
    this.offices,
    this.fundingSources,
  });

  factory GetProjectsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetProjectsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetProjectsRequestToJson(this);

  GetProjectsRequest copyWith({
    int? perPage,
    int? page,
    String? q,
    List<int>? types,
    List<int>? spatialCoverages,
    bool? pip,
    bool? cip,
    bool? trip,
    bool? rdip,
    List<int>? pdpChapters,
    List<int>? projectStatuses,
    List<int>? categories,
    List<int>? pipolStatuses,
    List<int>? pipsStatuses,
    List<int>? offices,
    List<int>? fundingSources,
  }) =>
      GetProjectsRequest(
        perPage: perPage ?? this.perPage,
        page: page ?? this.page,
        q: q ?? this.q,
        types: types ?? this.types,
        spatialCoverages: spatialCoverages ?? this.spatialCoverages,
        pip: pip ?? this.pip,
        cip: cip ?? this.cip,
        trip: trip ?? this.trip,
        rdip: rdip ?? this.rdip,
        pdpChapters: pdpChapters ?? this.pdpChapters,
        projectStatuses: projectStatuses ?? this.projectStatuses,
        categories: categories ?? this.categories,
        pipolStatuses: pipolStatuses ?? this.pipolStatuses,
        pipsStatuses: pipsStatuses ?? this.pipsStatuses,
        offices: offices ?? this.offices,
        fundingSources: fundingSources ?? this.fundingSources,
      );
}
