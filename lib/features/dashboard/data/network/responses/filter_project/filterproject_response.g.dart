// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filterproject_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterProjectResponse _$FilterProjectResponseFromJson(
        Map<String, dynamic> json) =>
    FilterProjectResponse(
      model: Option.fromJson(json['model'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      current: json['current'] as int,
      last: json['last'] as int,
      total: json['total'] as int,
      perPage: json['per_page'] as int,
    );

Map<String, dynamic> _$FilterProjectResponseToJson(
        FilterProjectResponse instance) =>
    <String, dynamic>{
      'model': instance.model,
      'data': instance.data,
      'current': instance.current,
      'last': instance.last,
      'total': instance.total,
      'per_page': instance.perPage,
    };
