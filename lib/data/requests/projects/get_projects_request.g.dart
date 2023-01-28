// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_projects_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProjectsRequest _$GetProjectsRequestFromJson(Map<String, dynamic> json) =>
    GetProjectsRequest(
      perPage: json['per_page'] as int? ?? 25,
      page: json['page'] as int? ?? 1,
    );

Map<String, dynamic> _$GetProjectsRequestToJson(GetProjectsRequest instance) =>
    <String, dynamic>{
      'per_page': instance.perPage,
      'page': instance.page,
    };
