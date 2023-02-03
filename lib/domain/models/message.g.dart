// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      content: json['content'] as String,
      senderId: json['sender_id'] as int,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'content': instance.content,
      'sender_id': instance.senderId,
    };
