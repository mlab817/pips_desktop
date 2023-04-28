// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomResponse _$ChatRoomResponseFromJson(Map<String, dynamic> json) =>
    ChatRoomResponse(
      data: ChatRoom.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatRoomResponseToJson(ChatRoomResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
