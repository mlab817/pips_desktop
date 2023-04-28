// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pips_statuses_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PipsStatusesResponse _$PipsStatusesResponseFromJson(
        Map<String, dynamic> json) =>
    PipsStatusesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => PipsStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PipsStatusesResponseToJson(
        PipsStatusesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
