library babylai;

import 'package:babylai/src/di/service_locator.dart';
import 'package:babylai/src/presentation/chat_screen/chat_screen.dart';
import 'package:babylai/src/presentation/chat_screen/store/chat_screen_store.dart';
import 'package:babylai/src/presentation/help_screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';


class BabylAI {

  static late ChatScreenStore _chatScreenStore;
  static Function(String)? _onMessageReceived;
  static late BuildContext _context;
  static late String _locale;
  static late ThemeMode? _theme;

  static void _inject() async {
    try {
      await ServiceLocator.configureDependencies();
      _chatScreenStore = getIt<ChatScreenStore>();
    } catch (error) {

    }
  }

  static void config() {
    _inject();
  }

  static void lauchActiveChat() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => StartScreen(
          locale: _locale,
          theme: _theme,
          directChat: true,
          onBack: () {
            Navigator.of(_context).pop();
          },
        ),
      ),
    );
  }

  static void launch(
      String locale,
      ThemeMode? theme,
      BuildContext context, {
        Function(String)? onMessageReceived,
      }) {
    _context = context;
    _onMessageReceived = onMessageReceived;
    _locale = locale;
    _theme = theme;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartScreen(
          locale: locale,
          theme: theme,
          onBack: () {
            Navigator.of(_context).pop();
          },
        ),
      ),
    );

    _chatScreenStore.onMessageReceivedCallback = (message) {
      _onMessageReceived?.call(message);
    };
  }

}