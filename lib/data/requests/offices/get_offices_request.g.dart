// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_offices_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOfficesRequest _$GetOfficesRequestFromJson(Map<String, dynamic> json) =>
    GetOfficesRequest(
      perPage: json['per_page'] as int? ?? 25,
      page: json['page'] as int? ?? 1,
    );

Map<String, dynamic> _$GetOfficesRequestToJson(GetOfficesRequest instance) =>
    <String, dynamic>{
      'per_page': instance.perPage,
      'page': instance.page,
    };
