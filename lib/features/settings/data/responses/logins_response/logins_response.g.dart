// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logins_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginsResponse _$LoginsResponseFromJson(Map<String, dynamic> json) =>
    LoginsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Logins.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoginsResponseToJson(LoginsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Logins _$LoginsFromJson(Map<String, dynamic> json) => Logins(
      userAgent: json['user_agent'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$LoginsToJson(Logins instance) => <String, dynamic>{
      'user_agent': instance.userAgent,
      'created_at': instance.createdAt,
    };
