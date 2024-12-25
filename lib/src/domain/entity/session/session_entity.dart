import 'package:json_annotation/json_annotation.dart';

part 'session_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class SessionEntity {
  final String id;
  final String customerId;
  final dynamic user;
  final String? assignedAgentId;
  final String? jumpedInByAgentId;
  final String tenantId;
  final String assistantId;
  final String? threadId;
  final String helpScreenId;
  final String optionId;
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
  final List<String> tags;
  final dynamic agent;
  final dynamic jumpedInByAgent;
  final dynamic closedByUser;
  final List<dynamic> messages;

  SessionEntity({
    required this.id,
    required this.customerId,
    required this.user,
    this.assignedAgentId,
    this.jumpedInByAgentId,
    required this.tenantId,
    required this.assistantId,
    this.threadId,
    required this.helpScreenId,
    required this.optionId,
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
    required this.tags,
    this.agent,
    this.jumpedInByAgent,
    this.closedByUser,
    required this.messages,
  });

  factory SessionEntity.fromJson(Map<String, dynamic> json) =>
      _$SessionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SessionEntityToJson(this);
}