import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_request.g.dart';

@JsonSerializable()
class NotificationsRequest {
  @JsonKey(name: "per_page")
  int perPage;

  @JsonKey(name: "page")
  int page;

  @JsonKey(name: "q")
  String? q;

  NotificationsRequest({
    this.perPage = 25,
    this.page = 1,
    this.q,
  });

  factory NotificationsRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsRequestToJson(this);
}
