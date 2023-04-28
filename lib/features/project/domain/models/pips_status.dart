import 'package:freezed_annotation/freezed_annotation.dart';

part 'pips_status.g.dart';

@JsonSerializable()
class PipsStatus {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "description")
  String description;

  @JsonKey(name: "projects_count")
  int projectsCount;

  PipsStatus({
    required this.id,
    required this.name,
    required this.description,
    required this.projectsCount,
  });

  factory PipsStatus.fromJson(Map<String, dynamic> json) =>
      _$PipsStatusFromJson(json);

  Map<String, dynamic> toJson() => _$PipsStatusToJson(this);
}
