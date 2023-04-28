// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationResponse _$PaginationResponseFromJson(Map<String, dynamic> json) =>
    PaginationResponse(
      total: json['total'] as int,
      pageSize: json['pageSize'] as int,
      current: json['current'] as int,
      last: json['last'] as int,
    );

Map<String, dynamic> _$PaginationResponseToJson(PaginationResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'pageSize': instance.pageSize,
      'current': instance.current,
      'last': instance.last,
    };
