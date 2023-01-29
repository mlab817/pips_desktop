import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_users_request.g.dart';

@JsonSerializable()
class GetUsersRequest {
  @JsonKey(name: "per_page")
  int perPage;

  @JsonKey(name: "page")
  int page;

  GetUsersRequest({
    this.perPage = 25,
    this.page = 1,
  });

  factory GetUsersRequest.fromJson(Map<String, dynamic> json) =>
      _$GetUsersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersRequestToJson(this);
}
