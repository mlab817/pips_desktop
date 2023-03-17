import 'package:json_annotation/json_annotation.dart';
import 'package:pips/domain/models/notification.dart';

import '../meta/meta_response.dart';

part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationsResponse {
  @JsonKey(name: 'data')
  List<Notification> data;

  @JsonKey(name: 'meta')
  MetaResponse meta;

  NotificationsResponse({
    required this.data,
    required this.meta,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}
