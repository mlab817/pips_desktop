import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pips/domain/models/attribute.dart';

import '../../../domain/models/project.dart';

part 'filter_project_response.g.dart';

@JsonSerializable()
class FilterProjectResponse {
  @JsonKey(name: "model")
  Attribute model;

  @JsonKey(name: "data")
  List<Project> data;

  @JsonKey(name: "current")
  int current;

  @JsonKey(name: "last")
  int last;

  @JsonKey(name: "total")
  int total;

  @JsonKey(name: "per_page")
  int perPage;

  FilterProjectResponse({
    required this.model,
    required this.data,
    required this.current,
    required this.last,
    required this.total,
    required this.perPage,
  });

  factory FilterProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterProjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterProjectResponseToJson(this);
}
