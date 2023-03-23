// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_offices_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOfficesResponse _$AllOfficesResponseFromJson(Map<String, dynamic> json) =>
    AllOfficesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Office.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllOfficesResponseToJson(AllOfficesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
