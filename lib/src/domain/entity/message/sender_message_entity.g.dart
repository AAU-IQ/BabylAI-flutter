// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender_message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SenderMessageEntity _$SenderMessageEntityFromJson(Map<String, dynamic> json) =>
    SenderMessageEntity(
      id: json['id'] as String,
      chatSessionId: json['chatSessionId'] as String,
      senderId: json['senderId'] as String?,
      senderType: (json['senderType'] as num).toInt(),
      messageContent: json['messageContent'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      isSeen: json['isSeen'] as bool,
      isAIResponse: json['isAIResponse'] as bool,
      sender: json['sender'],
    );

Map<String, dynamic> _$SenderMessageEntityToJson(
        SenderMessageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatSessionId': instance.chatSessionId,
      'senderId': instance.senderId,
      'senderType': instance.senderType,
      'messageContent': instance.messageContent,
      'sentAt': instance.sentAt.toIso8601String(),
      'isSeen': instance.isSeen,
      'isAIResponse': instance.isAIResponse,
      'sender': instance.sender,
    };
