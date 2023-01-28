// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Office _$OfficeFromJson(Map<String, dynamic> json) => Office(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      acronym: json['acronym'] as String,
      headName: json['head_name'] as String,
      headPosition: json['head_position'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
    );

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'acronym': instance.acronym,
      'head_name': instance.headName,
      'head_position': instance.headPosition,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
    };
