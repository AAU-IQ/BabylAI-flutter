library babylai;

import 'package:babylai/src/di/service_locator.dart';
import 'package:babylai/src/presentation/help_screen/start_screen.dart';
import 'package:flutter/material.dart';

class BabylAI {

  static String currentLang = 'ar';

  static void config() {
    try {
      ServiceLocator.configureDependencies();
    } catch (error) {
      print('error');
    }
  }

  static void launch(BuildContext context, String language, ThemeMode? theme) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartScreen(locale: language, theme: theme,),
      ),
    );
  }

}