import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pips/features/project/domain/models/full_project.dart';

part '../../../features/project/create_project/create_project_response.g.dart';

@JsonSerializable()
class CreateProjectResponse {
  @JsonKey(name: 'data')
  FullProject data;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'sucess')
  bool success;

  CreateProjectResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  factory CreateProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProjectResponseToJson(this);
}
