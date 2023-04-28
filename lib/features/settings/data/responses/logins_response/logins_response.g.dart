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
