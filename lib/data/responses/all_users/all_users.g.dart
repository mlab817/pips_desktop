// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllUsersResponse _$AllUsersResponseFromJson(Map<String, dynamic> json) =>
    AllUsersResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserQuickResource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllUsersResponseToJson(AllUsersResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UserQuickResource _$UserQuickResourceFromJson(Map<String, dynamic> json) =>
    UserQuickResource(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$UserQuickResourceToJson(UserQuickResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
    };
