// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SignUpRequest _$$_SignUpRequestFromJson(Map<String, dynamic> json) =>
    _$_SignUpRequest(
      officeId: json['office_id'] as int?,
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      position: json['position'] as String,
      email: json['email'] as String,
      contactNumber: json['contact_number'] as String,
      authorizationPath: json['authorization'] as String,
    );

Map<String, dynamic> _$$_SignUpRequestToJson(_$_SignUpRequest instance) =>
    <String, dynamic>{
      'office_id': instance.officeId,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'position': instance.position,
      'email': instance.email,
      'contact_number': instance.contactNumber,
      'authorization': instance.authorizationPath,
    };
