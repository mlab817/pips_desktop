import 'package:json_annotation/json_annotation.dart';
import 'package:pips/domain/models/project.dart';

part 'project_response.g.dart';

@JsonSerializable()
class ProjectResponse {
  @JsonKey(name: "project")
  Project project;

  ProjectResponse({
    required this.project,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectResponseToJson(this);
}
