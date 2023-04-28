// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filterproject_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterProjectRequest _$FilterProjectRequestFromJson(
        Map<String, dynamic> json) =>
    FilterProjectRequest(
      filter: json['filter'] as String,
      value: json['value'] as int,
      page: json['page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 10,
    );

Map<String, dynamic> _$FilterProjectRequestToJson(
        FilterProjectRequest instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'value': instance.value,
      'page': instance.page,
      'per_page': instance.perPage,
    };
