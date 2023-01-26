import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  @JsonKey(name: "uuid")
  String uuid;

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "total_cost")
  double totalCost;

  @JsonKey(name: "passes_validation")
  bool passesValidation;

  @JsonKey(name: "is_locked")
  bool isLocked;

  @JsonKey(name: "updated_at")
  String updatedAt;

  Project({
    required this.uuid,
    required this.title,
    required this.totalCost,
    required this.passesValidation,
    required this.isLocked,
    required this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
