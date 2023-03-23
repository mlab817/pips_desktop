// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeResponseData _$OfficeResponseDataFromJson(Map<String, dynamic> json) =>
    OfficeResponseData(
      id: json['id'],
      uuid: json['uuid'],
      name: json['name'],
      acronym: json['acronym'],
      headName: json['head_name'],
      headPosition: json['head_position'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfficeResponseDataToJson(OfficeResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'acronym': instance.acronym,
      'uuid': instance.uuid,
      'head_name': instance.headName,
      'head_position': instance.headPosition,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'projects': instance.projects,
      'users': instance.users,
    };
