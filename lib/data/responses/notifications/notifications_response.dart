import 'package:json_annotation/json_annotation.dart';
import 'package:pips/domain/models/notification.dart';

part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationsResponse {
  @JsonKey(name: 'data')
  List<Notification> data;

  NotificationsResponse({
    required this.data,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}
