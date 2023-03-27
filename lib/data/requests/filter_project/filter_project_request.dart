import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_project_request.g.dart';

@JsonSerializable()
class FilterProjectRequest {
  @JsonKey(name: "filter")
  String filter;

  @JsonKey(name: "value")
  int value;

  @JsonKey(name: "page")
  int? page;

  @JsonKey(name: "per_page")
  int? perPage;

  FilterProjectRequest({
    required this.filter,
    required this.value,
    this.page = 1,
    this.perPage = 10,
  });

  factory FilterProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$FilterProjectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FilterProjectRequestToJson(this);

  FilterProjectRequest copyWith({
    String? filter,
    int? value,
    int? page,
    int? perPage,
  }) =>
      FilterProjectRequest(
        filter: filter ?? this.filter,
        value: value ?? this.value,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
      );
}
