import 'package:babylai/babylai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppThemeData {
  static const _locale = '';
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
  themeData(lightColorScheme, _lightFocusColor, lightCustomColors);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor, darkCustomColors);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor, CustomColors customColors) {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10),
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      colorScheme: colorScheme,
      extensions: [customColors],
      textTheme: arTextTheme,
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.surface,
      disabledColor: colorScheme.onSurface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF8574EF),
    primaryContainer: Color(0xFF9e1718),
    secondary: Color(0xFFEFF3F3),
    secondaryContainer: Color(0xFFFAFBFB),
    surface: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF1c1b22),
    surfaceContainer: Color(0xFFf1ecf7),
    onInverseSurface: Color(0xFFf4eff7),
    outline: Color(0xFF787585),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF8574EF),
    primaryContainer: Color(0xFF1D1D20),
    secondary: Color(0xFF222226),
    secondaryContainer: Color(0xFF451B6F),
    surface: Color(0xFF18181B),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    surfaceContainer: Color(0xFF201f26),
    onInverseSurface: Color(0xFF313036),
    outline: Color(0xFF928e9f),
    brightness: Brightness.dark,
  );

  static const lightCustomColors = CustomColors(
    customerBubble: AppColors.lightCustomerBubble,
    agentBubble: AppColors.lightAgentBubble,
    aiBubble: AppColors.lightAiBubble,
  );

  static const darkCustomColors = CustomColors(
    customerBubble: AppColors.darkCustomerBubble,
    agentBubble: AppColors.darkAgentBubble,
    aiBubble: AppColors.darkAiBubble,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme arTextTheme = TextTheme(
    headlineMedium: GoogleFonts.rubik(fontWeight: _bold, fontSize: 20.0),
    bodySmall: GoogleFonts.rubik(fontWeight: _semiBold, fontSize: 16.0),
    headlineSmall: GoogleFonts.rubik(fontWeight: _medium, fontSize: 16.0),
    titleMedium: GoogleFonts.rubik(fontWeight: _medium, fontSize: 16.0),
    labelSmall: GoogleFonts.rubik(fontWeight: _medium, fontSize: 12.0),
    bodyLarge: GoogleFonts.rubik(fontWeight: _regular, fontSize: 14.0),
    titleSmall: GoogleFonts.rubik(fontWeight: _medium, fontSize: 14.0),
    bodyMedium: GoogleFonts.rubik(fontWeight: _regular, fontSize: 16.0),
    titleLarge: GoogleFonts.rubik(fontWeight: _bold, fontSize: 16.0),
    labelLarge: GoogleFonts.rubik(fontWeight: _semiBold, fontSize: 14.0),
    labelMedium: GoogleFonts.rubik(fontWeight: _regular, fontSize: 18.0)
  );

  static final TextTheme _textTheme = TextTheme(
      headlineMedium: GoogleFonts.roboto(fontWeight: _bold, fontSize: 20.0),
      bodySmall: GoogleFonts.roboto(fontWeight: _semiBold, fontSize: 16.0),
      headlineSmall: GoogleFonts.roboto(fontWeight: _medium, fontSize: 16.0),
      titleMedium: GoogleFonts.roboto(fontWeight: _medium, fontSize: 16.0),
      labelSmall: GoogleFonts.roboto(fontWeight: _medium, fontSize: 12.0),
      bodyLarge: GoogleFonts.roboto(fontWeight: _regular, fontSize: 14.0),
      titleSmall: GoogleFonts.roboto(fontWeight: _medium, fontSize: 14.0),
      bodyMedium: GoogleFonts.roboto(fontWeight: _regular, fontSize: 16.0),
      titleLarge: GoogleFonts.roboto(fontWeight: _bold, fontSize: 16.0),
      labelLarge: GoogleFonts.roboto(fontWeight: _semiBold, fontSize: 14.0),
      labelMedium: GoogleFonts.roboto(fontWeight: _regular, fontSize: 18.0)
  );
}