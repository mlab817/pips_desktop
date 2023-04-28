// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsRequest _$NotificationsRequestFromJson(
        Map<String, dynamic> json) =>
    NotificationsRequest(
      perPage: json['per_page'] as int? ?? 25,
      page: json['page'] as int? ?? 1,
      q: json['q'] as String?,
    );

Map<String, dynamic> _$NotificationsRequestToJson(
        NotificationsRequest instance) =>
    <String, dynamic>{
      'per_page': instance.perPage,
      'page': instance.page,
      'q': instance.q,
    };
