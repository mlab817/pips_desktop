// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createmessage_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMessageResponse _$CreateMessageResponseFromJson(
        Map<String, dynamic> json) =>
    CreateMessageResponse(
      id: json['id'] as int,
      content: json['content'] as String,
      chatRoomId: json['chat_room_id'] as int,
      senderId: json['sender_id'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$CreateMessageResponseToJson(
        CreateMessageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'chat_room_id': instance.chatRoomId,
      'sender_id': instance.senderId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
