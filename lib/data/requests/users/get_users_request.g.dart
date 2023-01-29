// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_users_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUsersRequest _$GetUsersRequestFromJson(Map<String, dynamic> json) =>
    GetUsersRequest(
      perPage: json['per_page'] as int? ?? 25,
      page: json['page'] as int? ?? 1,
    );

Map<String, dynamic> _$GetUsersRequestToJson(GetUsersRequest instance) =>
    <String, dynamic>{
      'per_page': instance.perPage,
      'page': instance.page,
    };
