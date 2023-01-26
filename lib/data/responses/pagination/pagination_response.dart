import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_response.g.dart';

@JsonSerializable()
class PaginationResponse {
  @JsonKey(name: "total")
  int total;

  @JsonKey(name: "pageSize")
  int pageSize;

  @JsonKey(name: "current")
  int current;

  @JsonKey(name: "last")
  int last;

  PaginationResponse({
    required this.total,
    required this.pageSize,
    required this.current,
    required this.last,
  });

  factory PaginationResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationResponseToJson(this);
}
