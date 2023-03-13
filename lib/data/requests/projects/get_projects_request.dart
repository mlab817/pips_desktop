import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_projects_request.g.dart';

@JsonSerializable()
class GetProjectsRequest {
  @JsonKey(name: "per_page")
  int perPage;

  @JsonKey(name: "page")
  int page;

  @JsonKey(name: "q")
  String? q;

  GetProjectsRequest({
    this.perPage = 25,
    this.page = 1,
    this.q,
  });

  factory GetProjectsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetProjectsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetProjectsRequestToJson(this);
}
