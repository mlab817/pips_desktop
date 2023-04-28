import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../common/data/models/meta/meta_response.dart';
import '../../../../domain/models/project.dart';

part 'projects_response.g.dart';

@JsonSerializable()
class ProjectsResponse {
  @JsonKey(name: "data")
  List<Project> data;

  @JsonKey(name: "meta")
  MetaResponse meta;

  ProjectsResponse({
    required this.data,
    required this.meta,
  });

  factory ProjectsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectsResponseToJson(this);
}
