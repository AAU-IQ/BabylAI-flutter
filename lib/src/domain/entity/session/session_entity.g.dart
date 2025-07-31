// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RootEntity _$RootEntityFromJson(Map<String, dynamic> json) => RootEntity(
      session:
          SessionEntity.fromJson(json['chatSession'] as Map<String, dynamic>),
      ablyToken: json['ablyToken'] as String,
    );

Map<String, dynamic> _$RootEntityToJson(RootEntity instance) =>
    <String, dynamic>{
      'chatSession': instance.session.toJson(),
      'ablyToken': instance.ablyToken,
    };

SessionEntity _$SessionEntityFromJson(Map<String, dynamic> json) =>
    SessionEntity(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      user: json['user'],
      assignedAgentId: json['assignedAgentId'] as String?,
      jumpedInByAgentId: json['jumpedInByAgentId'] as String?,
      tenantId: json['tenantId'] as String,
      assistantId: json['assistantId'] as String?,
      threadId: json['threadId'] as String?,
      helpScreenId: json['helpScreenId'] as String?,
      helpScreen: json['helpScreen'] == null
          ? null
          : HelpScreenEntity.fromJson(
              json['helpScreen'] as Map<String, dynamic>),
      optionId: json['optionId'] as String?,
      option: json['option'] == null
          ? null
          : Option.fromJson(json['option'] as Map<String, dynamic>),
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
      channel: (json['channel'] as num?)?.toInt(),
      externalId: json['externalId'],
      tags: json['tags'] as List<dynamic>?,
      agent: json['agent'],
      jumpedInByAgent: json['jumpedInByAgent'],
      closedByUser: json['closedByUser'],
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      assistant: json['assistant'] == null
          ? null
          : Assistant.fromJson(json['assistant'] as Map<String, dynamic>),
      messages: json['messages'] as List<dynamic>,
      review: json['review'],
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
      'helpScreen': instance.helpScreen?.toJson(),
      'optionId': instance.optionId,
      'option': instance.option?.toJson(),
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
      'channel': instance.channel,
      'externalId': instance.externalId,
      'tags': instance.tags,
      'agent': instance.agent,
      'jumpedInByAgent': instance.jumpedInByAgent,
      'closedByUser': instance.closedByUser,
      'tenant': instance.tenant?.toJson(),
      'assistant': instance.assistant?.toJson(),
      'messages': instance.messages,
      'review': instance.review,
    };
