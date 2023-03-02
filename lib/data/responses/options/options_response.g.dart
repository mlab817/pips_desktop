// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionsResponse _$OptionsResponseFromJson(Map<String, dynamic> json) =>
    OptionsResponse(
      data: json['data'] == null
          ? null
          : Options.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OptionsResponseToJson(OptionsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
