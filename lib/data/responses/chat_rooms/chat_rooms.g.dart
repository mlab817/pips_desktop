// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_rooms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomsResponse _$ChatRoomsResponseFromJson(Map<String, dynamic> json) =>
    ChatRoomsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ChatRoom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatRoomsResponseToJson(ChatRoomsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
