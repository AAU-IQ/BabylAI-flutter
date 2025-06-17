import 'package:json_annotation/json_annotation.dart';

import '../help_screen_entity.dart';

part 'session_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class RootEntity {
  @JsonKey(name: 'chatSession')
  final SessionEntity session;
  final String ablyToken;

  RootEntity({
    required this.session,
    required this.ablyToken,
  });

  factory RootEntity.fromJson(Map<String, dynamic> json) =>
      _$RootEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RootEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SessionEntity {
  final String id;
  final String customerId;
  final dynamic user;
  final String? assignedAgentId;
  final String? jumpedInByAgentId;
  final String tenantId;
  final String? assistantId;
  final String? threadId;
  final String? helpScreenId;
  final HelpScreenEntity? helpScreen;
  final String? optionId;
  final Option? option;
  final int status;
  final String createdAt;
  final String? closedAt;
  final String? closedByUserId;
  final String lastMessageAt;
  final int unreadAgentMessages;
  final int unreadCustomerMessages;
  final String? lastMessageContent;
  final String? escalatedAt;
  final String? assignedAt;
  final String? jumpedInAt;
  final int? channel;
  final dynamic externalId;
  final List<dynamic> tags;
  final dynamic agent;
  final dynamic jumpedInByAgent;
  final dynamic closedByUser;
  final Tenant? tenant;
  final Assistant? assistant;
  final List<dynamic> messages;
  final dynamic review;

  SessionEntity({
    required this.id,
    required this.customerId,
    this.user,
    this.assignedAgentId,
    this.jumpedInByAgentId,
    required this.tenantId,
    this.assistantId,
    this.threadId,
    this.helpScreenId,
    this.helpScreen,
    this.optionId,
    this.option,
    required this.status,
    required this.createdAt,
    this.closedAt,
    this.closedByUserId,
    required this.lastMessageAt,
    required this.unreadAgentMessages,
    required this.unreadCustomerMessages,
    this.lastMessageContent,
    this.escalatedAt,
    this.assignedAt,
    this.jumpedInAt,
    this.channel,
    this.externalId,
    required this.tags,
    this.agent,
    this.jumpedInByAgent,
    this.closedByUser,
    this.tenant,
    this.assistant,
    required this.messages,
    this.review,
  });

  factory SessionEntity.fromJson(Map<String, dynamic> json) =>
      _$SessionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SessionEntityToJson(this);
}
