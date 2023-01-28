// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offices_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficesResponse _$OfficesResponseFromJson(Map<String, dynamic> json) =>
    OfficesResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Office.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OfficesResponseToJson(OfficesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
