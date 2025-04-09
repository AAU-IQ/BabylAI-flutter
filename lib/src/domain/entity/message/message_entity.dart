import 'dart:ui';

import 'package:babylai/gen/assets.gen.dart';
import 'package:babylai/src/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageEntity {
  final String text;
  final SenderType senderType;
  final bool needsAgent;
  final DateTime time;
  final bool isSentByUser;

  MessageEntity({
    required this.text,
    required this.senderType,
    required this.needsAgent,
    required this.isSentByUser,
    DateTime? time,
  }) : time = time ?? DateTime.now();

  String get iconName {
    switch (senderType) {
      case SenderType.ai:
        return Assets.lib.assets.svg.logo;
      case SenderType.agent:
        return Assets.lib.assets.svg.person;
      case SenderType.customer:
        return 'customer';
    }
  }

  // Return the color as a string
  Color getMessageBubbleColor(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    switch (senderType) {
      case SenderType.ai:
        return Theme.of(context).colorScheme.primaryContainer;
      case SenderType.agent:
        return Theme.of(context).colorScheme.primaryContainer;
      case SenderType.customer:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Color getColor(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    switch (senderType) {
      case SenderType.ai:
        return Theme.of(context).colorScheme.primary;
      case SenderType.agent:
        return Theme.of(context).colorScheme.primaryContainer;
      case SenderType.customer:
        return customColors.customerBubble;
    }
  }

}

enum SenderType {
  customer, // 1
  agent,    // 2
  ai        // 3
}

extension SenderTypeExtension on SenderType {
  static SenderType fromInt(int value) {
    switch (value) {
      case 1:
        return SenderType.customer;
      case 2:
        return SenderType.agent;
      case 3:
        return SenderType.ai;
      default:
        throw ArgumentError("Invalid sender type value: $value");
    }
  }
}