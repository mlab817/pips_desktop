import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'data')
  NotificationData data;

  @JsonKey(name: 'created_at')
  String createdAt;

  Notification({
    required this.id,
    required this.data,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}

@JsonSerializable()
class NotificationData {
  @JsonKey(name: 'sender')
  String sender;

  @JsonKey(name: 'subject')
  String subject;

  @JsonKey(name: 'message')
  String message;

  NotificationData({
    required this.sender,
    required this.subject,
    required this.message,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}
