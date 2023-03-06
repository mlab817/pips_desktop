// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      position: json['position'] as String,
      contactNumber: json['contact_number'] as String,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'position': instance.position,
      'contact_number': instance.contactNumber,
    };
