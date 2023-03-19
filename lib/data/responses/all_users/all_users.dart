import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_users.g.dart';

@JsonSerializable()
class AllUsersResponse {
  @JsonKey(name: "data")
  List<UserQuickResource> data;

  AllUsersResponse({
    required this.data,
  });

  factory AllUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$AllUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllUsersResponseToJson(this);
}

@JsonSerializable()
class UserQuickResource {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "image_url")
  String? imageUrl;

  UserQuickResource({required this.id, required this.name, this.imageUrl});

  factory UserQuickResource.fromJson(Map<String, dynamic> json) =>
      _$UserQuickResourceFromJson(json);

  Map<String, dynamic> toJson() => _$UserQuickResourceToJson(this);
}
