// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionEntity _$SessionEntityFromJson(Map<String, dynamic> json) =>
    SessionEntity(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      user: json['user'],
      assignedAgentId: json['assignedAgentId'] as String?,
      jumpedInByAgentId: json['jumpedInByAgentId'] as String?,
      tenantId: json['tenantId'] as String,
      assistantId: json['assistantId'] as String,
      threadId: json['threadId'] as String?,
      helpScreenId: json['helpScreenId'] as String,
      optionId: json['optionId'] as String,
      status: (json['status'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      closedAt: json['closedAt'] as String?,
      closedByUserId: json['closedByUserId'] as String?,
      lastMessageAt: json['lastMessageAt'] as String,
      unreadAgentMessages: (json['unreadAgentMessages'] as num).toInt(),
      unreadCustomerMessages: (json['unreadCustomerMessages'] as num).toInt(),
      lastMessageContent: json['lastMessageContent'] as String?,
      escalatedAt: json['escalatedAt'] as String?,
      assignedAt: json['assignedAt'] as String?,
      jumpedInAt: json['jumpedInAt'] as String?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      agent: json['agent'],
      jumpedInByAgent: json['jumpedInByAgent'],
      closedByUser: json['closedByUser'],
      messages: json['messages'] as List<dynamic>,
    );

Map<String, dynamic> _$SessionEntityToJson(SessionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'user': instance.user,
      'assignedAgentId': instance.assignedAgentId,
      'jumpedInByAgentId': instance.jumpedInByAgentId,
      'tenantId': instance.tenantId,
      'assistantId': instance.assistantId,
      'threadId': instance.threadId,
      'helpScreenId': instance.helpScreenId,
      'optionId': instance.optionId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'closedAt': instance.closedAt,
      'closedByUserId': instance.closedByUserId,
      'lastMessageAt': instance.lastMessageAt,
      'unreadAgentMessages': instance.unreadAgentMessages,
      'unreadCustomerMessages': instance.unreadCustomerMessages,
      'lastMessageContent': instance.lastMessageContent,
      'escalatedAt': instance.escalatedAt,
      'assignedAt': instance.assignedAt,
      'jumpedInAt': instance.jumpedInAt,
      'tags': instance.tags,
      'agent': instance.agent,
      'jumpedInByAgent': instance.jumpedInByAgent,
      'closedByUser': instance.closedByUser,
      'messages': instance.messages,
    };
