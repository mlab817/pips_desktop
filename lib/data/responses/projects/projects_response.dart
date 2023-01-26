import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/project.dart';
import '../meta/meta_response.dart';

part 'projects_response.g.dart';

@JsonSerializable()
class ProjectsResponse {
  @JsonKey(name: "data")
  List<Project>? data;

  @JsonKey(name: "meta")
  MetaResponse meta;

  ProjectsResponse({
    this.data,
    required this.meta,
  });

  factory ProjectsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectsResponseToJson(this);
}
