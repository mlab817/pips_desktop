import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/user.dart';
import '../meta/meta_response.dart';

part 'users_response.g.dart';

@JsonSerializable()
class UsersResponse {
  @JsonKey(name: "data")
  List<User> data;

  @JsonKey(name: "meta")
  MetaResponse meta;

  UsersResponse({
    required this.data,
    required this.meta,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}
