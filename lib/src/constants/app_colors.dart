import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const lightCustomerBubble = Color(0xFFF2F2F2);
  static const lightAgentBubble = Color(0x4D90CAF9);
  static const lightAiBubble = Color(0x148948DF);

  static const darkCustomerBubble = Color(0xFF2E2E30); // Slightly lighter gray
  static const darkAgentBubble = Color(0xFF5A8BCF); // Darker, more saturated blue
  static const darkAiBubble = Color(0x807239A6); // Vibrant purple
}

class CustomColors extends ThemeExtension<CustomColors> {
  final Color customerBubble;
  final Color agentBubble;
  final Color aiBubble;

  const CustomColors({
    required this.customerBubble,
    required this.agentBubble,
    required this.aiBubble,
  });

  @override
  CustomColors copyWith({
    Color? customerBubble,
    Color? agentBubble,
    Color? aiBubble,
  }) {
    return CustomColors(
      customerBubble: customerBubble ?? this.customerBubble,
      agentBubble: agentBubble ?? this.agentBubble,
      aiBubble: aiBubble ?? this.aiBubble,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      customerBubble: Color.lerp(customerBubble, other.customerBubble, t)!,
      agentBubble: Color.lerp(agentBubble, other.agentBubble, t)!,
      aiBubble: Color.lerp(aiBubble, other.aiBubble, t)!,
    );
  }
}