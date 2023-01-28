import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_offices_request.g.dart';

@JsonSerializable()
class GetOfficesRequest {
  @JsonKey(name: "per_page")
  int perPage;

  @JsonKey(name: "page")
  int page;

  GetOfficesRequest({
    this.perPage = 25,
    this.page = 1,
  });

  factory GetOfficesRequest.fromJson(Map<String, dynamic> json) =>
      _$GetOfficesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetOfficesRequestToJson(this);
}
