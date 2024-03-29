import 'package:freezed_annotation/freezed_annotation.dart';

part 'logins.g.dart';

@JsonSerializable()
class Logins {
  @JsonKey(name: "user_agent")
  String userAgent;

  @JsonKey(name: "created_at")
  String createdAt;

  Logins({
    required this.userAgent,
    required this.createdAt,
  });

  factory Logins.fromJson(Map<String, dynamic> json) => _$LoginsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginsToJson(this);
}
