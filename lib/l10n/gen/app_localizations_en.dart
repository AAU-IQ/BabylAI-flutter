// ignore: unused_import
import 'package:intl/intl.dart' as intl;
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
  String get end_chat => 'Leaving so soon? 👋';

  @override
  String get end_chat_desc => 'Don\'t worry, you can come back anytime. We’re always here if you need help or have questions.';

  @override
  String get chat_button => 'Chat Now';

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

  @override
  String get error_message => 'There was a problem connecting to the service. Please check your connection and try again.';

  @override
  String get error_title => 'Unable to load content';

  @override
  String get try_again => 'Try Again';
}
