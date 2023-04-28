import 'package:freezed_annotation/freezed_annotation.dart';

import '../pagination/pagination_response.dart';

part 'meta_response.g.dart';

@JsonSerializable()
class MetaResponse {
  @JsonKey(name: "pagination")
  PaginationResponse pagination;

  MetaResponse({
    required this.pagination,
  });

  factory MetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MetaResponseToJson(this);
}
