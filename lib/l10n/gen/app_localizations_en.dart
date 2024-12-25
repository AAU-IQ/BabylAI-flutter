import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Help Center';

  @override
  String get message_input_hint => 'Ask something...';

  @override
  String get end_chat => 'End Chat';

  @override
  String get end_chat_desc => 'Are you sure you want to end the chat session?';

  @override
  String get chat_button => 'Chat with us';

  @override
  String get ai_loading => 'Ai is thinking...';

  @override
  String get active_chat => 'Active Chat';

  @override
  String get active_chat_desc => 'You already have an active chat, do you want to close it?';

  @override
  String get close => 'Close';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';
}
