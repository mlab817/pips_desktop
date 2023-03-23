import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pips/domain/models/user.dart';

import 'attribute.dart';
import 'office.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  @JsonKey(name: "uuid")
  String uuid;

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "total_cost")
  double? totalCost;

  @JsonKey(name: "is_locked")
  bool isLocked;

  @JsonKey(name: "updated_at")
  String updatedAt;

  @JsonKey(name: "pipol_code")
  String? pipolCode;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "spatial_coverage")
  Attribute? spatialCoverage;

  @JsonKey(name: "office")
  Office? office;

  @JsonKey(name: "user")
  User? user;

  Project({
    required this.uuid,
    required this.title,
    required this.isLocked,
    required this.updatedAt,
    this.totalCost,
    this.pipolCode,
    this.description,
    this.spatialCoverage,
    this.office,
    this.user,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
