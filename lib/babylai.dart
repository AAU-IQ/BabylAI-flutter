library babylai;

import 'package:babylai/src/di/service_locator.dart';
import 'package:babylai/src/presentation/help_screen/start_screen.dart';
import 'package:flutter/material.dart';

class BabylAI {

  static String _locale = '';
  static ThemeMode? _theme;

  static void config(String locale, ThemeMode? theme) {
    _locale = locale;
    _theme = theme;
    try {
      ServiceLocator.configureDependencies();
    } catch (error) {
      print('error');
    }
  }

  static void launch(BuildContext context) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartScreen(locale: _locale, theme: _theme,),
      ),
    );
  }

}