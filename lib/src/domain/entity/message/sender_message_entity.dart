import 'package:json_annotation/json_annotation.dart';

part 'sender_message_entity.g.dart';

@JsonSerializable()
class SenderMessageEntity {
  final String id;
  final String chatSessionId;
  final String? senderId;
  final int senderType;
  final String messageContent;
  final DateTime sentAt;
  final bool isSeen;
  final bool isAIResponse;
  final dynamic sender; // Replace `dynamic` with a specific type if the structure of `sender` is known.

  SenderMessageEntity({
    required this.id,
    required this.chatSessionId,
    this.senderId,
    required this.senderType,
    required this.messageContent,
    required this.sentAt,
    required this.isSeen,
    required this.isAIResponse,
    this.sender,
  });

  /// A factory constructor for parsing the JSON into the object
  factory SenderMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$SenderMessageEntityFromJson(json);

  /// A method to convert the object back into JSON
  Map<String, dynamic> toJson() => _$SenderMessageEntityToJson(this);
}